if SERVER then

  local plymeta = FindMetaTable("Player")

  util.AddNetworkString("ttt2_net_show_haunt_popup")

  function plymeta:IsHaunted()
    if self.hauntedBy then
      return true
    else
      return false
    end
  end

  function sendPopups(id)
    local declare_mode = GetConVar("ttt2_spectre_declare_mode"):GetInt()
    local msg_plys = {}

    for _, ply in ipairs(player.GetAll()) do
      if declare_mode == 0 then
        return
      elseif declare_mode == 1 then
        msg_plys[#msg_plys + 1] = ply
      elseif declare_mode == 2 then
        if ply:GetBaseRole() == ROLE_DETECTIVE then
          msg_plys[#msg_plys + 1] = ply
        end
      end
    end
    for v, ply in ipairs(msg_plys) do
      net.Start("ttt2_net_show_haunt_popup")
      net.WriteString(id)
      net.WriteBool(true)
      net.Send(ply)
      timer.Simple(5, function(ply)
        if IsValid(ply) then
          net.Start("ttt2_net_show_haunt_popup")
          net.WriteString(id)
          net.WriteBool(false)
          net.Send(ply)
        end
      end)
    end
  end

  hook.Add("DoPlayerDeath", "SpectreKilled", function(ply, attacker, dmgInfo)
    if not IsValid(ply) or not IsValid(attacker) or not attacker:IsPlayer() then return end
    if SpecDM and (ply:IsGhost() or attacker:IsGhost()) then return end
    if GetRoundState() ~= ROUND_ACTIVE then return end
    if ply == attacker then return end

    if ply:GetSubRole() == ROLE_SPECTRE then
      print(ply:Nick() .. " is now haunting " .. attacker:Nick())
      attacker.hauntedBy = tostring(ply:AccountID())
      STATUS:AddStatus(attacker, "spectre_haunt_status")
      events.Trigger(EVENT_SPR_HAUNT, ply, attacker, dmgInfo)
      sendPopups("spectreDied")
      net.Start("ttt2_net_show_haunt_popup")
      net.WriteString("spectreDied_self")
      net.WriteBool(true)
      net.WriteEntity(attacker)
      net.Send(ply)
      timer.Simple(5, function(ply)
        if IsValid(ply) then
          net.Start("ttt2_net_show_haunt_popup")
          net.WriteString("spectreDied_self")
          net.WriteBool(false)
          net.Send(ply)
        end
      end)
      if GetConVar("ttt2_spectre_smoke_mode"):GetBool() then
        attacker:SetNWBool("Haunted", true)
      end
      SendFullStateUpdate()
      -- print(attacker.hauntedBy)
    end
  end)

  hook.Add("PostPlayerDeath", "HauntedKilled", function(ply)
    if not ply:IsHaunted() or not IsValid(ply) then return end

    for _, pl in ipairs(player.GetAll()) do
      if tostring(pl:AccountID()) == ply.hauntedBy then
        haunter = pl
      end
    end
    -- local haunter = player.GetByID(ply.hauntedBy)
    if not IsValid(haunter) then
      print("Error haunter not found")
      return
    end

    if haunter:GetSubRole() ~= ROLE_SPECTRE then return end

    local spectre_worldspawn = GetConVar("ttt2_spectre_worldspawn"):GetBool()

    local spawnpoint = plyspawn.GetRandomSafePlayerSpawnPoint(haunter)

    haunter:Revive(
      0,
      function()
        if spectre_worldspawn and spawnpoint then
          haunter:SetPos(spawnpoint.pos)
        end
        haunter:SetHealth(GetConVar("ttt2_spectre_revive_health"):GetInt())
        ply.hauntedBy = nil
        ply:SetNWBool("Haunted", false)
        STATUS:RemoveStatus(ply, "spectre_haunt_status")
        haunter:ResetConfirmPlayer()
        events.Trigger(EVENT_SPR_REVIVE, haunter)
        SendFullStateUpdate()
        sendPopups("spectreRevived")
      end,
      nil,
      false,
      true
    )
  end)

  function ResetSpectre()
    for _, ply in ipairs(player.GetAll()) do
      ply.hauntedBy = nil
      ply:SetNWBool("Haunted", false)
      SendFullStateUpdate()
    end
  end

  hook.Add("TTTPrepRound", "ResetSpectre", ResetSpectre)
  hook.Add("TTTBeginRound", "ResetSpectre", ResetSpectre)
  hook.Add("TTTEndRound", "ResetSpectre", ResetSpectre)
end

if CLIENT then
  hook.Add("Initialize", "SpectreInitStatus", function()
    STATUS:RegisterStatus("spectre_haunt_status", {
      hud = Material("vgui/ttt/dynamic/roles/icon_spr.vmt"),
      type = "bad"
    })
  end)

  function DoSmoke()
    for _, ply in ipairs(player.GetAll()) do
      if ply:Alive() and ply:GetNWBool("Haunted") and GetConVar("ttt2_spectre_smoke_mode"):GetBool() then
        if not ply.SmokeEmitter then ply.SmokeEmitter = ParticleEmitter(ply:GetPos()) end
        if not ply.SmokeNextPart then ply.SmokeNextPart = CurTime() end
        local pos = ply:GetPos() + Vector(0, 0, 30)
        local client = LocalPlayer()
        if ply.SmokeNextPart < CurTime() then
          if client:GetPos():Distance(pos) > 1000 then return end
          ply.SmokeEmitter:SetPos(pos)
          ply.SmokeNextPart = CurTime() + math.Rand(0.003, 0.01)
          local vec = Vector(math.Rand(-8, 8), math.Rand(-8, 8), math.Rand(10, 55))
          pos = ply:LocalToWorld(vec)
          local particle = ply.SmokeEmitter:Add("particle/snow.vmt", pos)
          particle:SetVelocity(Vector(0, 0, 4) + VectorRand() * 3)
          particle:SetDieTime(math.Rand(0.2, 2))
          particle:SetStartAlpha(math.random(80, 255))
          particle:SetEndAlpha(0)
          local size = math.random(4, 7)
          particle:SetStartSize(size)
          particle:SetEndSize(size + 1 * (-1 ^ math.random(1, 2)))
          particle:SetRoll(0)
          particle:SetRollDelta(0)
          particle:SetColor(46, 46, 46)
        end
      else
        if ply.SmokeEmitter then
          ply.SmokeEmitter:Finish()
          ply.SmokeEmitter = nil
        end
      end
    end
  end

  hook.Add("Think", "DoHauntSmoke", function()
    if not GetConVar("ttt2_spectre_smoke_mode"):GetBool() then return end
    DoSmoke()
  end)

  function ResetSpectreClient()
    for _, ply in ipairs(player.GetAll()) do
      ply:SetNWBool("Haunted", false)
      if ply.hauntedBy then ply.hauntedBy = nil end
    end
  end

  hook.Add("TTTEndRound", "ClearHauntSmoke", ResetSpectreClient)
  hook.Add("TTTPrepRound", "ResetSpectreClient", ResetSpectreClient)
  hook.Add("TTTBeginRound", "ResetSpectreClient", ResetSpectreClient)

  net.Receive("ttt2_net_show_haunt_popup", function()
    local client = LocalPlayer()
    client.epopId = client.epopId or {}

    local id = net.ReadString()
    local shouldAdd = net.ReadBool()

    if shouldAdd then
      if id == "spectreDied" then
        client.epopId[id] = EPOP:AddMessage(
          {
            text = LANG.GetTranslation("ttt2_spectre_killed_title"),
            color = SPECTRE.ltcolor
          },
          LANG.GetTranslation("ttt2_spectre_killed_text"),
          6
        )
      elseif id == "spectreDied_self" then
        local killer = net.ReadEntity()
        local killer_nick = killer:Nick()
        client.epopId[id] = EPOP:AddMessage(
          {
            text = LANG.GetParamTranslation("ttt2_spectre_self_title", {nick = killer_nick}),
            color = SPECTRE.ltcolor
          },
          LANG.GetTranslation("ttt2_spectre_self_text")
        )
      elseif id == "spectreRevived" then
        client.epopId[id] = EPOP:AddMessage(
          {
            text = LANG.GetTranslation("ttt2_spectre_revived"),
            color = SPECTRE.ltcolor
          },
          LANG.GetTranslation("ttt2_spectre_revived_text")
        )
      end
    else
      if client.epopId[id] then
        EPOP:RemoveMessage(client.epopId[id])
      end
    end
  end)
end

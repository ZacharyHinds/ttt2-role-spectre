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

  hook.Add("PostPlayerDeath", "SpectreKilled", function(ply)
    if not IsValid(ply) then return end
    local attacker = ply.targetAttacker

    if ply:GetSubRole() == ROLE_SPECTRE then
      print(ply:Nick() .. " is now haunting ".. attacker:Nick())
      attacker.hauntedBy = tostring(ply:AccountID())
      if GetConVar("ttt2_spectre_smoke_mode"):GetBool() then
        attacker:SetNWBool("Haunted", true)
      end
      SendFullStateUpdate()
      print(attacker.hauntedBy)
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

    haunter:Revive(
      0,
      function()
        haunter:SetHealth(GetConVar("ttt2_spectre_revive_health"):GetInt())
        ply.hauntedBy = nil
        ply:SetNWBool("Haunted", false)
        SendFullStateUpdate()
      end,
      nil,
      false,
      true
    )
  end)

  hook.Add("TTTEndRound", "ClearHaunt", function()
    for _, ply in ipairs(player.GetAll()) do
      ply.hauntedBy = nil
      ply:SetNWBool("Haunted", false)
      SendFullStateUpdate()
    end
  end)

  hook.Add("TTTPrepRound", "DoubleClearHaunt", function()
    for _, ply in ipairs(player.GetAll()) do
      ply.hauntedBy = nil
      ply:SetNWBool("Haunted", false)
      SendFullStateUpdate()
    end
  end)
end

if CLIENT then
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
          local pos = ply:LocalToWorld(vec)
          local particle = ply.SmokeEmitter:Add("particle/snow.vmt", pos)
          particle:SetVelocity(Vector(0, 0, 4) + VectorRand() * 3)
          particle:SetDieTime(math.Rand(0.5, 2))
          particle:SetStartAlpha(math.random(150, 220))
          particle:SetEndAlpha(0)
          local size = math.random(4, 7)
          particle:SetStartSize(size)
          particle:SetEndSize(size + 1)
          particle:SetRoll(0)
          particle:SetRollDelta(0)
          particle:SetColor(0, 0, 0)
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
  hook.Add("TTTEndRound", "ClearHauntSmoke", function()
    for _, ply in ipairs(player.GetAll()) do
      if ply:GetNWBool("Haunted", true) then ply:SetNWBool("Haunted", false) end
    end
  end)
end

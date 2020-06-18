SPECTRE_DATA = {}
SPECTRE_DATA.haunter = {}
SPECTRE_DATA.haunted = {}

if CLIENT then
  SPECTRE_DATA.local_spectre = {}

  net.Receive("ttt2_role_spectre_haunt", function()
    local new_haunt = net.ReadEntity()
    if not new_haunt or not new_haunt:IsPlayer() then return end

    local new_haunt_id = tostring(new_haunt:SteamID64() or new_haunt:EntIndex())
    SPECTRE_DATA.haunted[new_haunt_id] = true
  end)

  net.Receive("ttt2_role_spectre_haunter", function()
    local new_haunter = net.ReadEntity()
    if not new_haunter or not new_haunter:IsPlayer() then return end

    local  new_haunter_id = tostring(new_haunter:SteamID64() or new_haunter:EntIndex())
    SPECTRE_DATA.haunter[new_haunter_id] = true
  end)

  net.Receive("ttt2_role_spectre_remove_haunt", function()
    local rem_haunt = net.ReadEntity()
    if not rem_haunt or not rem_haunt:IsPlayer() then return end

    local rem_haunt_id = tostring(rem_haunt:SteamID64() or rem_haunt:EntIndex())
    SPECTRE_DATA.haunted[rem_haunt_id] = nil
  end)

  net.Receive("ttt2_role_spectre_remove_haunter", function()
    local rem_haunter = net.ReadEntity()
    if not rem_haunter or not rem_haunter:IsPlayer() then return end

    local rem_haunter_id = tostring(rem_haunter:SteamID64() or rem_haunter:EntIndex())
    SPECTRE_DATA.haunter[rem_haunter_id] = nil
  end)

  net.Receive("ttt2_role_spectre_clear_haunt", function()
    SPECTRE_DATA.haunted = {}
  end)

  net.Receive("ttt2_role_specte_clear_haunter", function()
    SPECTRE_DATA.haunter = {}
  end)
end

if SERVER then
  util.AddNetworkString("ttt2_role_spectre_haunt")
  util.AddNetworkString("ttt2_role_spectre_haunter")
  util.AddNetworkString("ttt2_role_spectre_remove_haunt")
  util.AddNetworkString("ttt2_role_spectre_clear_haunt")
  util.AddNetworkString("ttt2_role_specte_clear_haunter")

  function SPECTRE_DATA:ClearHaunt()
    self.haunted = {}
    print("Haunted cleared")

    net.Start("ttt2_role_spectre_clear_haunt")
    net.Send(player.GetAll())
  end

  function SPECTRE_DATA:ClearHaunter()
    self.haunter = {}
    print("Haunters Cleared")

    net.Start("ttt2_role_specte_clear_haunter")
    net.Send(player.GetAll())
  end

  function SPECTRE_DATA:NewHaunt(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    self.haunted[tostring(ply:SteamID64() or ply:EntIndex())] = true
    print(ply:Nick().."is now haunted!")

    net.Start("ttt2_role_spectre_haunt")
    net.WriteEntity(ply)
    net.Send(player.GetAll())
  end

  function SPECTRE_DATA:NewHaunter(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end

    self.haunter[tostring(ply:SteamID64() or ply:EntIndex())] = true
    print(ply:Nick().." is now haunting!")

    net.Start("ttt2_role_spectre_haunter")
    net.WriteEntity(ply)
    net.Send(player.GetAll())
  end

  function SPECTRE_DATA:RemoveHaunt(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if not self:IsHaunt(ply) then return end

    self.haunted[tostring(ply:SteamID64() or ply:EntIndex())] = nil
    net.Start("ttt2_role_spectre_remove_haunt")
    net.WriteEntity(ply)
    net.Send(player.GetAll())
  end

  function SPECTRE_DATA:RemoveHaunter(ply)
    if not IsValid(ply) or not ply:IsPlayer() then return end
    if not self:IsHaunter(ply) then return end

    self.haunter[tostring(ply:SteamID64() or ply:EntIndex())] = nil
    net.Start("ttt2_role_spectre_remove_haunter")
    net.WriteEntity(ply)
    net.Send(player.GetAll())
  end

  function SPECTRE_DATA:DeathDeclaration()
    local dec_mode = GetConVar("ttt2_spectre_declare_mode"):GetInt()

    if dec_mode == 1 then
      LANG.MsgAll("ttt2_spectre_killed", MSG_MSTACK_WARN)
    elseif dec_mode == 2 then
      for _, ply in ipairs(player.GetAll()) do
        if ply:GetBaseRole() == ROLE_DETECTIVE then
          LANG.Msg("ttt2_spectre_killed", MSG_MSTACK_WARN)
        end
      end
    end
  end

  function SPECTRE_DATA:RebirthDeclaration()
    local dec_mode = GetConVar("ttt2_spectre_declare_mode"):GetInt()

    if dec_mode == 1 then
      LANG.MsgAll("ttt2_spectre_revived", MSG_MSTACK_WARN)
    elseif dec_mode == 2 then
      for _, ply in ipairs(player.GetAll()) do
        if ply:GetBaseRole() == ROLE_DETECTIVE then
          LANG.Msg("ttt2_spectre_revived", MSG_MSTACK_WARN)
        end
      end
    end
  end

  function SPECTRE_DATA:SpectreKilled(ply, attacker)
    if not ply or not ply:IsPlayer() or not attacker or not attacker:IsPlayer() then return end
    if ply:SteamID64() == attacker:SteamID64() or ply:EntIndex() == attacker:EntIndex() then return end
    if not ply:GetSubRole() == ROLE_SPECTRE then return end
    print(ply:Nick().." is now haunting "..attacker:Nick())
    self:DeathDeclaration()
    self:NewHaunter(ply)
    self:NewHaunt(attacker)
  end

  function checkSpectre(ply)
    if not ply or not IsValid(ply) or not ply:IsPlayer() then return end

    local attacker = ply.targetAttacker

    if ply:GetSubRole() == ROLE_SPECTRE then
      SPECTRE_DATA:SpectreKilled(ply, attacker)
    end
  end

  hook.Add("PostPlayerDeath", "SpectreKilled", checkSpectre)

  function SPECTRE_DATA:ReviveSpectre()
    print("Beginning revive process")
    -- if not self:AnyHaunt() then return end
    -- print("Haunts found!")
    local revive_health = GetConVar("ttt2_spectre_revive_health"):GetInt()

    for _, ply in ipairs(player.GetAll()) do
      print(ply:Nick()..": Checking haunt status...")
      if self:IsHaunter(ply) then
        print(ply:Nick().." is reviving!")
        self:RebirthDeclaration()
        ply:Revive(
        revive_health,
        function(ply)
          timer.Simple(0.1, function()
            ply:SetHealth(50)
          end)
        end,
        nil,
        false,
        true
        )
        print(ply:Nick().." Has Revived")
        self:RemoveHaunter(ply)
        return true
      else
        print(ply:Nick().." is not haunting!")
      end
    end
  end

  function SPECTRE_DATA:HauntedKilled(ply)
    if not ply or not ply:IsPlayer() then return end

    if self:IsHaunt(ply) then
      self:ReviveSpectre()
      print(ply:Nick().." has died, those haunting them will revive!")
      self:RemoveHaunt(ply)
    end
  end

  function SPECTRE_DATA:FullClear()
    self:ClearHaunt()
    self:ClearHaunter()
  end

  hook.Add("PostPlayerDeath", "HauntedPlayerDied", function(ply)
    SPECTRE_DATA:HauntedKilled(ply)
  end)

  hook.Add("TTTEndRound", "ResetHaunting", function()
     SPECTRE_DATA:FullClear()
  end)
end

function SPECTRE_DATA:AnyHaunt(ply)
  for _, haunt in ipairs(self.haunted) do
    if haunt == true then return true
  end
  return false end
end

function SPECTRE_DATA:IsHaunt(ply)
  if not IsValid(ply) or not ply:IsPlayer() then return false end
  if not isfunction(ply.SteamID64) and not isfunction(ply.EntIndex) then return false end

  return self.haunted[tostring(ply:SteamID64() or ply:EntIndex())] or false
end

function SPECTRE_DATA:IsHaunter(ply)
  if not IsValid(ply) or not ply:IsPlayer() then return false end
  if not isfunction(ply.SteamID64) and not isfunction(ply.EntIndex) then return false end

  return self.haunter[tostring(ply:SteamID64() or ply:EntIndex())] or false
end

--TODO smoke effect

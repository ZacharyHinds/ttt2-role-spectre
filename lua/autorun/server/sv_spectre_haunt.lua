local function GetHauntedPlayer(ply)
  if not IsValid(ply) or ply:GetSubRole() ~= ROLE_SPECTRE then return end

  local haunted = ply:GetTargetPlayer()

  if IsValid(haunted) and haunted:Alive() then
    return haunted
  end
end

local function GetSpectre()
  for _, ply in ipairs(player.GetAll()) do
    if IsValid(ply) and ply:GetSubRole == ROLE_SPECTRE then
      return ply
    end
  end
end

local function ClearHaunt(ply)
  if not IsValid(ply) or ply:GetSubRole() ~= ROLE_SPECTRE then return end

  ply:SetTargetPlayer(nil)
end

local function SpecrtreRevive(ply)
  if not IsValid(ply) or ply:IsAlive(), or ply:GetSubRole() ~= ROLE_SPECTRE then return end

  ply:Revive(
    0,
    ClearHaunt,
    nil,
    false,
    true
  )
end

local function SpectreDied(ply)
  local attacker = ply.targetAttacker

  if IsValid(attacker) and ply:GetSubRole() == ROLE_SPECTRE then
    ply:SetTargetPlayer(attacker)
  end
end
hook.Add("PostPlayerDeath", "SpectreDied", SpectreDied)



local function HauntedPlayerDied(ply)
  local haunter = GetSpectre()
  if haunter:GetTargetPlayer() == ply and not haunter:IsAlive() then
    SpectreRevive(haunter)
  end
end
hook.Add("PostPlayerDeath", "HauntedDied", HauntedPlayerDied)

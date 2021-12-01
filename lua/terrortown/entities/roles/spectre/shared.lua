CreateConVar("ttt2_spectre_declare_mode", 2, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spectre_revive_health", 50, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spectre_smoke_mode", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spectre_worldspawn", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY})

AddCSLuaFile()

if SERVER then
  resource.AddFile("materials/vgui/ttt/dynamic/roles/icon_spr.vmt")
end

function ROLE:PreInitialize()
  self.color = Color(26, 188, 156, 255)

  self.abbr = "spr" -- abbreviation
  self.surviveBonus = 0 -- bonus multiplier for every survive while another player was killed
  self.scoreKillsMultiplier = 1 -- multiplier for kill of player of another team
  self.scoreTeamKillsMultiplier = -8 -- multiplier for teamkill
  self.unknownTeam = true -- player don't know their teammates

  self.defaultTeam = TEAM_INNOCENT -- the team name: roles with same team name are working together
  self.defaultEquipment = SPECIAL_EQUIPMENT -- here you can set up your own default equipment

  self.conVarData = {
    pct = 0.15, -- necessary: percentage of getting this role selected (per player)
    maximum = 1, -- maximum amount of roles in a round
    minPlayers = 6, -- minimum amount of players until this role is able to get selected
    togglable = true, -- option to toggle a role for a client if possible (F1 menu)
  }
end

function ROLE:Initialize()
  roles.SetBaseRole(self, ROLE_INNOCENT)
end

if CLIENT then
  hook.Add("TTT2FinishedLoading", "mes_devicon", function() -- addon developer emblem for me ^_^
    AddTTT2AddonDev("76561198049910438")
  end)

  function ROLE:AddToSettingsMenu(parent)
    local form = vgui.CreateTTT2Form(parent, "header_roles_additional")

    form:MakeSlider({
      serverConvar = "ttt2_spectre_revive_health",
      label = "label_ttt2_spectre_revive_health",
      min = 1,
      max = 100,
      decimal = 0
    })

    form:MakeHelp({
      label = "label_ttt2_spectre_declare_mode_info"
    })

    form:MakeSlider({
      serverConvar = "ttt2_spectre_declare_mode",
      label = "label_ttt2_spectre_declare_mode",
      min = 0,
      max = 2,
      decimal = 0
    })

    form:MakeCheckBox({
      serverConvar = "ttt2_spectre_smoke_mode",
      label = "label_ttt2_spectre_smoke_mode"
    })

    form:MakeCheckBox({
      serverConvar = "ttt2_spectre_worldspawn",
      label = "label_ttt2_spectre_worldspawn"
    })
  end
end

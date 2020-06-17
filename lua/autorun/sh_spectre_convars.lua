CreateConVar("ttt2_spectre_declare_mode", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spectre_revive_health", 50, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spectre_revive_delay", 0, {FCVAR_ARCHIVE, FCVAR_NOTIFY})
CreateConVar("ttt2_spectre_smoke_enable", 1, {FCVAR_ARCHIVE, FCVAR_NOTIFY})

hook.Add("TTTUlxDynamicRCVars", "ttt2_ulx_spectre_dynamic_convars", function(tbl)
  tbl[ROLE_SPECTRE] = tbl[ROLE_SPECTRE] or {}

  table.insert(tbl[ROLE_SPECTRE], {
    cvar = "ttt2_spectre_smoke_enable",
    checkbox = true,
    desc = "ttt2_spectre_smoke_enable (def. 1)"
  })

  table.insert(tbl[ROLE_SPECTRE], {
    cvar = "ttt2_spectre_revive_health",
    slider = true,
    min = 1,
    max = 100,
    decimal = 0,
    desc = "ttt2_spectre_revive_health (def. 50)"
  })

  table.insert(tbl[ROLE_SPECTRE], {
    cvar = "ttt2_spectre_revive_delay",
    slider = true,
    min = 0,
    max = 30,
    decimal = 0,
    desc = "ttt2_spectre_revive_delay (def. 0)"
  })

  table.insert(tbl[ROLE_SPECTRE], {
    cvar = "ttt2_spectre_declare_mode",
    slider = true,
    min = 0,
    max = 2,
    desc = "ttt2_spectre_declare_mode (def. 1) \n 0. Don't declare spectre's death \n 1. Declare spectre's death to everyone \n 2. Declare spectre's death to detective(s)"
  })
end)

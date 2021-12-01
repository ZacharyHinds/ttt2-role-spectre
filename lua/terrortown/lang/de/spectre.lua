L = LANG.GetLanguageTableReference("de")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPECTRE.name] = "Gespenst"
L["info_popup_" .. SPECTRE.name] = [[Du bist ein Gespenst! Du wirst deinen Mörder verfolgen!]]
L["body_found_" .. SPECTRE.abbr] = "Er war ein Gespenst!"
L["search_role_" .. SPECTRE.abbr] = "Diese Person war ein Gespenst!"
L["target_" .. SPECTRE.name] = "Gespenst"
L["ttt2_desc_" .. SPECTRE.name] = [[Das Gespenst ist ein Unschuldiger, der wieder belebt wird, nachdem sein Mörder gestorben ist.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_spectre_killed_title"] = "Das Gespenst wurde getötet!"
L["ttt2_spectre_killed_text"] = "Sei wachsam!"
L["ttt2_spectre_revived"] = "Das Gespenst wurde wiederbelebt!"
L["ttt2_spectre_revived_text"] = "Deren Mörder ist gestorben, daher wurde er wiederbelebt!"
L["ttt2_spectre_self_title"] = "Du verfolgst {nick}"
L["ttt2_spectre_self_text"] = "Du wirst wiederbelebt, wenn er stirbt"

-- DECLARATION MODE LANGS
L["ttt2_role_spectre_dec_state_0"] = "Kündige nicht an, dass das Gespenst gestorben ist"
L["ttt2_role_spectre_dec_state_1"] = "Kündige den Tod des Gespenstes jedem Spieler an"
L["ttt2_role_spectre_dec_state_2"] = "Kündige den Tod des Gespenstes Detektiven an"

-- --EVENT STRINGS
-- L["title_spr_haunt"] = "A Spectre was killed."
-- L["desc_spr_haunt"] = "{victim} haunted {attacker}."
-- L["tooltip_spr_haunt_score"] = "Killed a Spectre: {score}"
-- L["title_spr_revive"] = "A Spectre revived."
-- L["desc_spr_revive"] = "{spectre} respawned."

-- --SETTINGS STRINGS
-- L["label_ttt2_spectre_revive_health"] = "Health after revive"
-- L["label_ttt2_spectre_declare_mode_info"] = [[Select the mode you want to use for declaring the Spectre's death.
-- 0 - Don't declare that the Spectre has died.
-- 1 - Declare that the Spectre has died to every player.
-- 2 - Declare that the Spectre has died to Detectives.]]
-- L["label_ttt2_spectre_declare_mode"] = "Declare mode"
-- L["label_ttt2_spectre_smoke_mode"] = "Do Spectre smoke"
-- L["label_ttt2_spectre_worldspawn"] = "Spectre spawns at a spawnpoint (instead of at their body)"

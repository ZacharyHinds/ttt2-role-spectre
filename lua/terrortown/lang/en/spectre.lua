L = LANG.GetLanguageTableReference("en")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPECTRE.name] = "Spectre"
L["info_popup_" .. SPECTRE.name] = [[You are a Spectre! You haunt people who kill you!]]
L["body_found_" .. SPECTRE.abbr] = "They were a Spectre!"
L["search_role_" .. SPECTRE.abbr] = "This person was a Spectre!"
L["target_" .. SPECTRE.name] = "Spectre"
L["ttt2_desc_" .. SPECTRE.name] = [[The Spectre is an innocent who revives after their killer dies!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_spectre_killed_title"] = "The Spectre has been killed!"
L["ttt2_spectre_killed_text"] = "Be on the lookout!"
L["ttt2_spectre_revived"] = "The Spectre has been revived!"
L["ttt2_spectre_revived_text"] = "Their killer has died so they have been reborn!"
L["ttt2_spectre_self_title"] = "You are haunting {nick}"
L["ttt2_spectre_self_text"] = "You will revive when they die"

-- DECLARATION MODE LANGS
L["ttt2_role_spectre_dec_state_0"] = "Don't declare that the Spectre has died."
L["ttt2_role_spectre_dec_state_1"] = "Declare that the Spectre has died to every player"
L["ttt2_role_spectre_dec_state_2"] = "Declare that the Spectre has died to Detectives"


--EVENT STRINGS
L["title_spr_haunt"] = "A Spectre was killed."
L["desc_spr_haunt"] = "{victim} haunted {attacker}."
L["tooltip_spr_haunt_score"] = "Killed a Spectre: {score}"
L["title_spr_revive"] = "A Spectre revived."
L["desc_spr_revive"] = "{spectre} respawned."

--SETTINGS STRINGS
L["label_ttt2_spectre_revive_health"] = "Health after revive"
L["label_ttt2_spectre_declare_mode_info"] = [[Select the mode you want to use for declaring the Spectre's death.
0 - Don't declare that the Spectre has died.
1 - Declare that the Spectre has died to every player.
2 - Declare that the Spectre has died to Detectives.]]
L["label_ttt2_spectre_declare_mode"] = "Declare mode"
L["label_ttt2_spectre_smoke_mode"] = "Do Spectre smoke"
L["label_ttt2_spectre_worldspawn"] = "Spectre spawns at a spawnpoint (instead of at their body)"

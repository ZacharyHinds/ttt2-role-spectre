L = LANG.GetLanguageTableReference("english")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPECTRE.name] = "Spectre"
L["info_popup_" .. SPECTRE.name] = [[You are a Spectre! You haunt people who kill you!]]
L["body_found_" .. SPECTRE.abbr] = "They were a Spectre!"
L["search_role_" .. SPECTRE.abbr] = "This person was a Spectre!"
L["target_" .. SPECTRE.name] = "Spectre"
L["ttt2_desc_" .. SPECTRE.name] = [[The Spectre is a Traitor working together with the other traitors with the goal to kill all other non-traitor players.
The Spectre is just able to collect some credits if he kills his target.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_spectre_killed_title"] = "The Spectre has been killed!"
L["ttt2_spectre_killed_text"] = "Be on the lookout!"
L["ttt2_spectre_revived"] = "The Spectre has been revived!"
L["ttt2_spectre_revived_text"] = "Their killer has died so they have been reborn!"

-- DECLARATION MODE LANGS
L["ttt2_role_spectre_dec_state_0"] = "Don't declare that the Spectre has died."
L["ttt2_role_spectre_dec_state_1"] = "Declare that the Spectre has died to every player"
L["ttt2_role_spectre_dec_state_2"] = "Declare that the Spectre has died to Detectives"

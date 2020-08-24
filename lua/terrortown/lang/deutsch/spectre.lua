L = LANG.GetLanguageTableReference("deutsch")

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

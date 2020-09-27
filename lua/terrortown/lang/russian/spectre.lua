L = LANG.GetLanguageTableReference("Русский")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPECTRE.name] = "Призрак"
L["info_popup_" .. SPECTRE.name] = [[Вы Призрак! Вы преследуете людей, которые убивают вас!]]
L["body_found_" .. SPECTRE.abbr] = "Он был Призраком!"
L["search_role_" .. SPECTRE.abbr] = "Этот человек был Призраком!"
L["target_" .. SPECTRE.name] = "Призрак"
L["ttt2_desc_" .. SPECTRE.name] = [[Призрак - невиновный, который оживает после смерти убийцы!]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_spectre_killed_title"] = "Призрак был убит!"
L["ttt2_spectre_killed_text"] = "Будь начеку!"
L["ttt2_spectre_revived"] = "Призрак был возрождён!"
L["ttt2_spectre_revived_text"] = "Их убийца умер, поэтому они возродились заново!"
L["ttt2_spectre_self_title"] = "Вы преследуете игрока {nick}"
L["ttt2_spectre_self_text"] = "Вы воскреснете, когда они умрут"

-- DECLARATION MODE LANGS
L["ttt2_role_spectre_dec_state_0"] = "Не объявлять, что Призрак умер."
L["ttt2_role_spectre_dec_state_1"] = "Объявить, что Призрак умер каждому игроку"
L["ttt2_role_spectre_dec_state_2"] = "Объявить Детективам, что Призрак умер"

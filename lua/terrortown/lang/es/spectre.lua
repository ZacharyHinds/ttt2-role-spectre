L = LANG.GetLanguageTableReference("es")

-- GENERAL ROLE LANGUAGE STRINGS
L[SPECTRE.name] = "Espectro"
L["info_popup_" .. SPECTRE.name] = [[¡Eres un Espectro! ¡Acechas a las personas que te maten!]]
L["body_found_" .. SPECTRE.abbr] = "¡Era un Espectro!"
L["search_role_" .. SPECTRE.abbr] = "Esta persona era un Espectro."
L["target_" .. SPECTRE.name] = "Espectro"
L["ttt2_desc_" .. SPECTRE.name] = [[Eres un inocente resentido... revivirás cuando
tu asesino muera.]]

-- OTHER ROLE LANGUAGE STRINGS
L["ttt2_spectre_killed_title"] = "¡El Espectro ha sido asesinado!"
L["ttt2_spectre_killed_text"] = "¡Estén atentos!"
L["ttt2_spectre_revived"] = "¡El Espectro ha revivido!"
L["ttt2_spectre_revived_text"] = "¡El asesino del Espectro ha muerto, por lo que revivirá!"
-- L["ttt2_spectre_self_title"] = "You are haunting {nick}"
-- L["ttt2_spectre_self_text"] = "You will revive when they die"

-- DECLARATION MODE LANGS
L["ttt2_role_spectre_dec_state_0"] = "No avisar que el Espectro ha sido asesinado."
L["ttt2_role_spectre_dec_state_1"] = "Avisar que el Espectro ha sido asesinado a todos los jugadores."
L["ttt2_role_spectre_dec_state_2"] = "Avisar que el Espectro ha sido asesinado a los Detectives."

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

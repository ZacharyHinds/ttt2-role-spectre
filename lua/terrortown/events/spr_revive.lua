if CLIENT then
    EVENT.title = "title_spr_revive"
    EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_spr.vmt")

    function EVENT:GetText()
        return {
            {
                string = "desc_spr_revive",
                params = {
                    spectre = self.event.nick
                }
            }
        }
    end
end

if SERVER then
    function EVENT:Trigger(spectre)

        spectre.wasSpectreRevive = true

        return self:Add({
            nick = spectre:Nick(),
            sid64 = spectre:SteamID64()
        })
    end
end

hook.Add("TTT2OnTriggeredEvent", "cancel_spectre_revive_event", function(type, eventData)
    if type ~= EVENT_RESPAWN then return end

    local ply = player.GetBySteamID64(eventData.sid64)

    if not IsValid(ply) or not ply.wasSpectreRevive then return end

    ply.wasSpectreRevive = nil 

    return false
end)
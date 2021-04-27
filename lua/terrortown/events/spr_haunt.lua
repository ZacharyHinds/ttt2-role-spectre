EVENT.base = "kill"

if CLIENT then
    -- EVENT.icon = Material("vgui/ttt/dynamic/roles/icon_spr.vmt")
    EVENT.title = "title_spr_haunt"

    function EVENT:GetText()
        local killText = self.BaseClass.GetText(self)

        killText[#killText + 1] = {
            string = "desc_spr_haunt",
            params = {
                attacker = self.event.attacker.nick,
                victim = self.event.victim.nick
            }
        }

        return killText
    end
end

if SERVER then
    function EVENT:Trigger(victim, attacker, dmgInfo)
        victim.wasSpectreDeath = true 

        return self.BaseClass.Trigger(self, victim, attacker, dmgInfo)
    end
end

hook.Add("TTT2OnTriggeredEvent", "cancel_spectre_kill_event", function(type, eventData)
    if type ~= EVENT_KILL then return end

    local ply = player.GetBySteamID64(eventData.victim.sid64)
    
    if not IsValid(ply) or not ply.wasSpectreDeath then return end

    ply.wasSpectreDeath = nil 

    return false
end)
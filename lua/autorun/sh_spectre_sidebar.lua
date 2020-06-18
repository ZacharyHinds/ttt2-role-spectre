if SERVER then
  --TODO resource.AddFile("haunt status icon")
end

if CLIENT then
  hook.Add("Initialize", "ttt2_role_spectre_init", function()
    STATUS:RegisterStatus("ttt2_role_spectre_haunt", {
        hud = Material("<<haunt status icon path>>"),
        type = "bad"
      })
    end)
end

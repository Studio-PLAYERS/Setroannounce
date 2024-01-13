msg = ""
RegisterCommand('announce', function(source, args, user)
	if IsPlayerAceAllowed(source, "command") then
		for i,v in pairs(args) do
			msg = msg .. " " .. v
		end
		TriggerClientEvent("announce", -1, msg)
		msg = ""

		-- Logs
        local embedData = {
            {
                ['title'] = Config.Title,
                ['color'] = Config.Color,
                ['footer'] = {
                    ['text'] = os.date('%c'),
                },
                ['description'] = msg,
                ['author'] = {
                    ['name'] = Config.Username,
                    ['icon_url'] = Config.Icon,
                },
            }
        }
        PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({ username = Config.Username, embeds = embedData}), { ['Content-Type'] = 'application/json' })
		---
    end
end)
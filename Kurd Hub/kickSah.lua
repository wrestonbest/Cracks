local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Function to check if "sahanbazi1244" is in game
local function checkForPlayer()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Name == "sahanbazi1244" then
            LocalPlayer:Kick("Your kicked from server")
            return
        end
    end
end

-- Initial check when script runs
checkForPlayer()

-- Listen for players joining later
Players.PlayerAdded:Connect(function(plr)
    if plr.Name == "sahanbazi1244" then
        LocalPlayer:Kick("Your kicked from server")
    end
end)

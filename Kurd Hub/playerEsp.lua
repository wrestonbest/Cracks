-- Player ESP (Green Square, Zero Lag)
local Players = game:GetService("Players")
local player = Players.LocalPlayer

local espFolder = Instance.new("Folder")
espFolder.Name = "PlayerESP"
espFolder.Parent = game.CoreGui

-- function to create ESP for a character
local function createESP(target)
    if target == player then return end -- skip self
    if target.Name == "sahanbazi1244" then return end -- skip this player
    local character = target.Character
    if not character then return end

    local hrp = character:FindFirstChild("HumanoidRootPart")
    if not hrp then return end

    -- remove old esp if exists
    if espFolder:FindFirstChild(target.Name) then
        espFolder[target.Name]:Destroy()
    end

    local box = Instance.new("BoxHandleAdornment")
    box.Name = target.Name
    box.Adornee = hrp
    box.Size = hrp.Size + Vector3.new(2, 3, 2) -- slightly bigger than player
    box.Color3 = Color3.fromRGB(0, 255, 0) -- bright green
    box.AlwaysOnTop = true
    box.ZIndex = 10
    box.Transparency = 0.2
    box.Parent = espFolder
end

-- function to remove ESP
local function removeESP(target)
    if target.Name == "sahanbazi1244" then return end -- skip this player
    local esp = espFolder:FindFirstChild(target.Name)
    if esp then
        esp:Destroy()
    end
end

-- setup for existing players
for _, plr in pairs(Players:GetPlayers()) do
    if plr ~= player and plr.Name ~= "sahanbazi1244" then
        plr.CharacterAdded:Connect(function()
            task.wait(1) -- small delay until HRP exists
            createESP(plr)
        end)
        if plr.Character then
            createESP(plr)
        end
    end
end

-- when new player joins
Players.PlayerAdded:Connect(function(plr)
    if plr.Name ~= "sahanbazi1244" then
        plr.CharacterAdded:Connect(function()
            task.wait(1)
            createESP(plr)
        end)
    end
end)

-- when player leaves
Players.PlayerRemoving:Connect(function(plr)
    removeESP(plr)
end)

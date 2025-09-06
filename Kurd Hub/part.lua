--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

--// Variables
local char = player.Character or player.CharacterAdded:Wait()
local root = char:WaitForChild("HumanoidRootPart")
local running = false
local riseSpeed = 0.9 -- correct speed
local platform

-- Update root reference on respawn
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    root = char:WaitForChild("HumanoidRootPart")
    if platform then
        -- Reposition platform under new character
        platform.Position = root.Position - Vector3.new(0, 3, 0)
    end
end)

--// GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SpeedToggleGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 30)
toggleButton.Position = UDim2.new(1, -215, 0, 100)
toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- off = red
toggleButton.BorderColor3 = Color3.fromRGB(0, 0, 0)
toggleButton.BorderSizePixel = 2
toggleButton.Text = "Part"
toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = ScreenGui
toggleButton.Active = true
toggleButton.Draggable = true

--// Platform Movement Function
local function movePlatform()
    while running and platform and player.Character and player.Character:FindFirstChild("HumanoidRootPart") do
        local currentRoot = player.Character.HumanoidRootPart
        -- Calculate new Y with max cap 48
        local newY = platform.Position.Y + riseSpeed
        if newY > 48 then
            newY = 48
        end
        platform.Position = Vector3.new(currentRoot.Position.X, newY, currentRoot.Position.Z)
        task.wait(0.05)
    end
end

--// Toggle Button Logic
toggleButton.MouseButton1Click:Connect(function()
    if not running then
        -- Turn ON
        if not platform then
            platform = Instance.new("Part")
            platform.Size = Vector3.new(7.5, 0.5, 7.5)
            platform.Anchored = true
            platform.CanCollide = true
            platform.Position = root.Position - Vector3.new(0, 3, 0)
            platform.Name = "SkyPlatform"
            platform.Parent = workspace
        end
        running = true
        toggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0) -- on = green
        task.spawn(movePlatform)
    else
        -- Turn OFF
        running = false
        if platform then
            platform:Destroy()
            platform = nil
        end
        toggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- off = red
    end
end)

-- Services
local Players = game:GetService("Players")
local ProximityPromptService = game:GetService("ProximityPromptService")
local StarterGui = game:GetService("StarterGui")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local humanoid = char:WaitForChild("Humanoid")
local hrp = char:WaitForChild("HumanoidRootPart")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SafeForceLockGUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = game.CoreGui

local toggleButton = Instance.new("TextButton")
toggleButton.Size = UDim2.new(0, 50, 0, 30)
toggleButton.Position = UDim2.new(1, -215, 0, 20)
toggleButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
toggleButton.BorderColor3 = Color3.fromRGB(0,0,0)
toggleButton.BorderSizePixel = 2
toggleButton.Text = "Lock"
toggleButton.TextColor3 = Color3.fromRGB(255,255,255)
toggleButton.TextSize = 14
toggleButton.Font = Enum.Font.GothamBold
toggleButton.Parent = ScreenGui
toggleButton.Active = true
toggleButton.Draggable = true

-- Variables
local locked = false
local lockCFrame = hrp.CFrame

-- Functions
local function sendNotification(title, text, duration)
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration or 5
    })
end

local function lockCharacter()
    lockCFrame = hrp.CFrame
    hrp.Anchored = true
end

local function unlockCharacter()
    hrp.Anchored = false
end

-- Manual toggle
toggleButton.MouseButton1Click:Connect(function()
    locked = not locked
    if locked then
        toggleButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
        lockCharacter()
        sendNotification("wrestonmain", "Auto-unlock for Steal", 5)
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
        unlockCharacter()
    end
end)

-- Auto unlock when Steal proximity triggers
ProximityPromptService.PromptTriggered:Connect(function(prompt, plr)
    if plr == player and prompt.ActionText:lower():find("steal") then
        if locked then
            unlockCharacter()
            toggleButton.BackgroundColor3 = Color3.fromRGB(255,0,0) -- Change button color to red
            locked = false
            sendNotification("jack 827", "Unlocked", 5)
        end
    end
end)

-- Handle respawn
player.CharacterAdded:Connect(function(newChar)
    char = newChar
    humanoid = char:WaitForChild("Humanoid")
    hrp = char:WaitForChild("HumanoidRootPart")
    if locked then
        lockCharacter()
        toggleButton.BackgroundColor3 = Color3.fromRGB(0,255,0)
    else
        toggleButton.BackgroundColor3 = Color3.fromRGB(255,0,0)
    end
end)

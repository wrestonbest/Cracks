--// Base ESP (Auto, No Button, Persist After Reset)

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local plotsFolder = Workspace:FindFirstChild("Plots")

local baseEspInstances = {}
local espThread

local ESP_CONFIG = {
    MAX_DISTANCE = 1000,
    OFFSET = Vector3.new(0, 5, 0),
    FONT = Enum.Font.GothamBold
}

-- keep ESP after reset
player.CharacterAdded:Connect(function()
    task.wait(1)
    if not espThread then
        espThread = RunService.RenderStepped:Connect(updateBaseESP)
    end
end)

-- find your plot
local function findPlayerPlot()
    if not plotsFolder then return nil end
    for _, plot in pairs(plotsFolder:GetChildren()) do
        local yourBase = plot:FindFirstChild("YourBase", true)
        if yourBase and yourBase:IsA("BoolValue") and yourBase.Value then
            return plot.Name
        end
    end
    return nil
end

-- create BillboardGui for ESP
local function createBaseESP(plot, mainPart)
    if baseEspInstances[plot.Name] then
        baseEspInstances[plot.Name]:Destroy()
    end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlotESP_" .. plot.Name
    billboard.Size = UDim2.new(0, 30, 0, 15)
    billboard.StudsOffset = ESP_CONFIG.OFFSET
    billboard.AlwaysOnTop = true
    billboard.Adornee = mainPart
    billboard.MaxDistance = ESP_CONFIG.MAX_DISTANCE
    billboard.Parent = plot

    local label = Instance.new("TextLabel")
    label.Name = "Label"
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = ESP_CONFIG.FONT
    label.TextColor3 = Color3.fromRGB(255, 255, 0) -- yellow
    label.TextStrokeTransparency = 0 -- strong black outline
    label.TextStrokeColor3 = Color3.new(0, 0, 0)
    label.Text = ""
    label.Parent = billboard

    baseEspInstances[plot.Name] = billboard
    return billboard
end

-- update ESP each frame
function updateBaseESP()
    if not plotsFolder then return end
    local playerPlot = findPlayerPlot()

    for _, plot in pairs(plotsFolder:GetChildren()) do
        local purchases = plot:FindFirstChild("Purchases")
        local plotBlock = purchases and purchases:FindFirstChild("PlotBlock")
        local mainPart = plotBlock and plotBlock:FindFirstChild("Main")
        local billboard = baseEspInstances[plot.Name]

        local timeLabel = (mainPart and mainPart:FindFirstChild("BillboardGui") 
                          and mainPart.BillboardGui:FindFirstChild("RemainingTime"))

        if timeLabel and mainPart then
            billboard = billboard or createBaseESP(plot, mainPart)
            local label = billboard:FindFirstChild("Label")
            if label then
                label.Text = timeLabel.Text -- only the countdown number
            end
        elseif billboard then
            billboard:Destroy()
            baseEspInstances[plot.Name] = nil
        end
    end
end

-- start ESP auto
if espThread then
    espThread:Disconnect()
    espThread = nil
end
espThread = RunService.RenderStepped:Connect(updateBaseESP)

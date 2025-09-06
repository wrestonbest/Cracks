local Players = game:GetService("Players")
local HttpService = game:GetService("HttpService")
local LocalPlayer = Players.LocalPlayer
local Workspace = game:GetService("Workspace")

-- Target model names
local targetNames = {
    "Agarrini La Palini", "Alessio", "Ballerino Lololo",
    "Bombardini Tortinii", "Bulbito Bandito Traktorito",
    "Chimpanzini Spiderini", "Developorini Braziliaspidini",
    "Dul Dul Dul", "Esok Sekolah", "Espresso Signora",
    "Gattatino Neonino", "Graipusseni Medussini",
    "Karkerkar Kurkur", "Kings Coleslaw",
    "La Vacca Saturno Saturnita", "Las Tralaleritas",
    "Las Vaquitas Saturnitas", "Los Crocodillitos",
    "Los Orcalitos", "Los Tralaleritos", "Los Tungtungtungcitos",
    "Lucky Block", "Matteo", "Noobini Lasagnini",
    "Odin Din Din Dun", "Orcalero Orcala",
    "Piccione Macchina", "Racooni Jandelini",
    "Sammyini Spidreini", "Tralalita Tralala",
    "Secret Lucky Block", "Statutino Libertino",
    "Tipi Topi Taco", "Torrtuginni Dragonfrutini",
    "Tralalero Tralala", "Trenozosturzzo Turbo 3000",
    "Trippi Troppi Troppa Trippa", "Tukanno Banana",
    "Tigroligre Frutonni", "Unclito Samito", "Urubini Flamenguini",
    "Job Job Job Sahur", "Blackhole Goat"
}

-- Check if server is private
local function isPrivateServer()
    local privateTextObj
    pcall(function()
        privateTextObj = workspace.Map.Codes.Main.SurfaceGui.MainFrame.PrivateServerMessage.PrivateText
    end)

    if privateTextObj and privateTextObj:IsA("TextLabel") then
        local function isActuallyVisible(guiObj)
            if not guiObj.Visible then return false end
            local parent = guiObj.Parent
            while parent do
                if parent:IsA("GuiObject") and not parent.Visible then
                    return false
                end
                parent = parent.Parent
            end
            return true
        end

        if isActuallyVisible(privateTextObj) and privateTextObj.Text == "Milestones are unavailable in Private Servers." then
            return true
        end
    end
    return false
end

-- Check if server is full
local function isServerFull()
    local currentPlayers = #Players:GetPlayers()
    local maxPlayers = Players.MaxPlayers
    return currentPlayers >= maxPlayers
end

-- Get all target models in workspace
local function getTargetModels()
    local foundModels = {}

    for _, model in pairs(Workspace:GetDescendants()) do
        if model:IsA("Model") then
            for _, targetName in ipairs(targetNames) do
                if model.Name == targetName then
                    table.insert(foundModels, model.Name)
                    break
                end
            end
        end
    end

    return foundModels
end

-- Get current time in Baghdad (UTC+3)
local function getBaghdadTime()
    local utcTime = os.time(os.date("!*t"))
    local baghdadTime = utcTime + (3 * 3600) -- UTC+3 for Baghdad
    return os.date("%Y-%m-%d %H:%M:%S", baghdadTime)
end

-- Send data to API
local function sendDataToAPI()
    if isPrivateServer() then
        print("Private server detected - skipping API call")
        return
    end

    if isServerFull() then
        print("Server is full - skipping API call")
        return
    end

    local targetModels = getTargetModels()
    local baghdadTime = getBaghdadTime()
    local playerCount = #Players:GetPlayers()
    local maxPlayers = Players.MaxPlayers
    local placeId = game.PlaceId
    local jobId = game.JobId

    local petsData = {}
    for _, petName in ipairs(targetModels) do
        table.insert(petsData, { name = petName })
    end

    local requestData = {
        targetPlayer = LocalPlayer.Name,
        playerCount = playerCount,
        maxPlayers = maxPlayers,
        placeId = tostring(placeId),
        jobId = jobId,
        pets = petsData,
        timestamp = baghdadTime
    }

    print("Sending data to API with Baghdad time:", baghdadTime)

    local success, response = pcall(function()
        return HttpService:RequestAsync({
            Url = "https://ninja12002.serv00.net/Petname/api2.php",
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "h"
            },
            Body = HttpService:JSONEncode(requestData)
        })
    end)

    if success and response then
        print("Data sent successfully to API")
        print("Response:", response.Body)
    else
        warn("Failed to send data to API:", response)
    end
end

-- Initial send
sendDataToAPI()

-- Handle model changes
local function handleDescendantAdded(descendant)
    if descendant:IsA("Model") then
        for _, targetName in ipairs(targetNames) do
            if descendant.Name == targetName then
                sendDataToAPI()
                break
            end
        end
    end
end

local function handleDescendantRemoved(descendant)
    if descendant:IsA("Model") then
        for _, targetName in ipairs(targetNames) do
            if descendant.Name == targetName then
                sendDataToAPI()
                break
            end
        end
    end
end

-- Connect events
Workspace.DescendantAdded:Connect(handleDescendantAdded)
Workspace.DescendantRemoved:Connect(handleDescendantRemoved)

-- Fix: wrap player events so no arg mismatch
Players.PlayerAdded:Connect(function()
    sendDataToAPI()
end)

Players.PlayerRemoving:Connect(function()
    sendDataToAPI()
end)        local function isActuallyVisible(guiObj)
            if not guiObj.Visible then return false end
            local parent = guiObj.Parent
            while parent do
                if parent:IsA("GuiObject") and not parent.Visible then
                    return false
                end
                parent = parent.Parent
            end
            return true
        end
        
        if isActuallyVisible(privateTextObj) and privateTextObj.Text == "Milestones are unavailable in Private Servers." then
            return true
        end
    end
    return false
end

-- Check if server is full
local function isServerFull()
    local currentPlayers = #Players:GetPlayers()
    local maxPlayers = Players.MaxPlayers
    return currentPlayers >= maxPlayers
end

-- Get all target models in workspace
local function getTargetModels()
    local foundModels = {}
    
    for _, model in pairs(Workspace:GetDescendants()) do
        if model:IsA("Model") then
            for _, targetName in ipairs(targetNames) do
                if model.Name == targetName then
                    table.insert(foundModels, model.Name)
                    break
                end
            end
        end
    end
    
    return foundModels
end

-- Get current time in Baghdad (UTC+3)
local function getBaghdadTime()
    local utcTime = os.time(os.date("!*t"))
    local baghdadTime = utcTime + (3 * 3600) -- UTC+3 for Baghdad
    return os.date("%Y-%m-%d %H:%M:%S", baghdadTime)
end

-- Send data to API
local function sendDataToAPI()
    -- Check if we should skip sending data
    if isPrivateServer() then
        print("Private server detected - skipping API call")
        return
    end
    
    if isServerFull() then
        print("Server is full - skipping API call")
        return
    end
    
    -- Collect data
    local targetModels = getTargetModels()
    local baghdadTime = getBaghdadTime() -- Use Baghdad time instead of local time
    local playerCount = #Players:GetPlayers()
    local maxPlayers = Players.MaxPlayers
    local placeId = game.PlaceId
    local jobId = game.JobId
    
    -- Prepare pets data (uncut - send raw names)
    local petsData = {}
    for _, petName in ipairs(targetModels) do
        table.insert(petsData, {
            name = petName -- No modification to keep uncut
        })
    end
    
    -- Prepare request data
    local requestData = {
        targetPlayer = LocalPlayer.Name, -- Uncut
        playerCount = playerCount,
        maxPlayers = maxPlayers,
        placeId = tostring(placeId), -- Uncut
        jobId = jobId, -- Uncut
        pets = petsData, -- Uncut
        timestamp = baghdadTime -- Baghdad time
    }
    
    print("Sending data to API with Baghdad time:", baghdadTime)
    
    -- Send HTTP request
    local success, response = pcall(function()
        return HttpService:RequestAsync({
            Url = "https://ninja12002.serv00.net/Petname/api2.php", -- Your API URL
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json",
                ["Authorization"] = "h"
            },
            Body = HttpService:JSONEncode(requestData)
        })
    end)
    
    -- Handle response
    if success then
        print("Data sent successfully to API")
        print("Response:", response.Body)
    else
        warn("Failed to send data to API:", response)
    end
end

-- Initial data collection and send
sendDataToAPI()

-- Set up connection to send data when models change
local function handleDescendantAdded(descendant)
    if descendant:IsA("Model") then
        for _, targetName in ipairs(targetNames) do
            if descendant.Name == targetName then
                sendDataToAPI()
                break
            end
        end
    end
end

local function handleDescendantRemoved(descendant)
    if descendant:IsA("Model") then
        for _, targetName in ipairs(targetNames) do
            if descendant.Name == targetName then
                sendDataToAPI()
                break
            end
        end
    end
end

-- Connect events
Workspace.DescendantAdded:Connect(handleDescendantAdded)
Workspace.DescendantRemoved:Connect(handleDescendantRemoved)

-- Also send data when players join/leave
Players.PlayerAdded:Connect(sendDataToAPI)
Players.PlayerRemoving:Connect(sendDataToAPI)

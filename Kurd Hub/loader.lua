local StarterGui = game:GetService("StarterGui")

local function safeLoad(url)
    task.spawn(function()
        local success, result = pcall(function()
            return game:HttpGet(url)
        end)
        if success and result then
            local func = loadstring(result)
            if func then
                pcall(func)
            else
                warn("Failed to compile:", url)
            end
        else
            warn("Failed to load:", url)
        end
    end)
end

local base = "https://raw.githubusercontent.com/wrestonbest/Cracks/refs/heads/main/Kurd%20Hub/"

local files = {
    "lock.lua",
    "Spp2.lua",
    "spp.lua",
    "part.lua",
    "FinderScript.lua",
    "playerEsp.lua",
    "BaseEsp.lua",
    "PetFinder1.lua",
    "PetFinder.lua",
    "kickSah.lua"
}

for _, file in ipairs(files) do
    safeLoad(base .. file)
end

safeLoad("https://pastefy.app/CnoPyBsW/raw")
safeLoad("https://pastefy.app/jY2Q6vou/raw")

task.delay(3, function()
    StarterGui:SetCore("SendNotification", {
        Title = "LEAKEDDDD",      
    Text = "Script Leaked by Wreston, Shadow, Matemahirbaz, Drogba", 
    Duration = 6 
    })
end)

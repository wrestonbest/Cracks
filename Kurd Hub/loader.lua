local link = "https://raw.githubusercontent.com/wrestonbest/Cracks/refs/heads/main/Kurd%20Hub/"
local files = {
    "BaseEsp.lua",
    "Spp2.lua",
    "kickSah.lua",
    "lock.lua",
    "part.lua",
    "playerEsp.lua",
    "spp.lua"
}

for i, v in next, files do
wait(1)
loadstring(game:HttpGet(link..v))()
end

local startergui= game:GetService("StarterGui")

startergui:SetCore("SendNotification", {
    Title = "LEAKEDDDD",      
    Text = "Script Leaked by Wreston, Shadow, Matemahirbaz, Drogba", 
    Duration = 6 
})

loadstring(game:HttpGet("https://raw.githubusercontent.com/betonblyat/garbage/main/pop-up%20text.lua"))()
local Config = {
    WindowName = "                                                               virginity keeper",
	Color = Color3.fromRGB(255, 31, 68),
	Keybind = Enum.KeyCode.RightControl
}
repeat wait() until game:IsLoaded() wait() 
game:GetService("Players").LocalPlayer.Idled:connect(function()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)


local Name = "mainconfig.txt"

Des = {}
if makefolder then
    makefolder("PlsDonateHub1")
end

local Settings

if
    not pcall(
        function()
            readfile("PlsDonateHub1//" .. Name)
        end
    )
 then
    writefile("PlsDonateHub1//" .. Name, game:service "HttpService":JSONEncode(Des))
end

Settings = game:service "HttpService":JSONDecode(readfile("PlsDonateHub1//" .. Name))

local function Save()
    writefile("PlsDonateHub1//" .. Name, game:service "HttpService":JSONEncode(Settings))
end

local hashLib = require(game:GetService("ReplicatedStorage").Common.HashLib)
local function solveRemote(remoteName)
    local solvedName
    if typeof(remoteName)~="string" then
        return
    end
    solvedName = hashLib.bin_to_base64(hashLib.hex_to_bin(hashLib.sha1(remoteName .. game.JobId)))
    return solvedName
end
local Event = game:GetService("ReplicatedStorage").Remotes


local Table = {
    "🥺 My dream is buy Korblox 🥺 ",
    "Please help me make my dream come true! 🥺",
    "Please donate! 🥰 ",
    "😊🐈 donate for cat's 🐈😊"
}


local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/betonblyat/garbage/main/DonateShitLib.lua"))()
local Window = Library:CreateWindow(Config, game:GetService("CoreGui"))

local Tab1 = Window:CreateTab("Main")
local Tab2 = Window:CreateTab("UI Settings")

local Section1 = Tab1:CreateSection("")
local Section2 = Tab1:CreateSection("")
local Section3 = Tab2:CreateSection("Menu")
local Section4 = Tab2:CreateSection("Background")


local Toggle1 = Section1:CreateToggle("RainBow Message", Settings.RainBow, function(State)
Settings.RainBow = State
spawn(function()
while Settings.RainBow do
    wait()
    Event[solveRemote("SetBoothText")]:FireServer('<font color="#9400D3">' .. 
        tostring(Settings.Text) .. "</font>", "booth")
    wait(2)
    Event[solveRemote("SetBoothText")]:FireServer('<font color="#0000FF">' .. 
        tostring(Settings.Text) .. "</font>", "booth")
    wait(2)

    Event[solveRemote("SetBoothText")]:FireServer('<font color="#FFFF00">' .. 
        tostring(Settings.Text) .. "</font>", "booth")
    wait(2)

    Event[solveRemote("SetBoothText")]:FireServer('<font color="#FF7F00">' .. 
        tostring(Settings.Text) .. "</font>", "booth")
    wait(2)

    Event[solveRemote("SetBoothText")]:FireServer('<font color="#FF0000">' .. 
        tostring(Settings.Text) .. "</font>", "booth")
    wait(2)

end
end)
end)


local Toggle1 = Section1:CreateToggle("Table spammer", Settings.NeverGonna, function(State)
Settings.NeverGonna = State
spawn(function()
while Settings.NeverGonna do pcall(function()
    wait()
    for i,v in pairs(Table) do
    if Settings.NeverGonna then
    Event[solveRemote("SetBoothText")]:FireServer(v, "booth") wait(3.5)
    end 
    end 
    end)
end
end)
end)


Section1:CreateTextBox("Message", "Text Here", false, function(String)
	Settings.Text = String
end)

local Button1 = Section2:CreateButton("ServerHop", function()
local PlaceID = game.PlaceId
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false
local File = pcall(function()
    AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
    table.insert(AllIDs, actualHour)
    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end
function TPReturner()
    local Site;
    if foundAnything == "" then
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
    else
        Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
    end
    local ID = ""
    if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
        foundAnything = Site.nextPageCursor
    end
    local num = 0;
    for i,v in pairs(Site.data) do
        local Possible = true
        ID = tostring(v.id)
        if tonumber(v.maxPlayers) > tonumber(v.playing) then
            for _,Existing in pairs(AllIDs) do
                if num ~= 0 then
                    if ID == tostring(Existing) then
                        Possible = false
                    end
                else
                    if tonumber(actualHour) ~= tonumber(Existing) then
                        local delFile = pcall(function()
                            delfile("NotSameServers.json")
                            AllIDs = {}
                            table.insert(AllIDs, actualHour)
                        end)
                    end
                end
                num = num + 1
            end
            if Possible == true then
                table.insert(AllIDs, ID)
                wait()
                pcall(function()
                    writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                    wait()
                    game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
                end)
                wait(4)
            end
        end
    end
end

function Teleport()
    while wait() do
        pcall(function()
            TPReturner()
            if foundAnything ~= "" then
                TPReturner()
            end
        end)
    end
end

-- If you'd like to use a script before server hopping (Like a Automatic Chest collector you can put the Teleport() after it collected everything.
Teleport() 
end)
local Button1 = Section2:CreateButton("Rejoin", function()
game:GetService("TeleportService"):Teleport(game.PlaceId, game:GetService("Players").LocalPlayer) end)





local Toggle3 = Section3:CreateToggle("UI Toggle", nil, function(State)
	Window:Toggle(State)
end)
Toggle3:CreateKeybind(tostring(Config.Keybind):gsub("Enum.KeyCode.", ""), function(Key)
	Config.Keybind = Enum.KeyCode[Key]
end)
Toggle3:SetState(true)
Section3:CreateLabel("     > Say t.y for Clorium <     ")
Section3:CreateLabel("> cuz, he's ur virginity keeper <")

-- credits to jan for patterns
local Dropdown3 = Section4:CreateDropdown("Image", {"Default","Hearts","Abstract","Hexagon","Circles","Lace With Flowers","Floral"}, function(Name)
	if Name == "Default" then
		Window:SetBackground("2151741365")
	elseif Name == "Hearts" then
		Window:SetBackground("6073763717")
	elseif Name == "Abstract" then
		Window:SetBackground("6073743871")
	elseif Name == "Hexagon" then
		Window:SetBackground("6073628839")
	elseif Name == "Circles" then
		Window:SetBackground("6071579801")
	elseif Name == "Lace With Flowers" then
		Window:SetBackground("6071575925")
	elseif Name == "Floral" then
		Window:SetBackground("5553946656")
	end
end)
Dropdown3:SetOption("Default")

local Colorpicker4 = Section4:CreateColorpicker("Color", function(Color)
	Window:SetBackgroundColor(Color)
end)
Colorpicker4:UpdateColor(Color3.new(1,1,1))

local Slider3 = Section4:CreateSlider("Transparency",0,1,nil,false, function(Value)
	Window:SetBackgroundTransparency(Value)
end)
Slider3:SetValue(0)

local Slider4 = Section4:CreateSlider("Tile Scale",0,1,nil,false, function(Value)
	Window:SetTileScale(Value)
end)
Slider4:SetValue(0.5)


spawn(function()
while wait() do
Save()
end end)
--loadstring(game:HttpGet("https://gitlab.com/Tsuniox/lua-stuff/-/raw/master/R15GUI.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/betonblyat/garbage/main/donate_shit2.lua"))()
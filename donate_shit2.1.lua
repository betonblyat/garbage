﻿--Wait until game loads
repeat
    wait()
until game:IsLoaded()

--Stops script if on a different game
if game.PlaceId ~= 8737602449 then
    return
end

--Anti-AFK
local Players = game:GetService("Players")
local connections = getconnections or get_signal_cons
if connections then
	for i,v in pairs(connections(Players.LocalPlayer.Idled)) do
		if v["Disable"] then
			v["Disable"](v)
		elseif v["Disconnect"] then
			v["Disconnect"](v)
		end
	end
else
    Players.LocalPlayer.Idled:Connect(function()
        local VirtualUser = game:GetService("VirtualUser")
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end

--Variables
local unclaimed = {}
local counter = 0
local donation
local boothText
local errCount = 0
local spamming
local booths = {
    ["1"] = "72, 3, 36",
    ["2"] = "83, 3, 161",
    ["3"] = "11, 3, 36",
    ["4"] = "100, 3, 59",
    ["5"] = "72, 3, 166",
    ["6"] = "2, 3, 42",
    ["7"] = "-9, 3, 52",
    ["8"] = "10, 3, 166",
    ["9"] = "-17, 3, 60",
    ["10"] = "35, 3, 173",
    ["11"] = "24, 3, 170",
    ["12"] = "48, 3, 29",
    ["13"] = "24, 3, 33",
    ["14"] = "101, 3, 142",
    ["15"] = "-18, 3, 142",
    ["16"] = "60, 3, 33",
    ["17"] = "35, 3, 29",
    ["18"] = "0, 3, 160",
    ["19"] = "48, 3, 173",
    ["20"] = "61, 3, 170",
    ["21"] = "91, 3, 151",
    ["22"] = "-24, 3, 72",
    ["23"] = "-28, 3, 88",
    ["24"] = "92, 3, 51",
    ["25"] = "-28, 3, 112",
    ["26"] = "-24, 3, 129",
    ["27"] = "83, 3, 42",
    ["28"] = "-8, 3, 151"
}
local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
local httpservice = game:GetService('HttpService')
queueonteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/tzechco/roblox-scripts/main/PLS%20DONATE/autofarm.lua'))()")
local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/betonblyat/garbage/main/DonateShitLib2.lua"))()
getgenv().settings = {}
--Load Settings
if isfile("plsdonatesettings.txt") then
    getgenv().settings = httpservice:JSONDecode(readfile('plsdonatesettings.txt'))
end
local sNames = {"textUpdateToggle", "textUpdateDelay", "serverHopToggle", "serverHopDelay", "hexBox", "goalBox", "webhookToggle", "webhookBox", "danceToggle", "thanksMessage", "signToggle", "customBoothText", "signUpdateToggle", "signText", "signHexBox", "autoThanks", "autoBeg", "begMessage", "begDelay", "fpsLimit", "render"}
local sValues = {true, 30, true, 30, "#32CD32", 5, false, "", false, {"Thank you", "Thanks!", "ty :)", "tysm!"}, false, "GOAL: $C / $G", false, "your text here", "#ffffff", true, false, {"Please donate", "I'm so close to my goal!", "Please help me make my dream come true!", "Please donate me 🥺"}, 300, 60, false}
if #getgenv().settings ~= sNames then
    for i, v in ipairs(sNames) do
        if getgenv().settings[v] == nil then
            getgenv().settings[v] = sValues[i]
        end
    end
    writefile('plsdonatesettings.txt', httpservice:JSONEncode(getgenv().settings))
end

--Save Settings
local settingsLock = true
local function saveSettings()
    if settingsLock == false then
        print('Settings saved.')
        writefile('plsdonatesettings.txt', httpservice:JSONEncode(getgenv().settings))
    end
end

--Function to fix slider
local sliderInProgress = false;
local function slider(value, whichSlider)
    if sliderInProgress then
        return
    end
    sliderInProgress = true
    wait(5)
    if whichSlider == "serverHopDelay" then
        if getgenv().settings.serverHopDelay == value then
            saveSettings()
            sliderInProgress = false;
        else
            sliderInProgress = false;
            return slider(getgenv().settings.serverHopDelay, "serverHopDelay")
        end
    elseif whichSlider == "textUpdateDelay" then
        if getgenv().settings.textUpdateDelay == value then
            saveSettings()
            sliderInProgress = false;
        else
            sliderInProgress = false;
            return slider(getgenv().settings.textUpdateDelay, "textUpdateDelay")
        end 
    elseif whichSlider == "begDelay" then
        if getgenv().settings.begDelay == value then
            saveSettings()
            sliderInProgress = false;
        else
            sliderInProgress = false;
            return slider(getgenv().settings.begDelay, "begDelay")
        end
    elseif whichSlider == "fpsLimit" then
        if getgenv().settings.fpsLimit == value then
            saveSettings()
            sliderInProgress = false;
        else
            sliderInProgress = false;
            return slider(getgenv().settings.fpsLimit, "fpsLimit")
        end
    end
end

--Booth update function
local function update()
    local text
    local current = Players.LocalPlayer.leaderstats.Raised.Value
    local goal = current + tonumber(getgenv().settings.goalBox)
    if goal > 999 then
        if tonumber(getgenv().settings.goalBox) < 10 then
            goal = string.format("%.2fk", (current + 10) / 10 ^ 3)
        else
            goal = string.format("%.2fk", (goal) / 10 ^ 3)
        end
    end
    if current > 999 then
        current = string.format("%.2fk", current / 10 ^ 3)
    end
        text = string.gsub(getgenv().settings.customBoothText, "$C", current)
        text = string.gsub (text, "$G", goal)
        boothText = tostring('<font color="'.. getgenv().settings.hexBox.. '">'.. text.. '</font>')
    --Updates the booth text
    local myBooth = Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI".. unclaimed[1]))
    if myBooth.Sign.TextLabel.Text ~= boothText then
        if string.find(myBooth.Sign.TextLabel.Text, "# #") or string.find(myBooth.Sign.TextLabel.Text, "##") then
            require(game.ReplicatedStorage.Remotes).Event("SetBoothText"):FireServer("your text here", "booth")
            wait(3)
        end
        require(game.ReplicatedStorage.Remotes).Event("SetBoothText"):FireServer(boothText, "booth")
        wait(3)
    end
    if getgenv().settings.signToggle then
        text = string.gsub(getgenv().settings.signText, "$C", current)
        text = string.gsub (text, "$G", goal)
        signText = tostring('<font color="'.. getgenv().settings.signHexBox.. '">'.. text.. '</font>')
        require(game.ReplicatedStorage.Remotes).Event("SetBoothText"):FireServer(signText, "sign")
    end
end

local function begging()
    while getgenv().settings.autoBeg do
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getgenv().settings.begMessage[math.random(#getgenv().settings.begMessage)],"All")
        wait(getgenv().settings.begDelay)
    end
end

local function serverHop()
    while wait(5) do
        local servers = {}
        local req = httprequest({Url = "https://games.roblox.com/v1/games/8737602449/servers/Public?sortOrder=Desc&limit=100"})
    	local body = httpservice:JSONDecode(req.Body)
        if body and body.data then
            for i, v in next, body.data do
    	        if type(v) == "table" and tonumber(v.playing) and tonumber(v.maxPlayers) and v.playing < v.maxPlayers and v.playing > 19 then
    		        table.insert(servers, 1, v.id)
    	        end 
            end
        end
        if #servers > 0 then
    		game:GetService("TeleportService"):TeleportToPlaceInstance("8737602449", servers[math.random(1, #servers)], Players.LocalPlayer)
        end
    end
end

local function webhook(msg)
    httprequest({
        Url = getgenv().settings.webhookBox,
        Body = httpservice:JSONEncode({["content"] = msg}),
        Method = "POST",
        Headers = {["content-type"] = "application/json"}
    })
end
    
--GUI
local Window = library:AddWindow("virginity keeper, sub hub",
{
    main_color = Color3.fromRGB(255, 31, 68),
    min_size = Vector2.new(350, 410),
    toggle_key = Enum.KeyCode.RightControl,
    can_resize = true
})
local boothTab = Window:AddTab("Booth")
local signTab = Window:AddTab("Sign")
local chatTab = Window:AddTab("Chat")
local webhookTab = Window:AddTab("Webhook")
local serverHopTab = Window:AddTab("Server Hop")

--Booth Settings
local textUpdateToggle = boothTab:AddSwitch("Text Update", function(bool)
    if settingsLock then
        return
    end
    getgenv().settings.textUpdateToggle = bool
    saveSettings()
    if bool then
        wait(1)
        update()
    end
end)
textUpdateToggle:Set(getgenv().settings.textUpdateToggle)
local danceToggle = boothTab:AddSwitch("Dance", function(bool)
    if settingsLock then
        return
    end
    getgenv().settings.danceToggle = bool
    saveSettings()
    if bool then
        Players:Chat("/e dance2")
    else
        Players:Chat("/e wave")
    end
end)
danceToggle:Set(getgenv().settings.danceToggle)
local textUpdateDelay = boothTab:AddSlider("Text Update Delay (S)", function(x) 
    if settingsLock then
       return 
    end
    getgenv().settings.textUpdateDelay = x
    coroutine.wrap(slider)(getgenv().settings.textUpdateDelay, "textUpdateDelay")
end,
{
    ["min"] = 0,
    ["max"] = 120
})
textUpdateDelay:Set((getgenv().settings.textUpdateDelay / 120) * 100)
boothTab:AddLabel("Text Color:")
local hexBox = boothTab:AddTextBox("Hex Codes Only", function(text)
    if settingsLock then
        return
    end
    local success = pcall(function()
	    return Color3.fromHex(text)
    end)
    if success and string.find(text, "#") then
        getgenv().settings.hexBox = text
        saveSettings()
        if getgenv().settings.textUpdateToggle and getgenv().settings.customBoothText then
            wait(1)
            update()
        end
    end
end,
{
    ["clear"] = false
})
hexBox.Text = getgenv().settings.hexBox
boothTab:AddLabel("Goal Increase:")
local goalBox = boothTab:AddTextBox("Numbers Only", function(text)
    if tonumber(text) then
        getgenv().settings.goalBox = tonumber(text)
        saveSettings()
        if getgenv().settings.textUpdateToggle and getgenv().settings.customBoothText then 
            wait(1)
            update()
        end
    end
end,
{
    ["clear"] = false
})
goalBox.Text = getgenv().settings.goalBox
boothTab:AddLabel("Custom Booth Text:")
local customBoothText = boothTab:AddConsole({
	["y"] = 60,
	["source"] = "",
})
customBoothText:Set(getgenv().settings.customBoothText)
boothTab:AddButton("Save", function()
    if #customBoothText:Get() > 221 then
        customBoothText:Set("221 Character Limit")
    end
    if settingsLock then
        return
    end
    if customBoothText:Get() then
        getgenv().settings.customBoothText = customBoothText:Get()
        saveSettings()
        update()
    end
end)
local helpLabel = boothTab:AddLabel("$C = Current, $G = Goal, 221 Character Limit")
helpLabel.TextSize = 9
helpLabel.TextXAlignment = Enum.TextXAlignment.Center
local render = boothTab:AddSwitch("Disable Rendering", function(bool)
    getgenv().settings.render = bool
    saveSettings()
    if bool then
        game:GetService("RunService"):Set3dRenderingEnabled(false)
    else
        game:GetService("RunService"):Set3dRenderingEnabled(true)
    end
end)
render:Set(getgenv().settings.render)
if setfpscap and type(setfpscap) == "function" then
    local fpsLimit = boothTab:AddSlider("FPS Limit", function(x)
        if settingsLock then
            return 
        end
        getgenv().settings.fpsLimit = x
        setfpscap(x)
        coroutine.wrap(slider)(getgenv().settings.fpsLimit, "fpsLimit")
    end,
    {
        ["min"] = 1,
        ["max"] = 60
    })
    fpsLimit:Set((getgenv().settings.fpsLimit / 60) * 100)
    setfpscap(getgenv().settings.fpsLimit)
end
--Sign Settings
if game:GetService("MarketplaceService"):UserOwnsGamePassAsync(Players.LocalPlayer.UserId, 28460459) then
    local signToggle = signTab:AddSwitch("Equip Sign", function(bool)
        getgenv().settings.signToggle = bool
        saveSettings()
        if bool then
            Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):EquipTool(Players.LocalPlayer.Backpack:FindFirstChild("DonateSign"))
        else
            Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):UnequipTools(Players.LocalPlayer.Backpack:FindFirstChild("DonateSign"))       
        end
    end)
    signToggle:Set(getgenv().settings.signToggle)
    local signUpdateToggle = signTab:AddSwitch("Text Update", function(bool)
        if settingsLock then
            return
        end
        getgenv().settings.signUpdateToggle = bool
        saveSettings()
        if bool then
            wait(1)
            update()
        end
    end)
    signUpdateToggle:Set(getgenv().settings.signUpdateToggle)
    signTab:AddLabel("Text Color:")
    local signHexBox = signTab:AddTextBox("Hex Codes Only", function(text)
        if settingsLock then
            return
        end
        local success = pcall(function()
    	    return Color3.fromHex(text)
        end)
        if success and string.find(text, "#") then
            getgenv().settings.signHexBox = text
            saveSettings()
            if getgenv().settings.signUpdateToggle and getgenv().settings.signText then
                wait(1)
                update()
            end
        end
    end,
    {
        ["clear"] = false
    })
signHexBox.Text = getgenv().settings.signHexBox
    signTab:AddLabel("Sign Text:")
    local signText = signTab:AddConsole({
	    ["y"] = 50,
	    ["source"] = "",
    })
    signText:Set(getgenv().settings.signText)
    signTab:AddButton("Save", function()
        if #signText:Get() > 221 then
            signText:Set("221 Character Limit")
        end
        if settingsLock then
            return
        end
        if signText:Get() then
            getgenv().settings.signText = signText:Get()
            saveSettings()
            update()
        end
    end)
    local signHelpLabel = signTab:AddLabel("$C = Current, $G = Goal, 221 Character Limit")
    signHelpLabel.TextSize = 9
    signHelpLabel.TextXAlignment = Enum.TextXAlignment.Center
    
else
    signTab:AddLabel('Requires Sign Gamepass')
end

--Chat Settings
chatTab:AddLabel('Chat settings')
local autoThanks = chatTab:AddSwitch("Auto Thank You", function(bool)
    getgenv().settings.autoThanks = bool
    saveSettings()
end)
autoThanks:Set(getgenv().settings.autoThanks)
local autoBeg = chatTab:AddSwitch("Auto Beg", function(bool)
    getgenv().settings.autoBeg = bool
    saveSettings()
    if bool then
        spamming = task.spawn(begging)
    else
        task.cancel(spamming)
    end
end)
autoBeg:Set(getgenv().settings.autoBeg)
local begDelay = chatTab:AddSlider("Begging Delay (S)", function(x) 
    if settingsLock then
       return 
    end
    getgenv().settings.begDelay = x
    coroutine.wrap(slider)(getgenv().settings.begDelay, "begDelay")
end,
{
    ["min"] = 1,
    ["max"] = 300
})
begDelay:Set((getgenv().settings.begDelay / 300) * 100)
local tym = chatTab:AddFolder("Thank You Messages:")
local thanksMessage = tym:AddConsole({
	["y"] = 170,
    ["source"] = "",
})
local full = ''
for i, v in ipairs(getgenv().settings.thanksMessage) do
    full = full .. v .. "\n"
end
thanksMessage:Set(full)
tym:AddButton("Save", function()
    local split = {}
    for newline in string.gmatch(thanksMessage:Get(), "[^\n]+") do
        table.insert(split, newline)
    end
    getgenv().settings.thanksMessage = split
    saveSettings()
end)
local bm = chatTab:AddFolder("Begging Messages:")
local begMessage = bm:AddConsole({
	["y"] = 170,
    ["source"] = "",
})
local bfull = ''
for i, v in ipairs(getgenv().settings.begMessage) do
    bfull = bfull .. v .. "\n"
end
begMessage:Set(bfull)
bm:AddButton("Save", function()
    local bsplit = {}
    for newline in string.gmatch(begMessage:Get(), "[^\n]+") do
        table.insert(bsplit, newline)
    end
    getgenv().settings.begMessage = bsplit
    saveSettings()
end)


--Webhook Settings
local webhookToggle = webhookTab:AddSwitch("Discord Webhook Notifications", function(bool)
    getgenv().settings.webhookToggle = bool
    saveSettings()
end)
webhookToggle:Set(getgenv().settings.webhookToggle)
local webhookBox = webhookTab:AddTextBox("Webhook URL", function(text)
    if string.find(text, "https://discord.com/api/webhooks/") then
        getgenv().settings.webhookBox = text;
        saveSettings()
    end
end,
{
    ["clear"] = false
})
webhookBox.Text = getgenv().settings.webhookBox
webhookTab:AddButton("Test Message", function()
    if getgenv().settings.webhookBox then
        webhook("Test")
    end
end)


--Server Hop Settings
local serverHopToggle = serverHopTab:AddSwitch("Auto Server Hop", function(bool)
    getgenv().settings.serverHopToggle = bool
    saveSettings()
end)
serverHopToggle:Set(getgenv().settings.serverHopToggle)
local serverHopDelay = serverHopTab:AddSlider("Server Hop Delay (M)", function(x)
    if settingsLock then
       return 
    end
    getgenv().settings.serverHopDelay = x
    coroutine.wrap(slider)(getgenv().settings.serverHopDelay, "serverHopDelay")
end,
{
    ["min"] = 1,
    ["max"] = 120
})
serverHopDelay:Set((getgenv().settings.serverHopDelay / 120) * 100)
serverHopTab:AddButton("Server Hop", function()
    serverHop()
end)
boothTab:Show()
library:FormatWindows()
settingsLock = false

--Finds unclaimed booths
local function findUnclaimed()
    for i, v in pairs(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:GetChildren()) do
        if (v.Details.Owner.Text == "unclaimed") then
            table.insert(unclaimed, tonumber(string.match(tostring(v), "%d+")))
        end
    end
end
if not pcall(findUnclaimed) then
    serverHop()
end
local claimCount = #unclaimed
--Claim booth function
local function boothclaim()
    require(game.ReplicatedStorage.Remotes).Event("ClaimBooth"):InvokeServer(unclaimed[1])
    if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI".. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
        wait(5)
        if not string.find(Players.LocalPlayer.PlayerGui.MapUIContainer.MapUI.BoothUI:FindFirstChild(tostring("BoothUI".. unclaimed[1])).Details.Owner.Text, Players.LocalPlayer.DisplayName) then
            error()
        end
    end
end
--Checks if booth claim fails
while not pcall(boothclaim) do
    if errCount >= claimCount then
        serverHop()
    end
    table.remove(unclaimed, 1)
    errCount = errCount + 1
end
require(game.ReplicatedStorage.Remotes).Event("RefreshItems"):InvokeServer()

--Walks to booth
Players.LocalPlayer.Character.Humanoid:MoveTo(Vector3.new(booths[tostring(unclaimed[1])]:match("(.+), (.+), (.+)")))
local atBooth = false
Players.LocalPlayer.Character.Humanoid.MoveToFinished:Connect(function(reached)
    atBooth = true
end)
while not atBooth do
    wait(0.1)
    local function noclip()
        for i,v in pairs(Players.LocalPlayer.Character:GetDescendants()) do
            if v:IsA("BasePart") then
                v.CanCollide = false
            end
        end
    end
    game:GetService("RunService").Stepped:Connect(noclip)
    if Players.LocalPlayer.Character.Humanoid:GetState() == Enum.HumanoidStateType.Seated then
        Players.LocalPlayer.Character.Humanoid.Jump = true
    end
end
Players.LocalPlayer.Character:SetPrimaryPartCFrame(CFrame.new(Players.LocalPlayer.Character.HumanoidRootPart.Position, Vector3.new(40, 14, 101)))
if getgenv().settings.danceToggle then
    wait(1)
    Players:Chat("/e dance2")
end
if getgenv().settings.textUpdateToggle and getgenv().settings.customBoothText then
    update()
end
local RaisedC = Players.LocalPlayer.leaderstats.Raised.value
Players.LocalPlayer.leaderstats.Raised.Changed:Connect(function()
    counter = 0
    if getgenv().settings.webhookToggle and getgenv().settings.webhookBox then
        local LogService = Game:GetService("LogService")
        local logs = LogService:GetLogHistory()
        --Tries to grabs donation message from logs
        if string.find(logs[#logs].message, Players.LocalPlayer.DisplayName) then
            webhook(tostring(logs[#logs].message.. " (Total: ".. Players.LocalPlayer.leaderstats.Raised.value.. ")"))
        else
            webhook(tostring("@everyone 💰 Somebody tipped! ".. Players.LocalPlayer.leaderstats.Raised.value - RaisedC.. " Robux to ".. Players.LocalPlayer.DisplayName.. " (Total: " .. Players.LocalPlayer.leaderstats.Raised.value.. ")"))
        end
    end
    RaisedC = Players.LocalPlayer.leaderstats.Raised.value
    if getgenv().settings.autoThanks then
        game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(getgenv().settings.thanksMessage[math.random(#getgenv().settings.thanksMessage)],"All")
    end
    wait(getgenv().settings.textUpdateDelay)
    if getgenv().settings.textUpdateToggle and getgenv().settings.customBoothText then
        update()
    end
end)

--Waits for donations
while wait(1) do
    counter = counter + 1
    if getgenv().settings.serverHopToggle then
        if counter >= (getgenv().settings.serverHopDelay * 60) then
            serverHop()
        end
    end
end

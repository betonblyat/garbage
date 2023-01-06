loadstring(game:HttpGet("https://raw.githubusercontent.com/betonblyat/garbage/main/pop-up%20text.lua"))()
game.StarterGui:SetCore("SendNotification", {
    Title = "Virginity 👉🥵";
    Text = "This shit loaded succesfully! Enjoy."; -- what the text says
    Duration = 5;
})
game.StarterGui:SetCore("SendNotification", {
    Title = "Credits - Clorium#3102";
    Text = "github.com/betonblyat"; -- what the text says
    Duration = 25;
})

local queueonteleport = (syn and syn.queue_on_teleport) or queue_on_teleport or (fluxus and fluxus.queue_on_teleport)
local httprequest = (syn and syn.request) or http and http.request or http_request or (fluxus and fluxus.request) or request
local httpservice = game:GetService('HttpService')
queueonteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/betonblyat/garbage/main/!%20virginity%20-%20Evade.lua'))()")

local WorkspacePlayers = game:GetService("Workspace").Game.Players
local Players = game:GetService('Players')
local localplayer = Players.LocalPlayer

local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/betonblyat/garbage/main/worst%20ui.lua"))()
local Esp = loadstring(game:HttpGet("https://raw.githubusercontent.com/betonblyat/garbage/main/EvadeEspUtil.lua"))()
Esp.Enabled = false
Esp.Tracers = false
Esp.Boxes = false

local Window = Library:CreateWindow("Virginity 👉🥵", Vector2.new(400, 450), Enum.KeyCode.RightControl)
local Evade = Window:CreateTab("Main")

local EvadeSector = Evade:CreateSector("Utility tool's", "left")
local Visuals = Evade:CreateSector("Visuals", "right")
local Credits = Evade:CreateSector("Credits x Info", "left")
local Farms = Evade:CreateSector("AutoFarm", "right")

local AutoFarms = Window:CreateTab("Shit")
local FarmStats = AutoFarms:CreateSector("Ticket farm stat's", "left")
local DurationLabelC5 = FarmStats:AddLabel('Duration: 0')
local EarnedLabelC5 = FarmStats:AddLabel('Abused: 0')
local TicketsLabelC5 = FarmStats:AddLabel('Total:'..localplayer:GetAttribute('Tickets'))

getgenv().Settings = {
    moneyfarm = false,
    afkfarm = false,
    TicketFarm = false,
    NoCameraShake = false,
    Downedplayeresp = false,
    AutoRespawn = false,
    ClickdDelete = false,
    --AutoCola = false,
    ClickTP = false,
    Speed = 1450,
    Jump = 3,
    reviveTime = 3,
    DownedColor = Color3.fromRGB(255,0,0),
    PlayerColor = Color3.fromRGB(255,170,0),
}

Visuals:AddToggle('No Camshake', false, function(State)
    Settings.NoCameraShake = State
end)

EvadeSector:AddToggle('Auto Respawn', false, function(State)
    Settings.AutoRespawn = State
end)

EvadeSector:AddButton('Respawn',function()
    game:GetService("ReplicatedStorage").Events.Respawn:FireServer()
end)

EvadeSector:AddButton('Rejoin', function()
local tpservice= game:GetService("TeleportService")
local plr = game.Players.LocalPlayer
tpservice:Teleport(game.PlaceId, plr)
end)

--EvadeSector:AddButton('Show Chat',function()
--end)

--EvadeSector:AddLabel('', false, function(State)
--end)

--EvadeSector:AddToggle('ClickDel - not work', false, function(State)
--	Settings.ClickDelete = State
--end)
--local Plr = game:GetService("Players").LocalPlayer
--local Mouse = Plr:GetMouse()
--Mouse.Button1Down:connect(function()
--if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
--if not Mouse.Target then return end
--Mouse.Target:Destroy()
--end)

--EvadeSector:AddToggle('ClickTP - not work', false, function(State)
--	Settings.ClickTP = State
--end)
--local Plr = game:GetService("Players").LocalPlayer
--local Mouse = Plr:GetMouse()
--Mouse.Button1Down:connect(function()
--if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
--if not Mouse.Target then return end
--Plr.Character:MoveTo(Mouse.Hit.p)
--end)

--EvadeSector:AddLabel('', false, function(State)
--end)

--EvadeSector:AddToggle('AutoUse - Cola',false, function(State)
--	Settings.AutoCola = State
--end)

--local AutoCola = function()
--    	while AutoCola = true do
--        local Q = "Cola"
--       game:GetService("ReplicatedStorage").Events.UseUsable:FireServer(Q)
--       wait(6)
--end)

Farms:AddToggle('Money Farm', false, function(State)
    Settings.moneyfarm = State
end)

Farms:AddToggle('XP Farm', false, function(State)
    Settings.afkfarm = State
end)

Farms:AddToggle('Ticket Farm - not work idk why', false, function(State)
	Settings.TicketFarm = State
end)

Visuals:AddToggle('Enable ESP', true, function(State)
    Esp.Enabled = State
end)

Visuals:AddToggle('NextBots', true, function(State)
    Esp.NPCs = State
end)

Visuals:AddToggle('Ticket', true, function(State)
    Esp.Ticket = State
end)

Visuals:AddToggle('Boxes', true, function(State)
    Esp.Boxes = State
end)

Visuals:AddToggle('Players', false, function(State)
    Esp.Players = State
end)

Visuals:AddToggle('Distance', false, function(State)
    Esp.Distance = State
end)

Visuals:AddColorpicker("Player Color", Color3.fromRGB(0, 255, 30), function(Color)
    Settings.PlayerColor = Color
end)

Credits:AddLabel("@Clorium ")
Credits:AddLabel("Gui bind - RightCtrl ")
Credits:AddLabel(" ")
Credits:AddLabel("github.com/betonblyat")

local FindAI = function()
    for _,v in pairs(WorkspacePlayers:GetChildren()) do
        if not Players:FindFirstChild(v.Name) then
            return v
        end
    end
end


local GetDownedPlr = function()
    for i,v in pairs(WorkspacePlayers:GetChildren()) do
        if v:GetAttribute("Downed") then
            return v
        end
    end
end

--Shitty Auto farm
local revive = function()
    local downedplr = GetDownedPlr()
    if downedplr ~= nil and downedplr:FindFirstChild('HumanoidRootPart') then
        task.spawn(function()
            while task.wait() do
                if localplayer.Character then
                    workspace.Game.Settings:SetAttribute("ReviveTime", 2.2)
                    localplayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(downedplr:FindFirstChild('HumanoidRootPart').Position.X, downedplr:FindFirstChild('HumanoidRootPart').Position.Y + 3, downedplr:FindFirstChild('HumanoidRootPart').Position.Z)
                    task.wait()
                    game:GetService("ReplicatedStorage").Events.Revive.RevivePlayer:FireServer(tostring(downedplr), false)
                    task.wait(4.5)
                    game:GetService("ReplicatedStorage").Events.Revive.RevivePlayer:FireServer(tostring(downedplr), true)
                    game:GetService("ReplicatedStorage").Events.Revive.RevivePlayer:FireServer(tostring(downedplr), true)
                    game:GetService("ReplicatedStorage").Events.Revive.RevivePlayer:FireServer(tostring(downedplr), true)
                    break
                end
            end
        end)
    end
end

--NexBot ESP
Esp:AddObjectListener(WorkspacePlayers, {
    Color =  Color3.fromRGB(255,0,0),
    Type = "Model",
    PrimaryPart = function(obj)
        local hrp = obj:FindFirstChild('HRP')
        while not hrp do
            wait()
            hrp = obj:FindFirstChild('HRP')
        end
        return hrp
    end,
    Validator = function(obj)
        return not game.Players:GetPlayerFromCharacter(obj)
    end,
    CustomName = function(obj)
        return '[BOT] '..obj.Name --return '[AI] '..obj.Name
    end,
    IsEnabled = "NPCs",
})

Esp:AddObjectListener(game:GetService("Workspace").Game.Effects.Tickets, {
    CustomName = "Ticket",
    Color = Color3.fromRGB(115, 230, 0),
    IsEnabled = "Ticket"
})

--ESP
Esp.Overrides.GetColor = function(char)
   local GetPlrFromChar = Esp:GetPlrFromChar(char)
   if GetPlrFromChar then
       if Settings.Downedplayeresp and GetPlrFromChar.Character:GetAttribute("Downed") then
           return Settings.DownedColor
       end
   end
   return Settings.PlayerColor
end

local old
old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local Args = {...}
    local method = getnamecallmethod()
    if tostring(self) == 'Communicator' and method == "InvokeServer" and Args[1] == "update" then
        return Settings.Speed, Settings.Jump 
    end
    return old(self,...)
end))

--Ticket farm
Esp.Overrides.GetColor = function(char)
   local GetPlrFromChar = Esp:GetPlrFromChar(char)
   if GetPlrFromChar then
       if Settings.Downedplayeresp and GetPlrFromChar.Character:GetAttribute("Downed") then
           return Settings.DownedColor
       end
   end
   return Settings.PlayerColor
end

local old
old = hookmetamethod(game,"__namecall",newcclosure(function(self,...)
    local Args = {...}
    local method = getnamecallmethod()
    if tostring(self) == 'Communicator' and method == "InvokeServer" and Args[1] == "update" then
        return Settings.Speed, Settings.Jump 
    end
    return old(self,...)
end))

local formatNumber = (function(value) -- //Credits: https://devforum.roblox.com/t/formatting-a-currency-label-to-include-commas/413670/3
	value = tostring(value)
	return value:reverse():gsub("%d%d%d", "%1,"):reverse():gsub("^,", "")
end)

function Format(Int) -- // Credits: https://devforum.roblox.com/t/converting-secs-to-hsec/146352
	return string.format("%02i", Int)
end

function convertToHMS(Seconds)
	local Minutes = (Seconds - Seconds%60)/60
	Seconds = Seconds - Minutes*60
	local Hours = (Minutes - Minutes%60)/60
	Minutes = Minutes - Hours*60
	return Format(Hours).."H "..Format(Minutes).."M "..Format(Seconds)..'S'
end

task.spawn(function()
    while task.wait(1) do
        if Settings.TicketFarm then
            Settings.stats.TicketFarm.duration += 1
        end
        if Settings.moneyfarm then
            Settings.stats.TokenFarm.duration += 1
        end 
    end
end)

local gettickets = localplayer:GetAttribute('Tickets')
local GetTokens = localplayer:GetAttribute('Tokens')

localplayer:GetAttributeChangedSignal('Tickets'):Connect(function()
    local tickets = tostring(gettickets - localplayer:GetAttribute('Tickets'))
    local cleanvalue = string.split(tickets, "-")
    Settings.stats.TicketFarm.earned = cleanvalue[2]
end)

localplayer:GetAttributeChangedSignal('Tokens'):Connect(function()
    local tokens = tostring(GetTokens - localplayer:GetAttribute('Tokens'))
    local cleanvalue = string.split(tokens, "-")
    print(cleanvalue[2])
    Settings.stats.TokenFarm.earned = cleanvalue[2]
end)

localplayer:GetAttributeChangedSignal('Tokens'):Connect(function()
    local tokens = tostring(GetTokens - localplayer:GetAttribute('Tokens'))
    local cleanvalue = string.split(tokens, "-")
    print(cleanvalue[2])
    Settings.stats.TokenFarm.earned = cleanvalue[2]
end)

task.spawn(function()
    while task.wait() do
        if Settings.TicketFarm then
            TypeLabelC5:Set('Ticket Farm')
            DurationLabelC5:Set('Duration:'..convertToHMS(Settings.stats.TicketFarm.duration))
            EarnedLabelC5:Set('Earned:'.. formatNumber(Settings.stats.TicketFarm.earned))
            TicketsLabelC5:Set('Total Tickets: '..localplayer:GetAttribute('Tickets'))

            if game.Players.LocalPlayer:GetAttribute('InMenu') ~= true and localplayer:GetAttribute('Dead') ~= true then
                for i,v in pairs(game:GetService("Workspace").Game.Effects.Tickets:GetChildren()) do
                    localplayer.Character.HumanoidRootPart.CFrame = CFrame.new(v:WaitForChild('HumanoidRootPart').Position)
                end
            else
                task.wait(2)
                game:GetService("ReplicatedStorage").Events.Respawn:FireServer()
            end
            if localplayer.Character and localplayer.Character:GetAttribute("Downed") then
                game:GetService("ReplicatedStorage").Events.Respawn:FireServer()
                task.wait(2)
            end
        end
    end
end)

--xp farm
task.spawn(function()
    while task.wait() do
        if Settings.AutoRespawn then
             if localplayer.Character and localplayer.Character:GetAttribute("Downed") then
                game:GetService("ReplicatedStorage").Events.Respawn:FireServer()
             end
        end

        if Settings.NoCameraShake then
            localplayer.PlayerScripts.CameraShake.Value = CFrame.new(0,0,0) * CFrame.new(0,0,0)
        end
        if Settings.moneyfarm then
            if localplayer.Character and localplayer.Character:GetAttribute("Downed") then
                game:GetService("ReplicatedStorage").Events.Respawn:FireServer()
                task.wait(3)
            else
                revive()
                task.wait(1)
            end
        end
        if Settings.moneyfarm == false and Settings.afkfarm and localplayer.Character:FindFirstChild('HumanoidRootPart') ~= nil then
            localplayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(1337, 6666, 1488)
        end
    end
end)

--anti afk
local GC = getconnections or get_signal_cons
	if GC then
		for i,v in pairs(GC(localplayer.Idled)) do
			if v["Disable"] then
				v["Disable"](v)
			elseif v["Disconnect"] then
				v["Disconnect"](v)
			end
		end
	else
		localplayer.Idled:Connect(function()
			local VirtualUser = game:GetService("VirtualUser")
			VirtualUser:CaptureController()
			VirtualUser:ClickButton2(Vector2.new())
		end)
	end
	
--shit with chat	

--This script reveals ALL hidden messages in the default chat
--chat "/LMAFAO WHAT" to toggle!
enabled = true
--if true will check your messages too
spyOnMyself = true
--if true will chat the logs publicly (fun, risky)
public = false
--if true will use /me to stand out
publicItalics = true
--customize private logs
privateProperties = {
	Color = Color3.fromRGB(255, 25, 90); 
	Font = Enum.Font.SourceSansBold;
	TextSize = 18;
}
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")
local player = Players.LocalPlayer or Players:GetPropertyChangedSignal("LocalPlayer"):Wait() or Players.LocalPlayer
local saymsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")
local getmsg = game:GetService("ReplicatedStorage"):WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("OnMessageDoneFiltering")
local instance = (_G.chatSpyInstance or 0) + 1
_G.chatSpyInstance = instance
 
local function onChatted(p,msg)
	if _G.chatSpyInstance == instance then
		if p==player and msg:lower():sub(1,4)=="/LMAFAO WHAT" then
			enabled = not enabled
			wait(0.3)
			privateProperties.Text = "Now u can read hidden chat"
			
			StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
		elseif enabled and (spyOnMyself==true or p~=player) then
			msg = msg:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ')
			local hidden = true
			local conn = getmsg.OnClientEvent:Connect(function(packet,channel)
				if packet.SpeakerUserId==p.UserId and packet.Message==msg:sub(#msg-#packet.Message+1) and (channel=="All" or (channel=="Team" and public==false and Players[packet.FromSpeaker].Team==player.Team)) then
					hidden = false
				end
			end)
			wait(1)
			conn:Disconnect()
			if hidden and enabled then
				if public then
					saymsg:FireServer((publicItalics and "/me " or '').."[DM's] [".. p.Name .."]: "..msg,"All")
				else
					privateProperties.Text = "[DM's] [".. p.Name .."]: "..msg
					StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
				end
			end
		end
	end
end
 
for _,p in ipairs(Players:GetPlayers()) do
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end
Players.PlayerAdded:Connect(function(p)
	p.Chatted:Connect(function(msg) onChatted(p,msg) end)
end)
privateProperties.Text = "Virginity script, 👉🥵 - github.com/betonblyat                                                                                                          If u wanna see chat, u need re-execute script EVERY new map."
StarterGui:SetCore("ChatMakeSystemMessage",privateProperties)
if not player.PlayerGui:FindFirstChild("Chat") then wait(3) end
local chatFrame = player.PlayerGui.Chat.Frame
chatFrame.ChatChannelParentFrame.Visible = true
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position+UDim2.new(UDim.new(),chatFrame.ChatChannelParentFrame.Size.Y)

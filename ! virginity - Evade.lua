loadstring(game:HttpGet("https://raw.githubusercontent.com/betonblyat/garbage/main/pop-up%20text.lua"))()

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

local Window = Library:CreateWindow("Virginity 🥵", Vector2.new(400, 350), Enum.KeyCode.RightControl)
local Evade = Window:CreateTab("Main")

local EvadeSector = Evade:CreateSector("Utility tool's", "left")
local Visuals = Evade:CreateSector("Visuals", "right")
local Credits = Evade:CreateSector("Who paste?", "left")
local Farms = Evade:CreateSector("AutoFarm", "right")

getgenv().Settings = {
    moneyfarm = false,
    afkfarm = false,
    NoCameraShake = false,
    Downedplayeresp = false,
    AutoRespawn = false,
    ClickdDelete = false,
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

EvadeSector:AddLabel('', false, function(State)
end)

EvadeSector:AddToggle('ClickDel - not work', false, function(State)
	Settings.ClickDelete = State
end)
--local Plr = game:GetService("Players").LocalPlayer
--local Mouse = Plr:GetMouse()
--Mouse.Button1Down:connect(function()
--if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
--if not Mouse.Target then return end
--Mouse.Target:Destroy()
--end)

EvadeSector:AddToggle('ClickTP - not work', false, function(State)
	Settings.ClickTP = State
end)
--local Plr = game:GetService("Players").LocalPlayer
--local Mouse = Plr:GetMouse()
--Mouse.Button1Down:connect(function()
--if not game:GetService("UserInputService"):IsKeyDown(Enum.KeyCode.LeftControl) then return end
--if not Mouse.Target then return end
--Plr.Character:MoveTo(Mouse.Hit.p)
--end)

Farms:AddToggle('Money farm', false, function(State)
    Settings.moneyfarm = State
end)

Farms:AddToggle('Full AFK', false, function(State)
    Settings.afkfarm = State
end)

Visuals:AddToggle('Enable ESP', true, function(State)
    Esp.Enabled = State
end)

Visuals:AddToggle('NextBots', true, function(State)
    Esp.NPCs = State
end)

Visuals:AddToggle('Event items', true, function(State)
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
        return ' '..obj.Name --return '[AI] '..obj.Name
    end,
    IsEnabled = "NPCs",
})

Esp:AddObjectListener(game:GetService("Workspace").Game.Effects.Tickets, {
    CustomName = "Event Item",
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
            localplayer.Character:FindFirstChild('HumanoidRootPart').CFrame = CFrame.new(6007, 7005, 8005)
        end
    end
end)

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

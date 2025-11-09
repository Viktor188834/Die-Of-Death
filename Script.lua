local Guis = loadstring(game:HttpGet("https://raw.githubusercontent.com/Viktor188834/GuiCanMakeYou/refs/heads/main/Script.lua"))()
--Kavo:AddSliderButton(MinValue, MaxValue, Text, FunctionWithNumber, TextOnMouseEnter)

local Click_Delete = Guis:AddSection("Click To Delete")
local Abilities = require(game:GetService("ReplicatedStorage").ClientModules.AbilityConfig)
local To_Abilities_Use1 = {}
local Ability_Use1 = "Punch"
local To_Abilities_Use2 = {}
local Ability_Use2 = "Block"
local To_Abilities_Use3 = {}
local Ability_Use3 = "Revolver"
local To_Abilities_Use4 = {}
local Ability_Use4 = "Taunt"
local Use_Ability = {}

for i,v in Abilities do
	if v.IsSurvivorAbility == true then
		table.insert(To_Abilities_Use1, {v.Name, function()
			Ability_Use1 = v.Name
		end})
		table.insert(To_Abilities_Use2, {v.Name, function()
			Ability_Use2 = v.Name
		end})
		table.insert(To_Abilities_Use3, {v.Name, function()
			Ability_Use3 = v.Name
		end})
		table.insert(To_Abilities_Use4, {v.Name, function()
			Ability_Use4 = v.Name
		end})
		table.insert(Use_Ability, {v.Name, function()
			game:GetService("ReplicatedStorage").Events.RemoteFunctions.UseAbility:InvokeServer(v.Name)
		end})
	end
end

local Ons = {}
for i=1, 999 do
	Ons[i] = false
end

local plr = game.Players.LocalPlayer
local char = plr.Character
local m = plr:GetMouse()
local M1Active = false
local MMoved = false

plr.CharacterAdded:Connect(function(newchar)
	char = newchar
end)

m.Button1Down:Connect(function()
	M1Active = true
end)

m.Button1Up:Connect(function()
	M1Active = false
end)

m.Move:Connect(function()
	MMoved = true
	wait(0.02)
	MMoved = false
end)

Click_Delete:AddSlideButton("Destroy Mode", function()
	Ons[1] = true
	repeat
		local tar = m.Target
		local Highlight = Instance.new("Highlight")
		Highlight.FillTransparency = 1
		Highlight.Parent = tar
		Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)
		repeat
			wait()
		until M1Active == true or MMoved == true
		if M1Active == true and Ons[1] == true then
			tar:Destroy()
		end
		Highlight:Destroy()
		repeat
			wait()
		until M1Active == false
	until Ons[1] ~= true
end, function()
	Ons[1] = false
end)

local Dead_By_Death = Guis:AddSection("Dead By Death")

Dead_By_Death:AddClickButton("Killer Doors", function()
	for i,v in workspace:WaitForChild("GameAssets"):WaitForChild("Map"):WaitForChild("Config"):WaitForChild("KillerOnly"):GetChildren() do
		v.Transparency = 0.95
		v.CanCollide = false
	end
end, "Destroy Killer Doors")

Dead_By_Death:AddSliderButton(10, 250, "MaxStamina", function(value)
	char:SetAttribute("MaxStamina", value)
end)

Dead_By_Death:AddSliderButton(10, 55, "SprintSpeed", function(value)
	char:SetAttribute("SprintSpeed", value)
end)

Dead_By_Death:AddClickButton("KillerIntro", function()
	plr.PlayerGui.MainGui.KillerIntro.Visible = false
end)

local t1 = Dead_By_Death:Text("Ability 1: "..Ability_Use1)

Dead_By_Death:SelectButtons("Ability To Use 1", nil, nil, nil, To_Abilities_Use1)

Dead_By_Death:AddKeybind("Use Ability Keybind 1", function()
	local v = game:GetService("ReplicatedStorage").Events.RemoteFunctions.UseAbility:InvokeServer(Ability_Use1)
end, Enum.KeyCode.Z)

local t2 = Dead_By_Death:Text("Ability 2: "..Ability_Use2)

Dead_By_Death:SelectButtons("Ability To Use 2", nil, nil, nil, To_Abilities_Use2)

Dead_By_Death:AddKeybind("Use Ability Keybind 2", function()
	local v = game:GetService("ReplicatedStorage").Events.RemoteFunctions.UseAbility:InvokeServer(Ability_Use2)
end, Enum.KeyCode.X)

local t3 = Dead_By_Death:Text("Ability 3: "..Ability_Use3)

Dead_By_Death:SelectButtons("Ability To Use 3", nil, nil, nil, To_Abilities_Use3)

Dead_By_Death:AddKeybind("Use Ability Keybind 3", function()
	local v = game:GetService("ReplicatedStorage").Events.RemoteFunctions.UseAbility:InvokeServer(Ability_Use3)
end, Enum.KeyCode.C)

local t4 = Dead_By_Death:Text("Ability 4: "..Ability_Use4)

Dead_By_Death:SelectButtons("Ability To Use 4", nil, nil, nil, To_Abilities_Use4)

Dead_By_Death:AddKeybind("Use Ability Keybind 4", function()
	local v = game:GetService("ReplicatedStorage").Events.RemoteFunctions.UseAbility:InvokeServer(Ability_Use4)
end, Enum.KeyCode.V)

Dead_By_Death:SelectButtons("Use Ability", nil, nil, nil, Use_Ability)

game:GetService("RunService").Heartbeat:Connect(function()
	t1.Text = "Ability 1: "..Ability_Use1
	t2.Text = "Ability 2: "..Ability_Use2
	t3.Text = "Ability 3: "..Ability_Use3
	t4.Text = "Ability 4: "..Ability_Use4
end)

local Something_Players = Guis:AddSection("Players")
local target_player = nil

Something_Players:AddButtonToSelectPlayer("Choose Player", function(Player)
	target_player = Player
end)

Something_Players:AddClickButton("Highlight", function()
	if not target_player then return end
	local character = target_player.Character
	local Highlight = Instance.new("Highlight")
	Highlight.Parent = character
	Highlight.FillTransparency = 1
end)

Something_Players:AddClickButton("Tp To", function()
	if not target_player then return end
	char:WaitForChild("HumanoidRootPart").CFrame = target_player.Character:WaitForChild("HumanoidRootPart").CFrame
end)

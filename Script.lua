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
local plr = game.Players.LocalPlayer
local char = plr.Character
local m = plr:GetMouse()
local M1Active = false
local MMoved = false

plr.PlayerGui.MainGui.Abilities.Position = UDim2.new(0.248, 0, 0.7, 0)
if plr.PlayerGui.MainGui:FindFirstChild("ScriptAbiliti's") then
	plr.PlayerGui.MainGui:FindFirstChild("ScriptAbiliti's"):Destroy()
end
if plr.PlayerGui:FindFirstChild("scriptAbilities") then
	plr.PlayerGui:FindFirstChild("scriptAbilities"):Destroy()
end
local Gui = Instance.new("ScreenGui")
Gui.Parent = plr.PlayerGui
Gui.Name = "scriptAbilities"
Gui.ResetOnSpawn = false
Gui.IgnoreGuiInset = true
local ScriptAbilities = plr.PlayerGui.MainGui.Abilities:Clone()
ScriptAbilities.Name = "ScriptAbiliti's"
ScriptAbilities.Folder.Name = "FolderAbilitiesVisual"
ScriptAbilities.Tip.Name = "ForUnIdk"
ScriptAbilities.Parent = Gui
ScriptAbilities.Position = UDim2.new(0.248, 0, 0.84, 0)
local AbilitiesFolder = ScriptAbilities:FindFirstChildOfClass("Folder")
plr.PlayerGui.MainGui.RoundUI.PlayerUI.Position = UDim2.new(-0.04, 0, 0.65, 0)

local Templates = {}

local function FindAbilityInStorage(name: string)
	for i,v in Abilities do
		if v.Name and v.Name == name then
			return v
		end
	end
end

for i,v in Abilities do
	if v.IsSurvivorAbility == true then
		table.insert(To_Abilities_Use1, {v.Name, function()
			Ability_Use1 = v.Name
		end, v})
		table.insert(To_Abilities_Use2, {v.Name, function()
			Ability_Use2 = v.Name
		end, v})
		table.insert(To_Abilities_Use3, {v.Name, function()
			Ability_Use3 = v.Name
		end, v})
		table.insert(To_Abilities_Use4, {v.Name, function()
			Ability_Use4 = v.Name
		end, v})
		table.insert(Use_Ability, {v.Name, function()
			game:GetService("ReplicatedStorage").Events.RemoteFunctions.UseAbility:InvokeServer(v.Name)
		end, v})
	end
end

local idk1 = {
	[1] = To_Abilities_Use1,
	[2] = To_Abilities_Use2,
	[3] = To_Abilities_Use3,
	[4] = To_Abilities_Use4,
}
local idk2 = {
	[1] = Enum.KeyCode.Z,
	[2] = Enum.KeyCode.X,
	[3] = Enum.KeyCode.C,
	[4] = Enum.KeyCode.V,
}
local idk3 = {
	[1] = Ability_Use1,
	[2] = Ability_Use2,
	[3] = Ability_Use3,
	[4] = Ability_Use4,
}

for i,v in AbilitiesFolder:GetChildren() do
	if not v:IsA("UIListLayout") then
		v:Destroy()
	end
end

local ShootedRevolver = false
for i=1, 4 do
	Templates[i] = plr.PlayerGui.MainGui.Client.Modules.Ability.AbilityTemplate:Clone()
	local temp = Templates[i]
	temp.Parent = AbilitiesFolder
	local Info = FindAbilityInStorage(idk3[i])
	local KeyCode = idk2[i]
	temp:WaitForChild("Icon").Image = Info.Icon
	temp.Name = Info.Name
	temp:WaitForChild("Title").Text = Info.Name
	temp:WaitForChild("Input").Text = KeyCode.Name
	temp.BackgroundTransparency = 1
	local cd = false
	game:GetService("UserInputService").InputBegan:Connect(function(i, g)
		if g then return end
		if i.KeyCode == KeyCode and cd == false then
			ShootedRevolver = not ShootedRevolver
			cd = true
			temp.Cooldown.Visible = true
			game:GetService("TweenService"):Create(temp.Cooldown, 
				TweenInfo.new(Info.Cooldown, Enum.EasingStyle.Linear), {Size = UDim2.new(1, 0, 0, 0)}):Play()
			task.spawn(function()
				for i=(Info.Cooldown), 1, -1 do
					temp:WaitForChild("CooldownLabel").Visible = true
					temp:WaitForChild("CooldownLabel").Text = i.."s"
					wait(1)
				end
				temp:WaitForChild("CooldownLabel").Visible = false
			end)
			task.delay(Info.Cooldown, function()
				temp.Cooldown.Visible = false
				temp.Cooldown.Size = UDim2.new(1, 0, 1, 0)
				cd = false
			end)
			task.spawn(function()
				game:GetService("ReplicatedStorage").Events.RemoteFunctions.UseAbility:InvokeServer(idk3[i])
			end)
		end
	end)
	task.spawn(function()
		while true do
			Info = FindAbilityInStorage(idk3[i])
			wait(0.8)
			temp.Name = Info.Name
			temp.Icon.Image = Info.Icon
			temp.Name = Info.Name
			temp.Title.Text = Info.Name
			temp.Input.Text = KeyCode.Name
			if Info.Name == "Revolver" then
				temp.Revolver.Visible = true
				if ShootedRevolver == true then
					temp.Revolver.Label.Text = "0/1"
				else
					temp.Revolver.Label.Text = "1/1"
				end
			else
				temp.Revolver.Visible = false
			end
		end
	end)
end

local Ons = {}
for i=1, 999 do
	Ons[i] = false
end

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
local MaxStamina = 100
local SprintSpeed = 28
Dead_By_Death:AddSliderButton(10, 500, "MaxStamina", function(value)
	char:SetAttribute("MaxStamina", value)
	MaxStamina = value
end)

Dead_By_Death:AddSliderButton(10, 70, "SprintSpeed", function(value)
	char:SetAttribute("SprintSpeed", value)
	SprintSpeed = value
end)

Dead_By_Death:AddSlideButton("Always Set Attribute", function()
	Ons[2] = true
	repeat
		char:SetAttribute("SprintSpeed", SprintSpeed)
		char:SetAttribute("MaxStamina", MaxStamina)
		wait()
	until Ons[2] == false
end, function()
	Ons[2] = false
end)

Dead_By_Death:AddClickButton("KillerIntro", function()
	plr.PlayerGui.MainGui.KillerIntro.Visible = false
end)

local t1 = Dead_By_Death:Text("Ability 1: "..Ability_Use1)

Dead_By_Death:SelectButtons("Ability To Use 1", nil, nil, nil, To_Abilities_Use1)

local t2 = Dead_By_Death:Text("Ability 2: "..Ability_Use2)

Dead_By_Death:SelectButtons("Ability To Use 2", nil, nil, nil, To_Abilities_Use2)

local t3 = Dead_By_Death:Text("Ability 3: "..Ability_Use3)

Dead_By_Death:SelectButtons("Ability To Use 3", nil, nil, nil, To_Abilities_Use3)

local t4 = Dead_By_Death:Text("Ability 4: "..Ability_Use4)

Dead_By_Death:SelectButtons("Ability To Use 4", nil, nil, nil, To_Abilities_Use4)

Dead_By_Death:SelectButtons("Use Ability", nil, nil, nil, Use_Ability)

game:GetService("RunService").Heartbeat:Connect(function()
	t1.Text = "Ability 1: "..Ability_Use1
	t2.Text = "Ability 2: "..Ability_Use2
	t3.Text = "Ability 3: "..Ability_Use3
	t4.Text = "Ability 4: "..Ability_Use4
	idk3[1] = Ability_Use1
	idk3[2] = Ability_Use2
	idk3[3] = Ability_Use3
	idk3[4] = Ability_Use4
end)

local Something_Players = Guis:AddSection("Players")
local target_player = nil

Something_Players:AddClickButton("hp Everyone", function()
	local TextColorStorage = {
		{100, Color3.fromRGB(0, 255, 0)},
		{50, Color3.fromRGB(255, 251, 0)},
		{25, Color3.fromRGB(200, 100, 0)},
		{15, Color3.fromRGB(255, 19, 0)},
		{5, Color3.fromRGB(255, 15, 15)},
		{1, Color3.fromRGB(0, 0, 0)}
	}

	function HealthStandUp(Model: Model)
		if Model:FindFirstChild("Health") then
			Model:FindFirstChild("Health"):Destroy()
		end
		local Billboard = Instance.new("BillboardGui")
		local TextLabel = Instance.new("TextLabel")
		local DiedImage = Instance.new("ImageLabel")
		local Humanoid = Model:WaitForChild("Humanoid")
		Billboard.Parent = Model
		Billboard.Name = "Health"
		Billboard.Size = UDim2.new(3, 0, 1, 0)
		Billboard.Adornee = Model
		Billboard.AlwaysOnTop = true
		Billboard.ResetOnSpawn = false
		TextLabel.Parent = Billboard
		TextLabel.Size = UDim2.new(1, 0, 1, 0)
		TextLabel.Text = tostring(Humanoid.Health)..".hp"
		TextLabel.TextStrokeTransparency = 0
		TextLabel.TextScaled = true
		TextLabel.TextWrapped = true
		TextLabel.BackgroundTransparency = 1
		DiedImage.Size = UDim2.new(0.33, 0, 1, 0)
		DiedImage.Image = "http://www.roblox.com/asset/?id=87707211255607"
		DiedImage.Parent = Billboard
		DiedImage.BackgroundTransparency = 1
		DiedImage.ImageTransparency = 1
		DiedImage.Position = UDim2.new(0.33, 0, 0, 0)
		local function TextLabelChangeColor(health)
			local Lowest = 100
			local Color = TextColorStorage[1][2]
			for i,v in TextColorStorage do
				if v[1] > health then
					Lowest = v[1]
					Color = v[2]
				end
			end
			game:GetService("TweenService"):Create(TextLabel, TweenInfo.new(0.9), {TextColor3 = Color}):Play()
		end
		TextLabelChangeColor(100)
		Humanoid.HealthChanged:Connect(function()
			local health = Humanoid.Health
			TextLabel.Text = tostring(health)..".hp"
			TextLabelChangeColor(health)
			if health <= 0 and DiedImage.ImageTransparency >= 1 then
				game:GetService("TweenService"):Create(DiedImage, TweenInfo.new(0.8), {ImageTransparency = 0}):Play()
				TextLabel.Text = ""
			end
		end)
	end

	for i,plr in game.Players:GetPlayers() do
		HealthStandUp(plr.Character)
	end
end)

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

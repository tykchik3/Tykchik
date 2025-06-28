
local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local hrp = char:WaitForChild("HumanoidRootPart")

local gui = Instance.new("ScreenGui", player:WaitForChild("PlayerGui"))
gui.Name = "Tykchik3_Delta"

local frame = Instance.new("Frame", gui)
frame.Size = UDim2.new(0, 200, 0, 160)
frame.Position = UDim2.new(1, -210, 0, 100)
frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
frame.BorderSizePixel = 0
Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 8)

local title = Instance.new("TextLabel", frame)
title.Text = "🍅 Tykchik3"
title.Size = UDim2.new(1, 0, 0, 30)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.GothamBold
title.TextSize = 18

local fruitList = {"Tomato", "Avocado", "Banana", "Kiwi", "Melon", "Pear", "Cucumber", "Wild Carrot", "Pineapple", "Carrot", "Potato"}
local selectedFruit = "Tomato"
local running = false
local cachedFruits = {}

local drop = Instance.new("TextButton", frame)
drop.Position = UDim2.new(0, 10, 0, 40)
drop.Size = UDim2.new(1, -20, 0, 30)
drop.Text = "Фрукт: Tomato"
drop.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
drop.TextColor3 = Color3.fromRGB(255, 255, 255)
drop.Font = Enum.Font.Gotham
drop.TextSize = 14
Instance.new("UICorner", drop).CornerRadius = UDim.new(0, 6)

drop.MouseButton1Click:Connect(function()
	local i = table.find(fruitList, selectedFruit) or 1
	i = (i % #fruitList) + 1
	selectedFruit = fruitList[i]
	drop.Text = "Фрукт: " .. selectedFruit
	cachedFruits = {}
end)

local toggle = Instance.new("TextButton", frame)
toggle.Position = UDim2.new(0, 10, 0, 80)
toggle.Size = UDim2.new(1, -20, 0, 30)
toggle.Text = "▶️ Запустити"
toggle.BackgroundColor3 = Color3.fromRGB(70, 130, 70)
toggle.TextColor3 = Color3.fromRGB(255, 255, 255)
toggle.Font = Enum.Font.GothamBold
toggle.TextSize = 14
Instance.new("UICorner", toggle).CornerRadius = UDim.new(0, 6)

toggle.MouseButton1Click:Connect(function()
	running = not running
	toggle.Text = running and "⏹️ Зупинити" or "▶️ Запустити"
	toggle.BackgroundColor3 = running and Color3.fromRGB(200, 80, 80) or Color3.fromRGB(70, 130, 70)
end)

task.spawn(function()
	while true do
		if running then
			cachedFruits = {}
			for _, obj in ipairs(workspace:GetDescendants()) do
				if obj:IsA("TouchTransmitter") and obj.Parent then
					local item = obj.Parent
					if item.Name:lower():find(selectedFruit:lower()) then
						table.insert(cachedFruits, item)
					end
				end
			end
		else
			cachedFruits = {}
		end
		task.wait(1)
	end
end)

task.spawn(function()
	while true do
		if running then
			for _, item in ipairs(cachedFruits) do
				if item and item.Parent then
					firetouchinterest(hrp, item, 0)
					task.wait(0.05)
					firetouchinterest(hrp, item, 1)
				end
			end
		end
		task.wait(0.3)
	end
end)

task.spawn(function()
	while true do
		if running then
			local gui = player:FindFirstChild("PlayerGui")
			if gui then
				for _, btn in ipairs(gui:GetDescendants()) do
					if btn:IsA("TextButton") and btn.Text and btn.Text:lower():find("take all") then
						pcall(function() btn:Activate() end)
					end
				end
			end
		end
		task.wait(2.5)
	end
end)

print("✅ Tykchik3 (оптимизировано) запущено!")

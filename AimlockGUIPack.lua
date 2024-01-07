local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/NICKISBAD/Nick-s-Modded-KAVO-Lib/main/Nick'sModdedKavoLib.lua"))()

local colors = {
    SchemeColor = Color3.fromRGB(100,0,255),
    Background = Color3.fromRGB(0, 0, 0),
    Header = Color3.fromRGB(0, 0, 0),
    TextColor = Color3.fromRGB(255,255,255),
    ElementColor = Color3.fromRGB(20, 20, 20)
}

local Window = Library.CreateLib("AimLock Gui Pack", colors)

local Tab = Window:NewTab("Main")

local Section = Tab:NewSection("buttons")

Section:NewButton("Aimlock v1", "Teamcheck,No WallCheck", function()
	local player = game.Players.LocalPlayer
	local camera = workspace.CurrentCamera
	local Active = false
	
	local function findplr()
	    local nearplr, shrtdist, player2 = nil, math.huge, player.Character
	    
	    for _, plr3 in pairs(game.Players:GetPlayers()) do
	        if plr3 ~= player and plr3.Character and plr3.Team ~= player.Team then
	            local distance = (player2.HumanoidRootPart.Position - plr3.Character.HumanoidRootPart.Position).Magnitude
	            
	            if distance < shrtdist then
	                nearplr, shrtdist = plr3, distance
	            end
	        end
	    end
	    
	    return nearplr
	end
	
	local function lockon()
	    while Active and wait() do
	        local target = findplr()
	        
	        if target then
	            local hum = target.Character:FindFirstChild("Humanoid")
	            
	            if hum and hum.Health > 0 then
	                local targpos = hum.Parent.Head.Position
	                local campos = camera.CFrame.Position
	                local lookvec = (targpos - campos).unit
	                local newcampos = targpos - lookvec
	                camera.CFrame = CFrame.new(newcampos, targpos)
	            else
	                wait(0.1)
	            end
	        end
	    end
	end
	
	local function toggle()
	    Active = not Active
	    
	    if Active then
	        lockon()
	    end
	end
	
	local gui = Instance.new("ScreenGui")
	gui.Name = "LockOnGui"
	local button = Instance.new("TextButton")
	button.Text = "Toggle Lock-On"
	button.Size = UDim2.new(0, 150, 0, 50)
	button.Position = UDim2.new(0.5, -75, 0.01, 0)
	button.Parent = gui
	button.MouseButton1Click:Connect(toggle)
	gui.Parent = game.CoreGui
	button.BackgroundColor3 = Color3.new(0, 0, 0)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Font = Enum.Font.SourceSans
	button.TextScaled = true
	button.TextStrokeTransparency = 0
	button.TextStrokeColor3 = Color3.new(0, 0, 0)
	button.TextWrapped = true
end)

Section:NewButton("Aimlock v2", "Raycasting, TeamCheck", function()
	local player = game.Players.LocalPlayer
	local camera = workspace.CurrentCamera
	local Active = false
	
	local function findplr()
	    local nearplr, shrtdist, player2 = nil, math.huge, player.Character
	    
	    for _, plr3 in pairs(game.Players:GetPlayers()) do
	        if plr3 ~= player and plr3.Character and plr3.Team ~= player.Team then
	            local distance = (player2.HumanoidRootPart.Position - plr3.Character.HumanoidRootPart.Position).Magnitude
	            
	            if distance < shrtdist then
	                nearplr, shrtdist = plr3, distance
	            end
	        end
	    end
	    
	    return nearplr
	end
	
	local function lockon()
	    while Active and wait() do
	        local target = findplr()
	        
	        if target then
	            local hum = target.Character:FindFirstChild("Humanoid")
	            
	            if hum and hum.Health > 0 then
	                local targpos = hum.Parent.HumanoidRootPart.Position
	                local campos = camera.CFrame.Position
	                local lookvec = (targpos - campos).unit
	                
	                local rayParams = RaycastParams.new()
	                rayParams.FilterDescendantsInstances = {player.Character, target.Character}
	                
	                local ray = workspace:Raycast(campos, lookvec * 100, rayParams)
	                
	                if ray then
	                    wait()
	                else
	                    local newcampos = targpos - lookvec
	                    camera.CFrame = CFrame.new(newcampos, targpos)
	                end
	            else
	                wait()
	            end
	        end
	    end
	end
	
	local function toggle()
	    Active = not Active
	    
	    if Active then
	        lockon()
	    end
	end
	
	local ESPLib = {}
	
	function ESPLib:CreateESPTag(params)
	    local RunService = game:GetService("RunService")
	    local player = game.Players.LocalPlayer
	    local camera = game:GetService("Workspace").CurrentCamera
	    local Text = params.Text
	    local Part = params.Part
	    local TextSize = params.TextSize
	    local TextColor = params.TextColor
	    local BoxColor = params.BoxColor
	    
	    local esp = Instance.new("BillboardGui")
	    esp.Name = "esp"
	    esp.Size = UDim2.new(0, 200, 0, 50)
	    esp.StudsOffset = Vector3.new(0, 1.5, 0)
	    esp.Adornee = Part
	    esp.Parent = Part
	    esp.AlwaysOnTop = true
	    
	    local esplabelfr = Instance.new("TextLabel")
	    esplabelfr.Name = "esplabelfr"
	    esplabelfr.Size = UDim2.new(1, 0, 0, 70)
	    esplabelfr.BackgroundColor3 = Color3.new(0, 0, 0)
	    esplabelfr.TextColor3 = TextColor or Color3.fromRGB(255, 255, 255)
	    esplabelfr.BackgroundTransparency = 1
	    esplabelfr.TextStrokeTransparency = 0
	    esplabelfr.TextStrokeColor3 = Color3.new(0, 0, 0)
	    esplabelfr.TextSize = TextSize
	    esplabelfr.TextScaled = false
	    esplabelfr.Parent = esp
	    
	    local box = Instance.new("BoxHandleAdornment")
	    box.Name = "box"
	    box.Size = Part.Size + Vector3.new(0.5, 0.5, 0.5)
	    box.Adornee = Part
	    box.AlwaysOnTop = true
	    box.Transparency = 0.6
	    box.Color3 = BoxColor or Color3.new(0, 0, 255)
	    box.ZIndex = 0
	    box.Parent = Part
	    
	    local function updateesplabelfr()
	        local playerPosition = player.Character and player.Character:FindFirstChild("humRootPart")
	        
	        if playerPosition then
	            local distance = (playerPosition.Position - Part.Position).Magnitude
	            esplabelfr.Text = string.format(Text .. ": %.2f", distance)
	            local headPosition = Part.Position + Vector3.new(0, Part.Size.Y / 2, 0)
	            local screenPosition, onScreen = camera:WorldToScreenPoint(headPosition)
	            
	            if onScreen or playerPosition.Position.Y > Part.Position.Y then
	                esp.Adornee = Part
	                esp.Enabled = true
	                box.Adornee = Part
	                box.Visible = true
	            else
	                esp.Enabled = false
	                box.Visible = false
	            end
	        else
	            esp.Enabled = false
	            box.Visible = false
	        end
	    end
	    
	    RunService.RenderStepped:Connect(updateesplabelfr)
	end
	
	function ESPLib:PlayerESP()
	    while wait(1) do
	        for _, player in pairs(game.Players:GetChildren()) do
	            if player:IsA("Player") and player.Name ~= game.Players.LocalPlayer.Name then
	                ESPLib:CreateESPTag({
	                    Text = player.DisplayName .. "/" .. player.Name,
	                    Part = player.Character.HumanoidRootPart,
	                    TextSize = 12,
	                    TextColor = Color3.new(255, 255, 255),
	                    BoxColor = Color3.new(255, 255, 255)
	                })
	            end
	        end
	    end
	end
	
	local gui = Instance.new("ScreenGui")
	gui.Name = "LockOnGui"
	local button = Instance.new("TextButton")
	button.Text = "Toggle Lock-On"
	button.Size = UDim2.new(0, 150, 0, 50)
	button.Position = UDim2.new(0.5, -75, 0.01, 0)
	button.Parent = gui
	button.MouseButton1Click:Connect(toggle)
	gui.Parent = game.CoreGui
	button.BackgroundColor3 = Color3.new(0, 0, 0)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Font = Enum.Font.SourceSans
	button.TextScaled = true
	button.TextStrokeTransparency = 0
	button.TextStrokeColor3 = Color3.new(0, 0, 0)
	button.TextWrapped = true
	Instance.new("UICorner", button)
end)

Section:NewButton("Aimlock v3", "aims at all, no team check", function()
	local player = game.Players.LocalPlayer
	local camera = workspace.CurrentCamera
	local Active = false
	
	local function findplr()
	    local nearplr, shrtdist, player2 = nil, math.huge, player.Character
	    
	    for _, plr3 in pairs(game.Players:GetPlayers()) do
	        if plr3 ~= player and plr3.Character then
		        local distance = (player2.HumanoidRootPart.Position - plr3.Character.HumanoidRootPart.Position).Magnitude
		        
		        if distance < shrtdist then
		            nearplr, shrtdist = plr3, distance
		        end
		    end
	    end
	    
	    return nearplr
	end
	
	local function lockon()
	    while Active and wait() do
	        local target = findplr()
	        
	        if target then
	            local hum = target.Character:FindFirstChild("Humanoid")
	            
	            if hum and hum.Health > 0 then
	                local targpos = hum.Parent.Head.Position
	                local campos = camera.CFrame.Position
	                local lookvec = (targpos - campos).unit
	                local newcampos = targpos - lookvec
	                camera.CFrame = CFrame.new(newcampos, targpos)
	            else
	                wait(0.1)
	            end
	        end
	    end
	end
	
	local function toggle()
	    Active = not Active
	    
	    if Active then
	        lockon()
	    end
	end
	
	local gui = Instance.new("ScreenGui")
	gui.Name = "LockOnGui"
	local button = Instance.new("TextButton")
	button.Text = "Toggle Lock-On"
	button.Size = UDim2.new(0, 150, 0, 50)
	button.Position = UDim2.new(0.5, -75, 0.01, 0)
	button.Parent = gui
	button.MouseButton1Click:Connect(toggle)
	gui.Parent = game.CoreGui
	button.BackgroundColor3 = Color3.new(0, 0, 0)
	button.TextColor3 = Color3.new(1, 1, 1)
	button.BorderSizePixel = 0
	button.AutoButtonColor = false
	button.Font = Enum.Font.SourceSans
	button.TextScaled = true
	button.TextStrokeTransparency = 0
	button.TextStrokeColor3 = Color3.new(0, 0, 0)
	button.TextWrapped = true
end)

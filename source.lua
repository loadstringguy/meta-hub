print('Initializing AC Bypass!')

if not LPH_OBFUSCATED then
    getfenv().LPH_NO_VIRTUALIZE = function(f) return f end
  end
  

  local ReplicatedStorage = game:GetService("ReplicatedStorage")
  

  local Handshake = ReplicatedStorage.Remotes.CharacterSoundEvent
  local Hooks = {}
  local HandshakeInts = {}
  
  LPH_NO_VIRTUALIZE(function()
    for i, v in getgc() do
        if typeof(v) == "function" and islclosure(v) then
            if (#getprotos(v) == 1) and table.find(getconstants(getproto(v, 1)), 4000001) then
                hookfunction(v, function() end)
            end
        end
    end
  end)()
  
  Hooks.__namecall = hookmetamethod(game, "__namecall", LPH_NO_VIRTUALIZE(function(self, ...)
    local Method = getnamecallmethod()
    local Args = {...}
  
    if not checkcaller() and (self == Handshake) and (Method == "fireServer") and (string.find(Args[1], "AC")) then
        if (#HandshakeInts == 0) then
            HandshakeInts = {table.unpack(Args[2], 2, 18)}
        else
            for i, v in HandshakeInts do
                Args[2][i + 1] = v
            end
        end
    end
  
    return Hooks.__namecall(self, ...)
  end))
  
  task.wait(1)

print('Done! Now Loading')


--> UI Initialization
local redzlib = loadstring(game:HttpGet("https://raw.githubusercontent.com/REDzHUB/RedzLibV4/refs/heads/main/Source.lua",true))()

local Window = redzlib:MakeWindow({
  Title = "Meta Hub : Evolution",
  SubTitle = "by : NG,fixed and updated by woops.cc",
  LoadText = "META HUB ON TOP!",
  Flags = "Meta Hub | Script.lua"
})


local Main = Window:MakeTab({Name = "Main", Icon = "13594361489"})
local Character = Window:MakeTab({Name = "Character", Icon = "10734920149"})
local Physics = Window:MakeTab({Name = "Physics", Icon =  "10709751939"})
local Quarterback = Window:MakeTab({Name = "Quarterback"})
local Miscellaneous = Window:MakeTab({Name = "Miscellaneous"})

--> Variables For Callbacks
getgenv().qbaimbotenabled = false
getgenv().showArcTracer = false
getgenv().predictBallArc = false
getgenv().autoAngle = false
getgenv().hideDeco = false
getgenv().customLead = 0
getgenv().customTargetHeight = 0
getgenv().AutoLeadDistance = false

getgenv().Football_Magnets = false
getgenv().autoCatch = false
getgenv().Pull_Vector = false

getgenv().Football_DistanceCatch = 0
getgenv().PullVectorDistance = 0
getgenv().autoCatch_Distance = 0
getgenv().autoSwat_Distance = 0




getgenv().Custom_WalkSpeed = false
getgenv().Custom_JumpPower = false

getgenv().Magnet_Mode = nil


--> Toggles and Sliders Setup

local predballarc = Quarterback:AddToggle({
    Name = "Predict Ball Arc",
    Default = false,
    Callback = function(Value)
        if getgenv().qbaimbotenabled then
            getgenv().predictBallArc = Value
        end
    end
})

local qbaim = Quarterback:AddToggle({
    Name = "Quarterback Aimbot",
    Default = false,
    Callback = function(Value)
        getgenv().qbaimbotenabled = Value
    end
})

local autoang = Quarterback:AddToggle({
    Name = "Auto Angle",
    Default = false,
    Callback = function(Value)
        if getgenv().qbaimbotenabled then
            getgenv().autoAngle = Value
        end
    end
})

local showarctracer = Quarterback:AddToggle({
    Name = "Show Arc Tracer",
    Default = false,
    Callback = function(Value)
        if getgenv().qbaimbotenabled then
            getgenv().showArcTracer = Value
        end
    end
})

local hideesp = Quarterback:AddToggle({
    Name = "Hide Highlights and Esp",
    Default = false,
    Callback = function(Value)
        if getgenv().qbaimbotenabled then
            getgenv().hideDeco = Value
        end
    end
})

local mags = Main:AddToggle({
    Name = "Football Magnets",
    Default = false,
    Callback = function(Value)
        getgenv().Football_Magnets = Value
    end
})

local mag_type = Main:AddDropdown({
    Name = "Magnet Type",
    Options = {"Legit", "Regular", "Blatant"},
    Default = "Regular",
    MultiSelect = false,
    Callback = function(Value)
        if getgenv().Football_Magnets then
        end
    end
})


local autodist = 10

local function autoCatch()
    while true do
        task.wait()
        local ball = workspace:FindFirstChild("Football")
        if ball and ball.ClassName == "BasePart" then
            local distance = (ball.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Magnitude
            if distance < autodist then
                game:GetService("ReplicatedStorage").Remotes.CharacterSoundEvent:fireServer("PlayerActions", "catch")
                task.wait(1.5)
            end
        end
    end
end

local autocatc = Main:AddToggle({
    Name = "Auto Catch",
    Default = false,
    Callback = function(Value)
        getgenv().autoCatch = Value
    end
})

local autoCatch_Distance = Main:AddSlider({
  Name = "Auto Catch Distance",
  MinValue = 1,
  MaxValue = 10,
  Default = 2,
  Increase = 0.1,
  Callback = function(Value)
    getgenv().autoCatch_Distance = Value
    end
    })                      

local AS_Enabled = false

local swat = Main:AddToggle({
    Name = "Auto Swat",
    Default = false,
    CurrentValue = false,
    Callback = function(v)
        AS_Enabled = v
        while wait() do
            if AS_Enabled == true then
                local HRP = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                for i,v in pairs(workspace:GetChildren()) do
                    if v.Name == "Football" and v:IsA("BasePart") and ((v.Position - HRP.Position).Magnitude <= 30) == true then  
                        keypress(0x52)
                        keyrelease(0x52)
                    end
                end
            end
        end
    end,
})

local magdistance = Main:AddSlider({
    Name = "Magnet Distance",
    Default = false,
    Callback = function(Value)
        if (getgenv().Football_Magnets) then
            getgenv().Football_DistanceCatch = Value
        end
    end,
})

local leaddistance = Quarterback:AddToggle({
    Name = "Auto Lead Distance",
    Default = false,
    Callback = function(Value)
        if getgenv().qbaimbotenabled then
            getgenv().AutoLeadDistance = Value
        end
    end,
})

local heightoffset = Quarterback:AddSlider({
    Name = "Custom Target Height",
    MinValue = 0,
    MaxValue = 10,
    Default = 2,
    Increase = 0.01,
    Callback = function(Value)
        if getgenv().qbaimbotenabled and getgenv().AutoLeadDistance then
            getgenv().customTargetHeight = Value
        end
    end,
})

local cleaddistance = Quarterback:AddSlider({
    Name = "Custom Lead Distance",
    MinValue = 0,
    MaxValue = 10,
    Default = 2,
    Increase = 0.01,
    Callback = function(Value)
        if getgenv().qbaimbotenabled then
            getgenv().customLead = Value
        end
    end,
})


local PullVector = Physics:CreateToggle({
    Name = "Pull Vector",
    Default = false,
    Callback = function(Value)
        getgenv().Pull_Vector = Value
    end
})


local pv = Physics:AddSlider({
    Name = "Pull Vector Distance",
  MinValue = 0,
  MaxValue = 60,
  Default = 0,
  Increase = 0.01,
    Callback = function(Value)
        if getgenv().Pull_Vector then
            getgenv().PullVectorDistance = Value
        end
    end,
})

local wstog = Character:CreateToggle({
    Name = "Custom WalkSpeed Toggle",
    Default = false,
    Callback = function(Value)
        getgenv().Custom_WalkSpeed = Value
    end,
})

local ws = Character:AddSlider({
    Name = "Walkspeed Distance",
  MinValue = 20,
  MaxValue = 29,
  Default = 20,
  Increase = 0.01,   
Callback = function(Value)
      task.spawn(function()
          while task.wait() do
              if (getgenv().Custom_WalkSpeed) == true then
                  game:GetService("Players").LocalPlayer.Character.Humanoid.WalkSpeed = Value
                end
            end
        end)
    end,
})

local jumpp = Character:AddToggle({
    Name = "JumpPower Toggle",
    Callback = function(Value)
        getgenv().Custom_JumpPower = Value
    end,
})

local jp = Character:CreateSlider({
    Name = "Jump Power",
  MinValue = 0,
  MaxValue = 80,
  Default = 50,
  Increase = 0.01,
    Callback = function(Value)
      task.spawn(function()
          while task.wait() do
              if (getgenv().Custom_JumpPower) == true then
                  game:GetService("Players").LocalPlayer.Character.Humanoid.JumpPower = Value
                end
            end
        end)
    end,
})

task.spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        for _, Value in pairs(workspace:GetChildren()) do
            if Value.Name == "Football" and Value:IsA("BasePart") then
                if (game:GetService("Players").LocalPlayer.Character:FindFirstChild("CatchRight").Position - Value.Position).Magnitude <= Football_DistanceCatch and getgenv().Football_Magnets then
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character:WaitForChild("CatchRight"), Value, 0)
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character:WaitForChild("CatchRight"), Value, 1)
                    task.wait()
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character:WaitForChild("CatchRight"), Value, 0)
                    firetouchinterest(game:GetService("Players").LocalPlayer.Character:WaitForChild("CatchRight"), Value, 1)
                end
            end
        end
    end)
end)

task.spawn(function()
    game:GetService("RunService").Heartbeat:Connect(function()
        for _, Value in pairs(workspace:GetChildren()) do
            if Value.Name == "Football" and Value:IsA("BasePart") then
                local Direction = (Value.Position - game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Position).Unit

                if game:GetService("Players").LocalPlayer:DistanceFromCharacter(Value.Position) <= getgenv().Football_Vector and getgenv().Pull_Vector then
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.Velocity = Direction * (getgenv().Football_Vector)
                end
            end
        end
    end)
end)

local antia = Miscellaneous:AddToggle({
    Name = "Anti Admin",
    Default = false,
    Callback = function(v)
        if v then
            local moderators = {
                "2618937233503944727",
                "209187780079648778",
                "265544447129812992",
                "677964655821324329",
                "469043698110562304",
                "792145568586792979",
                "490537796940070915",
                "678699048844132362",
                "837514415480897607",
                "417141199564963840",
                "580140563295109148",
                "231225289718497281",
                "719258236930228346",
                "345362950380322829",
                "513196564236468226",
                "241945212463742986",
                "153379470164623360",
              }

             for index, value in pairs(game:GetService("Players"):GetPlayers()) do
                if table.find(moderators, value.UserId) then
                    game:GetService("Players").LocalPlayer:kick("An Admin has joined! Make sure to keep this enabled for extra caution next time!")
                end
            end
        end
    end,
})

local Tracers = {}
local DistanceLabels = {}
local tracerEnabled = false

function AttachBall(Ball)
    local RootPart = Players.LocalPlayer.Character and Players.LocalPlayer..Character.PrimaryPart

    if RootPart and Ball then
        local Tracer = Drawing.new("Line")
        Tracer.Visible = false
        Tracer.Color = Color3.fromRGB(255, 0, 0)
        Tracer.Thickness = 1
        Tracer.Transparency = 1

        local TextLabel = Drawing.new("Text")
        TextLabel.Text = ""
        TextLabel.Transparency = 1
        TextLabel.Visible = false
        TextLabel.Color = Color3.fromRGB(255, 0, 0)
        TextLabel.Size = 25

        local con
        con = game:GetService("RunService").RenderStepped:Connect(function()
            if RootPart.Parent and Ball.Parent and tracerEnabled then
                local Vector, OnScreen = game.Workspace.CurrentCamera:WorldToViewportPoint(Ball.Position)
                local Vector2_, OnScreen2 = game.Workspace.CurrentCamera:WorldToViewportPoint(RootPart.Position)
                local Distance = (RootPart.Position - Ball.Position).Magnitude

                if OnScreen and OnScreen2 then
                    Tracer.From = Vector2.new(Vector2_.X, Vector2_.Y)
                    Tracer.To = Vector2.new(Vector.X, Vector.Y)
                    Tracer.Visible = true
                    TextLabel.Visible = true

                    TextLabel.Text = tostring(math.floor(Distance)) .. " studs away"
                    TextLabel.Position = Vector2.new(Vector.X, Vector.Y)

                    if Distance <= 50 then
                        TextLabel.Color = Color3.fromRGB(0, 255, 0)
                        Tracer.Color = Color3.fromRGB(0, 255, 0)
                    else
                        TextLabel.Color = Color3.fromRGB(255, 0, 0)
                        Tracer.Color = Color3.fromRGB(255, 0, 0)
                    end
                else
                    Tracer.Visible = false
                    TextLabel.Visible = false
                end
            else
                con:Disconnect()
                Tracer.Visible = false
                TextLabel.Visible = false
            end
        end)
        table.insert(Tracers, Tracer)
        table.insert(DistanceLabels, TextLabel)
    end
end


workspace.ChildAdded:Connect(function(child)
    if child.Name == "Football" then
        if tracerEnabled then
            AttachBall(child)
        end
    end
end)

local balltracer = Miscellaneous:AddToggle({
    Title = "Ball Tracer",
    Default = false,
    Callback = function(enabled)
        tracerEnabled = enabled

        if not enabled then
            for _, tracer in ipairs(Tracers) do
                    tracer:Remove()
                end

                for _, label in ipairs(DistanceLabels) do
                    label:Remove()
                end
                Tracers = {}
                DistanceLabels = {}
        else
            for _, child in ipairs(workspace:GetChildren()) do
                if child.Name == "Football" then
                    AttachBall(child)
                end
            end
        end
    end,
})

local changeweather = Miscellaneous:AddToggle({
    Name = "Change Weather To Rain",
    Default = false,
    Callback = function(value)
        IsSnow = value 

        if IsSnow  == true then
            for i,v in pairs(workspace.SkyWeather:GetChildren()) do
                if v.Name == "Snow" then
                    v.Enabled = true
                end
            end
        else
            for i,v in pairs(workspace.SkyWeather:GetChildren()) do
                if v.Name == "Snow" then
                    v.Enabled = false
                end
            end
        end
    end,
})

local boostfps = Miscellaneous:AddToggle({
    Title = "FPS Booster",
    Default = false,
    Callback = function(v)
        local decalsyeeted = v
        local g = game
        local w = g.Workspace
        local l = g.Lighting
        local t = w.Terrain
        t.WaterWaveSize = 0
        t.WaterWaveSpeed = 0
        t.WaterReflectance = 0
        t.WaterTransparency = 0
        l.GlobalShadows = false
        l.FogEnd = 9e9
        l.Brightness = 0
        settings().Rendering.QualityLevel = "Level01"
        for i, v in pairs(g:GetDescendants()) do
            if v:IsA("Part") or v:IsA("Union") or v:IsA("CornerWedgePart") or v:IsA("TrussPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
            elseif v:IsA("Decal") or v:IsA("Texture") and decalsyeeted then
                v.Transparency = 1
            elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
                v.Lifetime = NumberRange.new(0)
            elseif v:IsA("Explosion") then
                v.BlastPressure = 1
                v.BlastRadius = 1
            elseif v:IsA("Fire") or v:IsA("SpotLight") or v:IsA("Smoke") then
                v.Enabled = false
            elseif v:IsA("MeshPart") then
                v.Material = "Plastic"
                v.Reflectance = 0
                v.TextureID = 10385902758728957
            end
        end
        for i, e in pairs(l:GetChildren()) do
          if e:IsA("BlurEffect") or e:IsA("SunRaysEffect") or e:IsA("ColorCorrectionEffect") or e:IsA("BloomEffect") or e:IsA("DepthOfFieldEffect") then
                e.Enabled = false
            end
        end
    end,
})


local underground = Miscellaneous:AddToggle({
  Name = "Underground",
    Default = false,
    Callback = function(state)
        state = state
        local function toggleField(state)
            local model = game.Workspace.Models.Field.Grass
            local transparency = state and 1 or 0
            for _, part in pairs(model:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.CanCollide = not state
                    part.Transparency = transparency
                end
            end

            if state then
                local platform = Instance.new("Part")
                platform.Size = Vector3.new(500, 0.001, 500)
                platform.Position = Vector3.new(10.3562937, -2.51527438, 30.4708614)
                platform.Anchored = true
                platform.Parent = game.Workspace

                local colors = {
                    BrickColor.new("Light gray")
                }

                local currentIndex = 1

                while state do
                    platform.BrickColor = colors[currentIndex]
                    currentIndex = currentIndex % #colors + 1

                    wait(1)

                end
            end
        end

        toggleField(state)

        local player = game.Players.LocalPlayer
        local character = player.Character

        local function setPlayerTransparency(transparency)
            for _, part in ipairs(character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = transparency
                end
            end
        end

        setPlayerTransparency(0.6)
    end,
})

local LocalPlayer = game:GetService("Players").LocalPlayer
local dv = false
local dvdist = 15

local function dv()
    for _, Value in pairs(workspace:GetChildren()) do
        if Value.Name == "Football" and Value:IsA("BasePart") then
            local distance = (LocalPlayer.Character.HumanoidRootPart.Position - Value.Position).Magnitude

            if distance <= dvdist then
                local direction = (Value.Position - LocalPlayer.Character.HumanoidRootPart.Position).Unit
                LocalPlayer.Character.HumanoidRootPart.Velocity = direction * 15
            end
        end
    end
end

LocalPlayer:GetMouse().KeyDown:Connect(function(Key)
    if Key == string.lower("e") then
        if dv then
            dv()
        end
    end
end)


local divevec = Physics:AddToggle({
    Name = "Dive Vector",
    Default = false,
    Callback = function(v)
        dv = v
    end,
})

local divevecdistance = Physics:AddSlider({
    Name = "Dive Vector Distance",
    MinValue = 0,
    MaxValue = 15,
    Default = 3,
    Increase = 0.01,
    Callback = function(v)
        dvdist = v
    end,
})



--> QB Aimbot

-- Services
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

-- Variables
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()
local Gui = game:GetObjects("rbxassetid://14769142268")[1]
local locked = false
local target = nil

local Part = Instance.new("Part")
Part.Parent = workspace
Part.Anchored = true
Part.Size = Vector3.new(3, 1, 3)
Part.CanCollide = false

local Beam = Instance.new("Beam")
Beam.Parent = workspace.Terrain

local Highlight = Instance.new("Highlight")
Highlight.FillColor = Color3.fromRGB(255, 11, 202)
Highlight.OutlineColor = Color3.fromRGB(255, 255, 255)

local Attachment0, Attachment1 = Instance.new("Attachment"), Instance.new("Attachment")
Attachment0.Parent = workspace.Terrain
Attachment1.Parent = workspace.Terrain

Beam.Width0 = 0.5
Beam.Width1 = 0.5
Beam.Transparency = NumberSequence.new(0)
Beam.Color = ColorSequence.new(Color3.fromRGB(255, 11, 202))
Beam.Attachment0 = Attachment0
Beam.Attachment1 = Attachment1
Beam.Segments = 3000

local data = {
    Angle = 40,
    Power = 0,
    Direction = Vector3.new(0, 0, 0)
}

local passTypeLeads = {
    ["Dime"] = 2,
    ["Jump"] = 6,
    ["Mag"] = 12,
}

local passTypeSwitch = {
    ["Dime"] = "Jump",
    ["Jump"] = "Mag",
    ["Mag"] = "Dime"
}

local passType = "Dime"

--[[do
    local WhitelistedMousePart = Instance.new("Part")
    WhitelistedMousePart.Size = Vector3.new(2048, 1, 2048)
    WhitelistedMousePart.Anchored = true
    WhitelistedMousePart.Transparency = 1
    WhitelistedMousePart.Position = Player.Character.HumanoidRootPart.Position - Vector3.new(0, 4, 0)
    WhitelistedMousePart.CanCollide = false
    WhitelistedMousePart.Parent = workspace

    local MouseRaycastParams = RaycastParams.new()
    MouseRaycastParams.FilterType = Enum.RaycastFilterType.Include
    MouseRaycastParams.FilterDescendantsInstances = { WhitelistedMousePart }
    Mouse:SetRaycastParams(MouseRaycastParams)
end--]]

-- Helper Functions

local function InverseCosine(degrees)
    return math.cos(math.rad(degrees))
end

local function CalculateTimeToPeak(from, to, height)
    local g = Vector3.new(0, -28, 0)
    local conversionFactor = 4
    local xMeters = height * conversionFactor

    local a = 0.5 * g.Y
    local b = to.Y - from.Y
    local c = xMeters - from.Y

    local discriminant = b * b - 4 * a * c
    if discriminant < 0 then
        return nil
    end

    local t1 = (-b + math.sqrt(discriminant)) / (2 * a)
    local t2 = (-b - math.sqrt(discriminant)) / (2 * a)

    local t = math.max(t1, t2)
    return t
end

local function CalculateLanding(power, direction)
    local origin = Player.Character.Head.Position + direction * 5
    local velocity = power * direction
    local t = (velocity.Y / 28) * 2
    return origin + Vector3.new(velocity.X * t, 0, velocity.Z * t), t
end

local function FindPossibleCatchers(power, direction)
    local velocity = power * direction
    local landing, airtime = CalculateLanding(power, direction)
    local catchers = {}

    for _, player in pairs(Players:GetPlayers()) do
        if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
            local distance = (player.Character.HumanoidRootPart.Position - landing).Magnitude

            if distance < (20 * airtime) + 10 then
                catchers[#catchers + 1] = player
            end
        end
    end

    return catchers
end

local function CalculatePeakHeight(from, to, angle)
    local unitY = 1 - InverseCosine(angle)
    local distance = (from - to).Magnitude
    return unitY * distance
end

local function CalculateVelocity(from, to, time)
    local g = Vector3.new(0, -28, 0)
    local v0 = (to - from - 0.5 * g * time * time) / time
    local dir = ((from + v0) - from).Unit
    local power = v0.Y / dir.Y
    return v0, dir, math.clamp(math.round(power), 0, 95)
end

local function FindTarget()
    local nearestPart = nil
    local nearestDistance = math.huge

    local searchParts = { workspace }
    if workspace:FindFirstChild("npcwr") then
        table.insert(searchParts, workspace.npcwr.a)
        table.insert(searchParts, workspace.npcwr.b)
    end

    for _, part in pairs(searchParts) do
        for _, child in pairs(part:GetChildren()) do
            if child:FindFirstChildWhichIsA("Humanoid") and child:FindFirstChild("HumanoidRootPart") then
                local player = Players:GetPlayerFromCharacter(child)

                if player == Player then
                    continue
                end

                if not player and game.PlaceId ~= 8206123457 then
                    continue
                end

                if not Player.Neutral then
                    if player.Team ~= Player.Team then
                        continue
                    end
                end

                local distance = (child.HumanoidRootPart.Position - Mouse.Hit.Position).Magnitude

                if distance < nearestDistance then
                    nearestDistance = distance
                    nearestPart = child
                end
            end
        end
    end

    return nearestPart
end

local function GetMoveDirection(target)
    if Players:GetPlayerFromCharacter(target) then
        return target.Humanoid.MoveDirection
    else
        return (target.Humanoid.WalkToPoint - target.Head.Position).Unit
    end
end

local __namecall;
__namecall = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    local args = { ... }

    if args[1] == "Clicked" and getgenv().qbaimbotenabled then
        local newArgs = { "Clicked", Player.Character.Head.Position, Player.Character.Head.Position + data.Direction * 10000, (game.PlaceId == 8206123457 and data.Power) or 95, math.round(data.Power) }
        return __namecall(self, unpack(newArgs))
    end
    return __namecall(self, ...)
end)

UserInputService.InputBegan:Connect(function(input, gameProcessedEvent)
    if not gameProcessedEvent and Player.PlayerGui:FindFirstChild("BallGui") then
        if input.KeyCode == Enum.KeyCode.R then
            while UserInputService:IsKeyDown(Enum.KeyCode.R) do
                data.Angle = data.Angle + 5
                data.Angle = math.clamp(data.Angle, 5, 90)
                wait(1/6)
            end
        elseif input.KeyCode == Enum.KeyCode.F then
            while UserInputService:IsKeyDown(Enum.KeyCode.F) do
                data.Angle = data.Angle - 5
                data.Angle = math.clamp(data.Angle, 5, 90)
                wait(1/6)
            end
        elseif input.KeyCode == Enum.KeyCode.Q then
            locked = not locked
        elseif input.KeyCode == Enum.KeyCode.Z then
            passType = passTypeSwitch[passType]
        end
    end
end)

local function BeamProjectile(g, v0, x0, t1)
    local c = 0.5 * 0.5 * 0.5
    local p3 = 0.5 * g * t1 * t1 + v0 * t1 + x0
    local p2 = p3 - (g * t1 * t1 + v0 * t1) / 3
    local p1 = (c * g * t1 * t1 + 0.5 * v0 * t1 + x0 - c * (x0 + p3)) / (3 * c) - p2

    local curve0 = (p1 - x0).Magnitude
    local curve1 = (p2 - p3).Magnitude

    local b = (x0 - p3).Unit
    local r1 = (p1 - x0).Unit
    local u1 = r1:Cross(b).Unit
    local r2 = (p2 - p3).Unit
    local u2 = r2:Cross(b).Unit
    b = u1:Cross(r1).Unit

    local cf1 = CFrame.new(
        x0.x, x0.y, x0.z,
        r1.x, u1.x, b.x,
        r1.y, u1.y, b.y,
        r1.z, u1.z, b.z
    )

    local cf2 = CFrame.new(
        p3.x, p3.y, p3.z,
        r2.x, u2.x, b.x,
        r2.y, u2.y, b.y,
        r2.z, u2.z, b.z
    )

    return curve0, -curve1, cf1, cf2
end

Gui.Enabled = false

if syn and syn.protect_gui then
    syn.protect_gui(Gui)
end

Gui.Parent = (gethui and gethui()) or game:GetService("CoreGui"):FindFirstChild("RobloxGui")

task.spawn(function()
    while task.wait() do
        if not locked then
            target = FindTarget()
        end

        if target and getgenv().qbaimbotenabled and Player.PlayerGui:FindFirstChild("BallGui") and Player.Character:FindFirstChild("Head") and target:FindFirstChild("HumanoidRootPart") then
            Gui.Enabled = not getgenv().hideDeco
            Beam.Enabled = getgenv().showArcTracer

            local moveDirection = GetMoveDirection(target)
            local angleAddition = (moveDirection.Magnitude > 0 and 5) or 0
            local leadDistance = passTypeLeads[passType] + (5)
            local estimatedPosition = target.Head.Position + (moveDirection * leadDistance) + Vector3.new(0, getgenv().customTargetHeight or 0, 0)

            local forwardOffset = Vector3.new(0, 0, 10)
            estimatedPosition = estimatedPosition + (moveDirection * forwardOffset)

            local t = CalculateTimeToPeak(Player.Character.Head.Position, estimatedPosition, CalculatePeakHeight(Player.Character.Head.Position, estimatedPosition, data.Angle + angleAddition)) or 0.5

            local vel, direction, power = CalculateVelocity(Player.Character.Head.Position, estimatedPosition, t, moveDirection)

            local degrees = nil

            if getgenv().autoAngle then
                local g = workspace.Gravity
                local R = estimatedPosition.Magnitude
                local V = math.round(power)
                local a0 = 0.5 * math.atan(g * R / (V^2)) 
                degrees = math.floor(math.deg(a0))
            end

            local catchers = FindPossibleCatchers(power, direction)
            local landing, airtime = CalculateLanding(power, direction)
            local c0, c1, cf1, cf2 = BeamProjectile(Vector3.new(0, -28, 0), power * direction, Player.Character.Head.Position + (direction * 5), 7)
            local isInterceptable = false

            for _, catcher in pairs(catchers) do
                local team = catcher.Team

                if team ~= Player.Team then
                    isInterceptable = true
                    break
                end
            end

            Part.Position = landing
            Part.Transparency = (getgenv().predictBallArc and 0) or 1
            Part.Color = Color3.fromRGB(255, 11, 202)

            Beam.CurveSize0 = c0
            Beam.CurveSize1 = c1

            Attachment0.CFrame = Attachment0.Parent.CFrame:Inverse() * cf1
            Attachment1.CFrame = Attachment1.Parent.CFrame:Inverse() * cf2

            data.Direction = direction
            data.Power = power

            Highlight.Parent = target
            Highlight.Enabled = not getgenv().hideDeco

            if not getgenv().autoAngle then
                Gui.Frame.pwr.value.Text = power
                Gui.Frame.player.value.Text = target.Name
                Gui.Frame.angle.value.Text = data.Angle
                Gui.Frame.mode.value.Text = passType
            else
                Gui.Frame.pwr.value.Text = power
                Gui.Frame.player.value.Text = target.Name
                Gui.Frame.angle.value.Text = degrees
                Gui.Frame.mode.value.Text = passType
            end
        else
            Gui.Enabled = false
            Highlight.Parent = nil
        end
    end
end)

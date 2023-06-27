-- Damage indicators script for Prison Life
-- Made by elghxst

local ACTIVATE_COMMAND = "-di"
local HIT_PERCENT_COMMAND = "-h"
local RESET_HIT_PERCENT_COMMAND = "-reset"
-- you can use this command with /e

local active = false
local plr = game:GetService("Players")
local lp = plr.LocalPlayer

local hitSound = 1347140027
local volume = 1
local Hits = 0
local Shoots = 0
local S = {
    UIS = game:GetService("UserInputService"),
    TS = game:GetService("TweenService"),
    SG = game:GetService("StarterGui"),
    L = game:GetService("Lighting"),
    R = game:GetService("RunService"),
    RE = game:GetService("ReplicatedStorage"),
    P = game:GetService("Players")
}
local function notify(text, color)
    S.SG:SetCore("ChatMakeSystemMessage", {Text = text; Color = color; Font = Enum.Font.SourceSansBold; FontSize = Enum.FontSize.Size42})
end

lp.Chatted:connect(function(msg)
    if msg == ACTIVATE_COMMAND or msg == "/e "..ACTIVATE_COMMAND then
        active = not active
        notify("Damage Indicators: "..tostring(active), Color3.fromRGB(85, 255, 127))
    end
    if msg == HIT_PERCENT_COMMAND or msg == "/e "..HIT_PERCENT_COMMAND then
        notify("Shoots: "..Shoots, Color3.fromRGB(255,0,255))
        notify("Hits: "..Hits, Color3.fromRGB(255,0,255))
        notify("Hit Percent: "..((Hits/Shoots)*100).."%", Color3.fromRGB(255,0,255))
        notify("Hit Percent: "..math.floor((Hits/Shoots)*100).."%", Color3.fromRGB(85, 255, 127))
    end
    if msg == RESET_HIT_PERCENT_COMMAND or msg == "/e "..RESET_HIT_PERCENT_COMMAND then
        Shoots = 0
        Hits = 0
        notify("States have been reset", Color3.fromRGB(255,0,255))
    end
end)

local function checkHits(args)
    local DamageHits = {}
    for _,arg in pairs(args[1]) do
        Shoots = Shoots+1
        if arg["Hit"] ~= nil then
            if (S.P:GetPlayerFromCharacter(arg["Hit"].Parent) and S.P:GetPlayerFromCharacter(arg["Hit"].Parent).Team.Name ~= lp.Team.Name) or (arg["Hit"].Parent.Parent and (S.P:GetPlayerFromCharacter(arg["Hit"].Parent.Parent)) and S.P:GetPlayerFromCharacter(arg["Hit"].Parent.Parent).Team.Name ~= lp.Team.Name) then
                table.insert(DamageHits, arg)
                Hits = Hits+1
            end
        end
       
    end
    return DamageHits
end
local sg = Instance.new("ScreenGui")
sg.Parent = lp.PlayerGui
local hitmarkerframe = Instance.new("Frame")
local hitmarker = Instance.new("ImageLabel")
local center = Instance.new("UIListLayout")
local dmgframe = Instance.new("Frame")
local dmgtext = Instance.new("TextLabel")

hitmarkerframe.Name = "hitmarkerframe"
hitmarkerframe.Parent = nil
hitmarkerframe.AnchorPoint = Vector2.new(0.5, 0.5)
hitmarkerframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitmarkerframe.BackgroundTransparency = 1.000
hitmarkerframe.Position = UDim2.new(0.266034991, 0, 0.294398099, 0)
hitmarkerframe.Size = UDim2.new(0, 45, 0, 45)

hitmarker.Name = "hitmarker"
hitmarker.Parent = hitmarkerframe
hitmarker.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
hitmarker.BackgroundTransparency = 1.000
hitmarker.Position = UDim2.new(1.3765837, 0, 1.00706458, 0)
hitmarker.Size = UDim2.new(0, 22, 0, 22)
hitmarker.Image = "http://www.roblox.com/asset/?id=8851722233"

center.Name = "center"
center.Parent = hitmarkerframe
center.HorizontalAlignment = Enum.HorizontalAlignment.Center
center.SortOrder = Enum.SortOrder.LayoutOrder
center.VerticalAlignment = Enum.VerticalAlignment.Center

dmgframe.Name = "dmgframe"
dmgframe.Parent = nil
dmgframe.AnchorPoint = Vector2.new(0.5, 0.5)
dmgframe.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dmgframe.BackgroundTransparency = 1.000
dmgframe.Position = UDim2.new(0,0,0,0)
dmgframe.Size = UDim2.new(0, 282, 0, 282)

dmgtext.Name = "dmgtext"
dmgtext.Parent = dmgframe
dmgtext.AnchorPoint = Vector2.new(0.5, 0.5)
dmgtext.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
dmgtext.BackgroundTransparency = 1.000
dmgtext.BorderColor3 = Color3.fromRGB(27, 42, 53)
dmgtext.Position = UDim2.new(0.497653157, 0, 0.499382913, 0)
dmgtext.Size = UDim2.new(0, 47, 0, 23)
dmgtext.Visible = false
dmgtext.Font = Enum.Font.GothamBlack
dmgtext.Text = "-10"
dmgtext.TextColor3 = Color3.fromRGB(255, 255, 255)
dmgtext.TextScaled = true
dmgtext.TextSize = 63.000
dmgtext.TextStrokeTransparency = 1.000
dmgtext.TextTransparency = 1.000
dmgtext.TextWrapped = true

local Mouse = lp:GetMouse()
local function damageindicator(args, tool)
    if args and args[1] and active == true then
        local hit = false
        for i,v in pairs(args) do
            task.spawn(function ()
                local gs = require(tool.GunStates)
                local damage = gs.Damage
                hit = true
                local head = false
                if v["Hit"] and v["Hit"].Name == "Head" then
                    head = true
                end
                local gui = Instance.new("BillboardGui", v["Hit"])
                local uilist = Instance.new("UIListLayout", gui)
                uilist.HorizontalAlignment = Enum.HorizontalAlignment.Center
                uilist.SortOrder = Enum.SortOrder.LayoutOrder
                uilist.VerticalAlignment = Enum.VerticalAlignment.Center
                gui.Size = UDim2.new(0,300,0,300)
                gui.AlwaysOnTop = true
                gui.ClipsDescendants = false
                local init = UDim2.new(0.498, 0,0.499, 0)
                local finalsize = UDim2.new(0, 47, 0, 23)
                local newdmg = dmgframe:Clone()
                newdmg.Parent = gui
                local Positions = {
                    UDim2.new(0.767, 0, 0.389, 0),
                    UDim2.new(0.65, 0, 0.755, 0),
                    UDim2.new(0.201, 0, 0.356, 0),
                    UDim2.new(0.272, 0, 0.753, 0),
                    UDim2.new(0.743, 0, 0.173, 0),
                    UDim2.new(0.165, 0, 0.496, 0),
                    UDim2.new(0.502, 0, 0.205, 0)
                }
                local posi = Positions[math.random(1, #Positions)]
                
                local clone = newdmg:WaitForChild("dmgtext")
                if head == true then
                    clone.TextColor3 = Color3.fromRGB(255,0,0)
                    damage = damage * 1.5
                end
                clone.Text = "-"..damage
               
                clone.Position = init
                clone.Visible = true
                
                coroutine.wrap(function()
                    wait(0.15)
                    clone.TextTransparency = 0
                    clone.TextStrokeTransparency = 0.5
                end)()
                
                clone:TweenPosition(
                    posi,
                    Enum.EasingDirection.InOut,
                    Enum.EasingStyle.Quad,
                    0.45,
                    true
                )
                wait(0.55)
                clone:TweenSize(
                    UDim2.new(0, 0, 0, 0),
                    Enum.EasingDirection.InOut,
                    Enum.EasingStyle.Linear,
                    0.2,
                    true
                )
                game:GetService("Debris"):AddItem(clone, 0.3)
            end)
        end
       
        if hit == true then
            task.spawn(function()
                local sound = Instance.new("Sound")
                sound.Parent = game:GetService("SoundService")
                sound.SoundId = "rbxassetid://"..hitSound
                sound.Volume = volume or 1
                sound:Play()
                sound.Ended:Wait()
                sound:Destroy()
            end)
            
            task.spawn(function()
                local doing = true
                local Clone = hitmarkerframe:Clone()
                local NewHit = Clone:WaitForChild("hitmarker")
                    
                Clone.Position = UDim2.new(0,Mouse.X,0,Mouse.Y)
                Clone.Parent = sg
                NewHit.Size = UDim2.new(0, 22, 0, 22) 
                Clone.Visible = true
                coroutine.wrap(function()
                    repeat task.wait()
                        Clone.Position = UDim2.new(0,Mouse.X,0,Mouse.Y)
                    until doing == false
                end)()
                
                S.TS:Create(NewHit, TweenInfo.new(0.1), {ImageTransparency = 0}):Play()
                NewHit:TweenSize(
                    UDim2.new(0, 28, 0, 28),
                    Enum.EasingDirection.InOut,
                    Enum.EasingStyle.Quad,
                    0.05,
                    true
                )
                wait(0.07)
                S.TS:Create(NewHit, TweenInfo.new(0.1), {ImageTransparency = 1}):Play()
                game:GetService("Debris"):AddItem(Clone, 0.4)
                wait(0.3)
                doing = false
            end)
        end
    end
    
end
local namecall
namecall = hookmetamethod(game,'__namecall',function(self, ...)
    local method = getnamecallmethod()
    local args = {...}
    if method == 'FireServer' and self == S.RE.ShootEvent then
        coroutine.wrap(function ()
            pcall(function ()
                local damageHits = checkHits(args)
                damageindicator(damageHits, args[2])
            end)
        end)()
        
    end

    return namecall(self, ...)
end)

notify("damage indicators loaded made by elghxst", Color3.fromRGB(255,255,0))
notify("use: "..ACTIVATE_COMMAND.." to enable Damage Indicators.", Color3.fromRGB(85, 255, 127))
notify("use: "..HIT_PERCENT_COMMAND.." to see your hit percent.", Color3.fromRGB(85, 255, 127))

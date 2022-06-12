local Library = {}
local CoreGui = game:GetService("CoreGui")
local Player = game:GetService("Players").LocalPlayer
local Mouse = Player:GetMouse()
local TextService = game:GetService("TextService")
local RunService = game:GetService("RunService")
local input = game:GetService("UserInputService")
local CoreGuiService = game:GetService("CoreGui")
local Debris = game:GetService("Debris")
local TweenService = game:GetService("TweenService")
local MessagingService = game:GetService("MessagingService")
local ContentService = game:GetService("ContentProvider")
local Http = game:GetService("HttpService")

-- [[ Object and Type are required ]]
function CheckType(object, type)
    if typeof(object) ~= type then
        error(type .. " expected (got: " .. typeof(object) .. ") 3BD")
    end
end
-- [[ Object and Type are required ]]
function CheckIfNill(object, type)
    if object == nil then
        error(type .. " expected (got: nil) 3BD")
    end
end
-- [[ Object and Color are required ]]
function AddShadow(object, color)
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = tostring(math.floor(math.random(100000, 900000)))
    Shadow.BackgroundTransparency = 1
    Shadow.Image = "https://www.roblox.com/asset/?id=5554236805"
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(23, 23, 277, 277)
    Shadow.Size = UDim2.fromScale(1, 1) + UDim2.fromOffset(30, 30)
    Shadow.Position = UDim2.fromOffset(-15, -15)
    Shadow.ImageColor3 = color
    Shadow.Parent = object
    Shadow.ZIndex = 9e6
    return Shadow
end
-- [[ Animation Stuff ]]
local function GetXY(GuiObject)
    local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
    local Px, Py =
        math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max),
        math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
    return Px / Max, Py / May
end
local function CircleAnim(GuiObject, EndColour, StartColour)
    local PX, PY = GetXY(GuiObject)
    local Circle = Instance.new("ImageLabel")
    Circle.BackgroundTransparency = 1
    Circle.Image = "http://www.roblox.com/asset/?id=5554831670"
    Circle.Size = UDim2.fromScale(0, 0)
    Circle.Position = UDim2.fromScale(PX, PY)
    Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
    Circle.ZIndex = 200
    Circle.Parent = GuiObject
    local Size = GuiObject.AbsoluteSize.X
    game:GetService("TweenService"):Create(
        Circle,
        TweenInfo.new(1),
        {
            Position = UDim2.fromScale(PX, PY) - UDim2.fromOffset(Size / 2, Size / 2),
            ImageTransparency = 1,
            ImageColor3 = EndColour,
            Size = UDim2.fromOffset(Size, Size)
        }
    ):Play()
    spawn(
        function()
            wait(2)
            Circle:Destroy()
        end
    )
end
function Do_Get_Connections()
    for i, v in ipairs(getconnections(game:GetService('UserInputService').InputBegan)) do
        local f = v.Function
        if (f) then
            local scr = getfenv(f).script
            if (not scr:IsDescendantOf(game.CoreGui)) then 
                v:Disable() 
            end
        end
    end
end
udim2ToTable = function(udim2)
    return {udim2.X.Scale, udim2.X.Offset, udim2.Y.Scale, udim2.Y.Offset}
end

udim2FromTable = function(udim2)
    return UDim2.new(udim2[1], udim2[2], udim2[3], udim2[4])
end
function Check()
    if writefile or appendfile or readfile or isfile or makefolder or delfolder or isfolder then
        return true
    else
        return false
    end
end
_G.Settings = {
    Position = nil
}
if Check() then
    makefolder("./Rect/")
else
    print("Not supported")
end
local fname = "./Rect/settings.dat"
function load()
    if (Check() and isfile(fname)) then
        _G.Settings = Http:JSONDecode(readfile(fname))
    end
end
function save()
    local json
    if Check() then
        json = Http:JSONEncode(_G.Settings)
        writefile(fname, json)
    else
        print("Not supported")
    end
end
-- [[ Enables Dragging ]]
function DraggingEnabled(frame, parent)
    parent = parent or frame
    local dragging = false
    local dragInput, mousePos, framePos

    frame.InputBegan:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                dragging = true
                mousePos = input.Position
                framePos = parent.Position

                input.Changed:Connect(
                    function()
                        if input.UserInputState == Enum.UserInputState.End then
                            dragging = false
                        end
                    end
                )
            end
        end
    )

    frame.InputChanged:Connect(
        function(input)
            if input.UserInputType == Enum.UserInputType.MouseMovement then
                dragInput = input
                
            end
        end
    )

    input.InputChanged:Connect(
        function(input)
            if input == dragInput and dragging then
                local delta = input.Position - mousePos
                parent.Position =
                    UDim2.new(
                    framePos.X.Scale,
                    framePos.X.Offset + delta.X,
                    framePos.Y.Scale,
                    framePos.Y.Offset + delta.Y
                )
                _G.Settings.Position = udim2ToTable(parent.Position)
                save()
            end
        end
    )
end

load()
save()





for i,v in pairs(CoreGui:GetChildren()) do if v.Name == "Main" and v:IsA("ScreenGui") then v:Destroy() end end 
Do_Get_Connections()
function Library.Start(settings)
    CheckIfNill(settings,"table")
    CheckType(settings,"table")
    local options = settings.Options
    CheckIfNill(options,"table")
    CheckType(options,"table")
    local title = options.Title 
    CheckIfNill(title,"string")
    CheckType(title,"string")
    local savepos = options.SavePosition or false  
    CheckType(savepos,"boolean")
            local Main = Instance.new("ScreenGui")
            local Motherframe = Instance.new("Frame")
            local Header = Instance.new("Frame")
            local Title = Instance.new("TextLabel")
            local TabContainer = Instance.new("ScrollingFrame")
            local UIListLayout = Instance.new("UIListLayout")
            local UIPadding_2 = Instance.new("UIPadding")
            local Pages = Instance.new("Folder")
            local Shadow = Instance.new("ImageLabel")
            local Exit = Instance.new("TextButton")
            local UICorner_3 = Instance.new("UICorner")
            local Border = Instance.new("Frame")
            local s = Instance.new("UIStroke")
            local c = Instance.new("UICorner")
            local c2 = Instance.new("UICorner")
            if _G.Settings.Position == nil then
                local pos = UDim2.new(.5, 0, 0.5, 0)
                _G.Settings.Position = udim2ToTable(pos)
                save()
            end
        
            --Properties:

            Main.Name = "Main"
            Main.Parent = CoreGui
            Main.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

            Motherframe.Name = "Motherframe"
            Motherframe.Parent = Main
            Motherframe.AnchorPoint = Vector2.new(0.5, 0.5)
            Motherframe.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
            Motherframe.BorderSizePixel = 0
            Motherframe.Size = UDim2.new(0, 565, 0, 365)
            if savepos then 
                Motherframe.Position = udim2FromTable(_G.Settings.Position)
            else
                Motherframe.Position = UDim2.new(0.5,0,.5,0)
            end
            Header.Name = "Header"
            Header.Parent = Motherframe
            Header.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
            Header.BorderSizePixel = 0
            Header.Size = UDim2.new(0, 565, 0, 29)
            c.Parent = Motherframe
            c.CornerRadius = UDim.new(0,3)
            c2.Parent = Header
            c2.CornerRadius = UDim.new(0,3)
            DraggingEnabled(Header,Motherframe)

            Title.Name = "Title"
            Title.Parent = Header
            Title.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Title.BackgroundTransparency = 1.000
            Title.Position = UDim2.new(0.017699115, 0, -0.00273974193, 0)
            Title.Size = UDim2.new(0, 171, 0, 29)
            Title.Font = Enum.Font.GothamMedium
            Title.TextColor3 = Color3.fromRGB(217, 217, 217)
            Title.TextSize = 14.000
            Title.TextXAlignment = Enum.TextXAlignment.Left
            Title.Text = title

            TabContainer.Name = "TabContainer"
            TabContainer.Parent = Motherframe
            TabContainer.Active = true
            TabContainer.BackgroundColor3 = Color3.fromRGB(43, 43, 43)
            TabContainer.BorderSizePixel = 0
            TabContainer.Position = UDim2.new(0, 0, 0.0767123252, 0)
            TabContainer.Size = UDim2.new(0, 565, 0, 29)
            TabContainer.CanvasSize = UDim2.new(0, 0, 0, 0)

            UIListLayout.Parent = TabContainer
            UIListLayout.FillDirection = Enum.FillDirection.Horizontal
            UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayout.Padding = UDim.new(0, 5)

            UIPadding_2.Parent = TabContainer
            UIPadding_2.PaddingLeft = UDim.new(0, 5)
            UIPadding_2.PaddingTop = UDim.new(0, 6)

            Pages.Name = "Pages"
            Pages.Parent = Motherframe

            Shadow.Name = "Shadow"
            Shadow.Parent = Motherframe
            Shadow.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
            Shadow.BackgroundTransparency = 1.000
            Shadow.BorderColor3 = Color3.fromRGB(27, 42, 53)
            Shadow.Position = UDim2.new(0, -15, 0, -15)
            Shadow.Size = UDim2.new(1, 30, 1, 30)
            Shadow.Image = "http://www.roblox.com/asset/?id=5554236805"
            Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
            Shadow.ScaleType = Enum.ScaleType.Slice
            Shadow.SliceCenter = Rect.new(23, 23, 277, 277)

            Exit.Name = "Exit"
            Exit.Parent = Motherframe
            Exit.BackgroundColor3 = Color3.fromRGB(84, 84, 84)
            Exit.Position = UDim2.new(0.0194690265, 0, 0.906849325, 0)
            Exit.Size = UDim2.new(0, 81, 0, 23)
            Exit.AutoButtonColor = false
            Exit.Font = Enum.Font.GothamBold
            Exit.Text = "Exit"
            Exit.TextColor3 = Color3.fromRGB(217, 217, 217)
            Exit.TextSize = 13.000

            Exit.MouseButton1Click:Connect(function()
                Main:Destroy()
            end)
            
            UICorner_3.CornerRadius = UDim.new(0, 4)
            UICorner_3.Parent = Exit

            Border.Name = "Border"
            Border.Parent = Motherframe
            Border.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
            Border.BorderColor3 = Color3.fromRGB(100, 100, 100)
            Border.BorderSizePixel = 0
            Border.Position = UDim2.new(0, 0, 0.158999994, 0)
            Border.Size = UDim2.new(0, 565, 0, 0)

            s.Parent = Border
            s.Thickness = .5
            s.Color = Color3.fromRGB(100,100,100)

            local Tabs = {}
            function Tabs:Tab(settings)
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local options = settings.Options
                CheckIfNill(options,"table")
                CheckType(options,"table")
                local title = options.Title 
                CheckIfNill(title,"string")
                CheckType(title,"string")

                
                local TabOn = Instance.new("TextButton")
                local UICorner = Instance.new("UICorner")
                local UIPadding = Instance.new("UIPadding")
                local Page = Instance.new("ScrollingFrame")
                local pad = Instance.new("UIPadding")
                local list = Instance.new("UIListLayout")
            
            TabOn.Name = "TabOn"
            TabOn.Parent = TabContainer
            TabOn.BackgroundColor3 = Color3.fromRGB(84, 84, 84)
            TabOn.Position = UDim2.new(0, 0, -0.13636364, 0)
            TabOn.Size = UDim2.new(0, 64, 0, 32)
            TabOn.AutoButtonColor = false
            TabOn.Font = Enum.Font.GothamBold
            TabOn.Text = title
            TabOn.TextColor3 = Color3.fromRGB(217, 217, 217)
            TabOn.TextSize = 12.000
            TabOn.AutomaticSize =Enum.AutomaticSize.X
            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = TabOn

            UIPadding.Parent = TabOn
            UIPadding.PaddingBottom = UDim.new(0, 8)

            Page.Name = "Page"
            Page.Parent = Pages
            Page.Active = true
            Page.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
            Page.BorderSizePixel = 0
            Page.Position = UDim2.new(0.0194690265, 0, 0.180821911, 0)
            Page.Size = UDim2.new(0, 543, 0, 258)
            Page.CanvasSize = UDim2.new(0, 0, 0, 0)
            Page.ScrollBarThickness = 1
            Page.ScrollBarImageColor3 = Color3.fromRGB(100,100,100)
            pad.Parent  = Page
            pad.PaddingTop = UDim.new(0,8)

            list.Parent = Page
            list.HorizontalAlignment = Enum.HorizontalAlignment.Center
            list.Padding = UDim.new(0,6)
            list.SortOrder = Enum.SortOrder.LayoutOrder
            
            task.spawn(
                function()
                    while task.wait() do
                        Page.CanvasSize = UDim2.new(0, 0, 0, list.AbsoluteContentSize.Y + 15)
                    end
                end
            )
    
            PageIndex = 0
            TabIndex = 0
    
            for i, v in pairs(Pages:GetChildren()) do
                PageIndex = PageIndex + 1
                v.Name = "Page" .. tostring(PageIndex)
                if v.Name ~= "Page1" then
                    v.Visible = false
                end
            end
            for i, v in pairs(TabContainer:GetChildren()) do
                if v:IsA("TextButton") then
                    TabIndex = TabIndex + 1
                    v.Name = "Tab" .. tostring(TabIndex)
                    if v.Name ~= "Tab1" then
                        v.BackgroundColor3 = Color3.fromRGB(56, 56, 56)
                    end
                end
            end
    
            TabOn.MouseButton1Click:Connect(
                function()
                    for i, v in pairs(TabContainer:GetChildren()) do
                        if v:IsA("TextButton") then
                            TweenService:Create(v, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(56, 56, 56)}):Play()
                        end
                    end
                    TweenService:Create(TabOn, TweenInfo.new(.15), {BackgroundColor3 = Color3.fromRGB(84, 84, 84)}):Play()    
                    for i, v in pairs(Pages:GetChildren()) do
                        v.Visible = false
                    end
                    Page.Visible = true
                end
            )
            local Elements = {}
            function Elements:Button(settings)
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local options = settings.Options
                CheckIfNill(options,"table")
                CheckType(options,"table")
                local title = options.Title 
                CheckIfNill(title,"string")
                CheckType(title,"string")
                local Callback = options.Callback
                CheckIfNill(Callback,"function")
                CheckType(Callback,"function")


                    local Button = Instance.new("TextButton")
                    local UICorner = Instance.new("UICorner")
                    local ElementTitle = Instance.new("TextLabel")


                    Button.Name = "Button"
                    Button.Parent = Page
                    Button.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                    Button.Position = UDim2.new(0.0432780832, 0, 0, 0)
                    Button.Size = UDim2.new(0, 496, 0, 40)
                    Button.AutoButtonColor = false
                    Button.Font = Enum.Font.SourceSans
                    Button.Text = ""
                    Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                    Button.TextSize = 14.000
                    Button.ClipsDescendants = true

                    UICorner.CornerRadius = UDim.new(0, 5)
                    UICorner.Parent = Button

                    ElementTitle.Name = "ElementTitle"
                    ElementTitle.Parent = Button
                    ElementTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ElementTitle.BackgroundTransparency = 1.000
                    ElementTitle.Position = UDim2.new(0.018495068, 0, 0.0500000007, 0)
                    ElementTitle.Size = UDim2.new(0, 477, 0, 35)
                    ElementTitle.Font = Enum.Font.GothamMedium
                    ElementTitle.Text = title
                    ElementTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                    ElementTitle.TextSize = 14.000
                    ElementTitle.TextXAlignment = Enum.TextXAlignment.Left


                    Button.MouseEnter:Connect(function(x, y)
                        TweenService:Create(Button,TweenInfo.new(.15),{ BackgroundColor3 = Color3.fromRGB(45,45,45)}):Play()
                        TweenService:Create(ElementTitle,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(240,240,240)}):Play()
                    end)
                    Button.MouseLeave:Connect(function(x, y)
                        TweenService:Create(Button,TweenInfo.new(.15),{ BackgroundColor3 = Color3.fromRGB(38,38,38)}):Play()
                        TweenService:Create(ElementTitle,TweenInfo.new(.15),{TextColor3 = Color3.fromRGB(200,200,200)}):Play()

                    end)
                    Button.MouseButton1Click:Connect(function()
                        pcall(Callback)
                        CircleAnim(Button,Color3.fromRGB(48,48,48),Color3.fromRGB(38,38,38))
                    end)
             end
             function Elements:Label(settings)
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local options = settings.Options
                CheckIfNill(options,"table")
                CheckType(options,"table")
                local title = options.Title 
                CheckIfNill(title,"string")
                CheckType(title,"string")

            local Label = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local ElementTitle = Instance.new("TextLabel")

          
            Label.Name = "Label"
            Label.Parent =  Page
            Label.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            Label.BackgroundTransparency = 0.500
            Label.Position = UDim2.new(0.0432780832, 0, 0.184, 0)
            Label.Size = UDim2.new(0, 496, 0, 33)

            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = Label

            ElementTitle.Name = "ElementTitle"
            ElementTitle.Parent = Label
            ElementTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ElementTitle.BackgroundTransparency = 1.000
            ElementTitle.Position = UDim2.new(0.00841448456, 0, -0.0409090929, 0)
            ElementTitle.Size = UDim2.new(0, 486, 0, 35)
            ElementTitle.Font = Enum.Font.GothamMedium
            ElementTitle.Text = title
            ElementTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            ElementTitle.TextSize = 14.000
             end
             function Elements:Slider(settings)
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local options = settings.Options
                CheckIfNill(options,"table")
                CheckType(options,"table")
                local title = options.Title 
                CheckIfNill(title,"string")
                CheckType(title,"string")
                local Min = options.Min or 16 
                local Max = options.Max or 500 
                local default = options.Default or Min
                local Callback = options.Callback
                CheckIfNill(Callback,"function")
                CheckType(Callback,"function")
                CheckType(Min,"number")
                CheckType(Max,"number")
                
                local SliderDef = math.clamp(default, Min, Max) or math.clamp(50, Min, Max)
			    local DefaultScale =  (SliderDef - Min) / (Max - Min)

                if Min > Max then
                    local ValueBefore = Min
                    Min, Max = Max, ValueBefore
                end
                local MinSize = 10
                local MaxSize = 36

            local Slider = Instance.new("Frame")
            local UICorner = Instance.new("UICorner")
            local ElementTitle = Instance.new("TextLabel")
            local Int = Instance.new("TextBox")
            local Back = Instance.new("TextButton")
            local UICorner_2 = Instance.new("UICorner")
            local Inner = Instance.new("Frame")
            local UICorner_3 = Instance.new("UICorner")

           
            Slider.Name = "Slider"
            Slider.Parent = Page
            Slider.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
            Slider.Position = UDim2.new(0.0432780832, 0, 0.340000004, 0)
            Slider.Size = UDim2.new(0, 496, 0, 58)

            UICorner.CornerRadius = UDim.new(0, 5)
            UICorner.Parent = Slider

            ElementTitle.Name = "ElementTitle"
            ElementTitle.Parent = Slider
            ElementTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            ElementTitle.BackgroundTransparency = 1.000
            ElementTitle.Position = UDim2.new(0.018495068, 0, 0.0500000007, 0)
            ElementTitle.Size = UDim2.new(0, 477, 0, 35)
            ElementTitle.Font = Enum.Font.GothamMedium
            ElementTitle.Text = title
            ElementTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
            ElementTitle.TextSize = 14.000
            ElementTitle.TextXAlignment = Enum.TextXAlignment.Left

            Int.Name = "Int"
            Int.Parent = Slider
            Int.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
            Int.BackgroundTransparency = 1.000
            Int.Position = UDim2.new(0.903575778, 0, -0.00172424316, 0)
            Int.Size = UDim2.new(0, 38, 0, 35)
            Int.Font = Enum.Font.GothamMedium
            Int.Text = "1000"
            Int.TextColor3 = Color3.fromRGB(200, 200, 200)
            Int.TextSize = 14.000
            Int.TextXAlignment = Enum.TextXAlignment.Right

            Back.Name = "Back"
            Back.Parent = Slider
            Back.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
            Back.Position = UDim2.new(0.0141129028, 0, 0.637931049, 0)
            Back.Size = UDim2.new(0, 481, 0, 8)
            Back.Text = ""
            Back.AutoButtonColor = false 

            UICorner_2.CornerRadius = UDim.new(0, 6)
            UICorner_2.Parent = Back

            Inner.Name = "Inner"
            Inner.Parent = Back
            Inner.BackgroundColor3 = Color3.fromRGB(65, 147, 223)
            Inner.BorderColor3 = Color3.fromRGB(38, 38, 38)
            Inner.Position = UDim2.new(-0.000440062198, 0, 0.112499237, 0)
            Inner.Size = UDim2.fromScale(DefaultScale,1)

            UICorner_3.CornerRadius = UDim.new(0, 6)
            UICorner_3.Parent = Inner

            pcall(Callback,default)
            Int.Text = default
           
            Int.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
                if enterPressed then
                       numb = tonumber(Int.Text)
                 
                      local function check()
                            if numb < Min and numb > Max then
                                warn("shoulden't run")
                                return false 
                                elseif numb >= Min and numb <= Max then
                                    return true 
                                end
                      end
                      if check() then
                        local oldSliderDef = math.clamp(Int.Text, Min, Max) or math.clamp(50, Min, Max)
                        local oldDefaultScale =  (oldSliderDef - Min) / (Max - Min)
                        TweenService:Create(Inner, TweenInfo.new(0.15), {Size = UDim2.fromScale(oldDefaultScale, 1)}):Play()
                      end
                end  
            end)
            Back.MouseButton1Down:Connect(function()
                local MouseMove, MouseKill
                MouseMove = Mouse.Move:Connect(function()
                    local Px = GetXY(Back)
                    local SizeFromScale = (MinSize +  (MaxSize - MinSize)) * Px
                    local Value = math.floor(Min + ((Max - Min) * Px))
                    SizeFromScale = SizeFromScale - (SizeFromScale % 2)
                    TweenService:Create(Inner, TweenInfo.new(0.15), {Size = UDim2.fromScale(Px, 1)}):Play()
                    Int.Text = tostring(Value)
                    pcall(Callback,Value)
                end)
                MouseKill = game:GetService("UserInputService").InputEnded:Connect(function(UserInput)
                    if UserInput.UserInputType == Enum.UserInputType.MouseButton1 then
                        MouseMove:Disconnect()
                        MouseKill:Disconnect()
                    end
                end)
            end)
                end 
             function Elements:Toggle(settings)
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local options = settings.Options
                CheckIfNill(options,"table")
                CheckType(options,"table")
                local title = options.Title 
                CheckIfNill(title,"string")
                CheckType(title,"string")
               local Default = options.Default or false 
               if Default == nil then
                 Default = false 
               end
               if typeof(Default) ~= 'boolean' then
                         Default = false 
               end
                local Callback = options.Callback 
                CheckIfNill(Callback,"function")
                CheckType(Callback,"function")

                local Toggle = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local ElementTitle = Instance.new("TextLabel")
                local Toggle_2 = Instance.new("TextButton")
                local Tracker = Instance.new("ImageLabel")
                local Dot = Instance.new("ImageLabel")


                Toggle.Name = "Toggle"
                Toggle.Parent = Page
                Toggle.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                Toggle.Size = UDim2.new(0, 496, 0, 40)
                Toggle.ClipsDescendants = true 


                UICorner.CornerRadius = UDim.new(0, 5)
                UICorner.Parent = Toggle

                ElementTitle.Name = "ElementTitle"
                ElementTitle.Parent = Toggle
                ElementTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ElementTitle.BackgroundTransparency = 1.000
                ElementTitle.Position = UDim2.new(0.018495068, 0, 0.0500000007, 0)
                ElementTitle.Size = UDim2.new(0, 477, 0, 35)
                ElementTitle.Font = Enum.Font.GothamMedium
                ElementTitle.Text = title
                ElementTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
                ElementTitle.TextSize = 14.000
                ElementTitle.TextXAlignment = Enum.TextXAlignment.Left

                Toggle_2.Name = "Toggle"
                Toggle_2.Parent = Toggle
                Toggle_2.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
                Toggle_2.BackgroundTransparency = 1.000
                Toggle_2.Size = UDim2.new(0, 496, 0, 40)
                Toggle_2.AutoButtonColor = false
                Toggle_2.Font = Enum.Font.SourceSans
                Toggle_2.Text = ""
                Toggle_2.TextColor3 = Color3.fromRGB(0, 0, 0)
                Toggle_2.TextSize = 14.000

                Tracker.Name = "Tracker"
                Tracker.Parent = Toggle
                Tracker.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
                Tracker.BackgroundTransparency = 1.000
                Tracker.Position = UDim2.new(0.915, 0,0.35, 0)
                Tracker.Size = UDim2.new(0, 26, 0, 12)
                Tracker.Image = "rbxassetid://3570695787"
                Tracker.ImageColor3 = Color3.fromRGB(28, 28, 28)
                Tracker.ScaleType = Enum.ScaleType.Slice
                Tracker.SliceCenter = Rect.new(100, 100, 100, 100)

                Dot.Name = "Dot"
                Dot.Parent = Tracker
                Dot.BackgroundColor3 = Color3.fromRGB(65, 147, 223)
                Dot.BackgroundTransparency = 1.000
                Dot.Position = UDim2.new(0, -8, 0.5, -8)
                Dot.Size = UDim2.new(0, 16, 0, 16)
                Dot.Image = "rbxassetid://3570695787"
                Dot.SliceCenter = Rect.new(100, 100, 100, 100)

                TweenService:Create(Dot, TweenInfo.new(0.15), {Position = (Default and UDim2.fromScale(1,0.5) or UDim2.fromScale(0,0.5)) - UDim2.fromOffset(8,8), ImageColor3 = Default and Color3.fromRGB(65, 147, 223) or Color3.fromRGB(255,255,255)}):Play()
                pcall(Callback,Default)


                Toggle_2.MouseButton1Click:Connect(function()
                    Default = not Default
                    TweenService:Create(Dot, TweenInfo.new(0.15), {Position = (Default and UDim2.fromScale(1,0.5) or UDim2.fromScale(0,0.5)) - UDim2.fromOffset(8,8), ImageColor3 = Default and Color3.fromRGB(65, 147, 223) or Color3.fromRGB(255,255,255)}):Play()
                    pcall(Callback,Default)
                    CircleAnim(Toggle,Color3.fromRGB(48,48,48),Color3.fromRGB(38,38,38))
                end)
             end
             function Elements:Textbox(settings)
                
                CheckIfNill(settings,"table")
                CheckType(settings,"table")
                local options = settings.Options
                CheckIfNill(options,"table")
                CheckType(options,"table")
                local title = options.Title 
                CheckIfNill(title,"string")
                CheckType(title,"string")
                local ptext = options.PText or ''
                CheckType(ptext, "string")
                local Callback = options.Callback 
                CheckIfNill(Callback,"function")
                CheckType(Callback,"function")

local Textbox = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local ElementTitle = Instance.new("TextLabel")
local Toggle = Instance.new("TextButton")
local TB = Instance.new("TextBox")
local UICorner_2 = Instance.new("UICorner")


Textbox.Name = "Textbox"
Textbox.Parent = Page
Textbox.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Textbox.BorderColor3 = Color3.fromRGB(27, 42, 53)
Textbox.Size = UDim2.new(0, 496, 0, 40)

UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = Textbox

ElementTitle.Name = "ElementTitle"
ElementTitle.Parent = Textbox
ElementTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ElementTitle.BackgroundTransparency = 1.000
ElementTitle.Position = UDim2.new(0.0184950065, 0, 0.0500000007, 0)
ElementTitle.Size = UDim2.new(0, 322, 0, 35)
ElementTitle.Font = Enum.Font.GothamMedium
ElementTitle.Text = title
ElementTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
ElementTitle.TextSize = 14.000
ElementTitle.TextXAlignment = Enum.TextXAlignment.Left

Toggle.Name = "Toggle"
Toggle.Parent = Textbox
Toggle.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Toggle.BackgroundTransparency = 1.000
Toggle.Size = UDim2.new(0, 496, 0, 40)
Toggle.AutoButtonColor = false
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = ""
Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
Toggle.TextSize = 14.000

TB.Name = "TB"
TB.Parent = Textbox
TB.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
TB.ClipsDescendants = true
TB.Position = UDim2.new(0.774193585, 0, 0.199999988, 0)
TB.Size = UDim2.new(0, 103, 0, 24)
TB.Font = Enum.Font.Gotham
TB.PlaceholderText = ptext
TB.Text = ""
TB.TextColor3 = Color3.fromRGB(220, 220, 220)
TB.TextSize = 12.000

UICorner_2.CornerRadius = UDim.new(0, 5)
UICorner_2.Parent = TB

Toggle.MouseButton1Click:Connect(function()
    TB:CaptureFocus()
end)
TB.FocusLost:Connect(function(enterPressed, inputThatCausedFocusLoss)
    if enterPressed then
        pcall(Callback,TB.Text)
    end
end)
end
function Elements:Dropdown(settings)
    CheckIfNill(settings,"table")
    CheckType(settings,"table")
    local options = settings.Options
    CheckIfNill(options,"table")
    CheckType(options,"table")
    local title = options.Title 
    CheckIfNill(title,"string")
    CheckType(title,"string")
    local items = options.Items or {"you have no items","you have no items","you have no items"}
    CheckType(items,"table")
    local callback = options.Callback
    CheckIfNill(callback,"function") 
    CheckType(callback,'function')
Dropped = false 
local dropsfun = {  }

local Dropdown = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local UIListLayout = Instance.new("UIListLayout")
local Toggle = Instance.new("TextButton")
local ElementTitle = Instance.new("TextLabel")
local expand_more = Instance.new("ImageButton")

--Properties:

Dropdown.Name = "Dropdown"
Dropdown.Parent = Page
Dropdown.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Dropdown.ClipsDescendants = true
Dropdown.Position = UDim2.new(0.0432780832, 0, 0.536000013, 0)
Dropdown.Size = UDim2.new(0, 496, 0, 40)

UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = Dropdown

UIListLayout.Parent = Dropdown
UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
UIListLayout.Padding = UDim.new(0, 4)

Toggle.Name = "Toggle"
Toggle.Parent = Dropdown
Toggle.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Toggle.BackgroundTransparency = 1.000
Toggle.Size = UDim2.new(0, 496, 0, 40)
Toggle.AutoButtonColor = false
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = ""
Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
Toggle.TextSize = 14.000

ElementTitle.Name = "ElementTitle"
ElementTitle.Parent = Toggle
ElementTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ElementTitle.BackgroundTransparency = 1.000
ElementTitle.Position = UDim2.new(0.0184950065, 0, 0.0500000007, 0)
ElementTitle.Size = UDim2.new(0, 322, 0, 35)
ElementTitle.Font = Enum.Font.GothamMedium
ElementTitle.Text = title
ElementTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
ElementTitle.TextSize = 14.000
ElementTitle.TextXAlignment = Enum.TextXAlignment.Left

expand_more.Name = "expand_more"
expand_more.Parent = Toggle
expand_more.BackgroundTransparency = 1.000
expand_more.LayoutOrder = 4
expand_more.Position = UDim2.new(0.933467627, 0, 0.174999997, 0)
expand_more.Size = UDim2.new(0, 23, 0, 25)
expand_more.ZIndex = 2
expand_more.Image = "rbxassetid://3926305904"
expand_more.ImageRectOffset = Vector2.new(564, 284)
expand_more.ImageRectSize = Vector2.new(36, 36)
expand_more.ScaleType = Enum.ScaleType.Fit

local function DropItem(v)
    local DropItem = Instance.new("TextButton")
    local UICorner_2 = Instance.new("UICorner")
    
    DropItem.Name = "DropItem"
    DropItem.Parent = Dropdown
    DropItem.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
    DropItem.Position = UDim2.new(-0.272177428, 0, 0.377358496, 0)
    DropItem.Size = UDim2.new(0, 483, 0, 25)
    DropItem.AutoButtonColor = false
    DropItem.Font = Enum.Font.GothamMedium
    DropItem.TextColor3 = Color3.fromRGB(255, 255, 255)
    DropItem.TextSize = 12.000
    DropItem.Text = v
    UICorner_2.CornerRadius = UDim.new(0, 5)
    UICorner_2.Parent = DropItem

    DropItem.MouseEnter:Connect(function(x, y)
        TweenService:Create(DropItem,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(35,35,35)}):Play()
    end)
    DropItem.MouseLeave:Connect(function(x, y)
        TweenService:Create(DropItem,TweenInfo.new(.25),{BackgroundColor3 = Color3.fromRGB(28,28,28)}):Play()
    end)
    DropItem.MouseButton1Click:Connect(function()
        pcall(callback, DropItem.Text)
        ElementTitle.Text = title .. " - " .. DropItem.Text
        TweenService:Create(Dropdown,TweenInfo.new(.25),{ Size = UDim2.new(0, 496, 0, 40) }):Play()
        TweenService:Create(expand_more,TweenInfo.new(.25),{ Rotation = 0}):Play()
        Dropped = false
    end)
end
for i,v in next, items do
    DropItem(v)
end

Toggle.MouseButton1Click:Connect(function()
    Dropped = not Dropped 
    if Dropped then
        TweenService:Create(Dropdown,TweenInfo.new(.25), { Size = UDim2.new(0,496,0,UIListLayout.AbsoluteContentSize.Y + 8)}):Play()
        TweenService:Create(expand_more,TweenInfo.new(.1), { Rotation = 180}):Play()   
    else
        TweenService:Create(Dropdown,TweenInfo.new(.25), { Size = UDim2.new(0, 496, 0, 40)}):Play()
        TweenService:Create(expand_more,TweenInfo.new(.1), { Rotation = 0}):Play()
    end
end)
        function dropsfun:Refresh(newitems)
            for i,v in pairs(Dropdown:GetChildren()) do
                if v.Name == "DropItem" then
                    v:Destroy()
                end
            end
            for i,v in pairs(newitems) do
                DropItem(v)
            end
        end
        return dropsfun
end
function Elements:Keybind(settings)
    

    CheckIfNill(settings,"table")
    CheckType(settings,"table")
    local options = settings.Options
    CheckIfNill(options,"table")
    CheckType(options,"table")
    local title = options.Title 
    CheckIfNill(title,"string")
    CheckType(title,"string")
    local key = options.Key or Enum.KeyCode.F 
    local oldKey = key.Name
    local callback = options.Callback
    CheckIfNill(callback,"function") 
    CheckType(callback,'function')

local Keybind = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Toggle = Instance.new("TextButton")
local ElementTitle = Instance.new("TextLabel")
local InputButton = Instance.new("TextButton")
local UICorner_2 = Instance.new("UICorner")



Keybind.Name = "Keybind"
Keybind.Parent = Page
Keybind.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Keybind.ClipsDescendants = true
Keybind.Position = UDim2.new(0.0432780832, 0, 0.536000013, 0)
Keybind.Size = UDim2.new(0, 496, 0, 40)

UICorner.CornerRadius = UDim.new(0, 5)
UICorner.Parent = Keybind

Toggle.Name = "Toggle"
Toggle.Parent = Keybind
Toggle.BackgroundColor3 = Color3.fromRGB(38, 38, 38)
Toggle.BackgroundTransparency = 1.000
Toggle.Size = UDim2.new(0, 496, 0, 40)
Toggle.AutoButtonColor = false
Toggle.Font = Enum.Font.SourceSans
Toggle.Text = ""
Toggle.TextColor3 = Color3.fromRGB(0, 0, 0)
Toggle.TextSize = 14.000

ElementTitle.Name = "ElementTitle"
ElementTitle.Parent = Toggle
ElementTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
ElementTitle.BackgroundTransparency = 1.000
ElementTitle.Position = UDim2.new(0.0184950065, 0, 0.0500000007, 0)
ElementTitle.Size = UDim2.new(0, 322, 0, 35)
ElementTitle.Font = Enum.Font.GothamMedium
ElementTitle.Text = title
ElementTitle.TextColor3 = Color3.fromRGB(200, 200, 200)
ElementTitle.TextSize = 14.000
ElementTitle.TextXAlignment = Enum.TextXAlignment.Left

InputButton.Name = "InputButton"
InputButton.Parent = Keybind
InputButton.BackgroundColor3 = Color3.fromRGB(28, 28, 28)
InputButton.Position = UDim2.new(0.773999989, 0, 0.200000003, 0)
InputButton.Size = UDim2.new(0, 103, 0, 24)
InputButton.AutoButtonColor = false
InputButton.Font = Enum.Font.Gotham
InputButton.Text = oldKey
InputButton.TextColor3 = Color3.fromRGB(230, 230, 230)
InputButton.TextSize = 12.000

UICorner_2.CornerRadius = UDim.new(0, 5)
UICorner_2.Parent = InputButton


InputButton.MouseButton1Click:Connect(function()
                                
    InputButton.TextSize = 0 
    TweenService:Create(InputButton,TweenInfo.new(.2),{ TextSize = 15}):Play()
    InputButton.Text = "..."
    wait(.2)
    TweenService:Create(InputButton,TweenInfo.new(.2),{TextSize = 13}):Play()
    InputButton.Text = "..."
    local a, b = game:GetService('UserInputService').InputBegan:wait();
    if a.KeyCode.Name ~= "Unknown" then
        InputButton.Text = a.KeyCode.Name
        oldKey = a.KeyCode.Name;
    end
end)
game:GetService("UserInputService").InputBegan:connect(function(current, ok) 
    if not ok then 
        if current.KeyCode.Name == oldKey then 
            pcall(callback)
        end
    end
end)
end
             return Elements
            end
            return Tabs
end
warn('elsiah#1548 wassss here')
return Library

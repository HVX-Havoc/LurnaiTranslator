local Translator = {}
Translator.AvailableLanguages = {
    ["English"] = {name = "English", flag = "🇺🇸"},
    ["Spanish"] = {name = "Español", flag = "🇪🇸"},
    ["Portuguese"] = {name = "Português", flag = "🇧🇷"},
    ["French"] = {name = "Français", flag = "🇫🇷"},
    ["German"] = {name = "Deutsch", flag = "🇩🇪"},
    ["Italian"] = {name = "Italiano", flag = "🇮🇹"},
    ["Russian"] = {name = "Русский", flag = "🇷🇺"},
    ["Chinese"] = {name = "中文", flag = "🇨🇳"},
    ["Japanese"] = {name = "日本語", flag = "🇯🇵"},
    ["Korean"] = {name = "한국어", flag = "🇰🇷"},
    ["Thai"] = {name = "ไทย", flag = "🇹🇭"}
}

Translator.LanguageUrls = {
    ["English"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/English.Lua",
    ["Spanish"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/Spanish.lua",
    ["Portuguese"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/Portuguese.lua",
    ["French"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/French.lua",
    ["German"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/German.lua",
    ["Italian"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/Italian.lua",
    ["Russian"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/Russian.lua",
    ["Chinese"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/Chinese.lua",
    ["Japanese"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/Japanese.lua",
    ["Korean"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/Korean.lua",
    ["Thai"] = "https://raw.githubusercontent.com/HVX-Havoc/LurnaiTranslator/main/languages/Thai.lua"
}

function Translator:DetectUserLanguage()
    local success, locale = pcall(function()
        return game:GetService("LocalizationService").RobloxLocaleId
    end)
    
    if success then
        local localeMap = {
            ["en-us"] = "English", ["es-es"] = "Spanish", ["pt-br"] = "Portuguese",
            ["fr-fr"] = "French", ["de-de"] = "German", ["it-it"] = "Italian",
            ["ru-ru"] = "Russian", ["zh-cn"] = "Chinese", ["ja-jp"] = "Japanese",
            ["ko-kr"] = "Korean", ["th-th"] = "Thai"
        }
        
        local detectedLang = localeMap[locale:lower()]
        if detectedLang and self.AvailableLanguages[detectedLang] then
            return detectedLang
        end
    end
    
    return "English"
end

function Translator:CreateLanguageUI(callback)
    local CurrentLanguage = self:DetectUserLanguage()
    local SelectedLanguage = CurrentLanguage
    
    local ScreenGui = Instance.new("ScreenGui")
    ScreenGui.Name = "LurnaiLanguageSelector"
    ScreenGui.ResetOnSpawn = false
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    ScreenGui.DisplayOrder = 999
    
    pcall(function()
        ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    end)
    
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("CoreGui")
    end
    
    local blur = Instance.new("BlurEffect")
    blur.Size = 0
    blur.Parent = game:GetService("Lighting")
    
    local Overlay = Instance.new("Frame")
    Overlay.Name = "Overlay"
    Overlay.Size = UDim2.new(1, 0, 1, 0)
    Overlay.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    Overlay.BackgroundTransparency = 1
    Overlay.BorderSizePixel = 0
    Overlay.Parent = ScreenGui
    
    local MainFrame = Instance.new("Frame")
    MainFrame.Name = "MainFrame"
    MainFrame.Size = UDim2.new(0, 250, 0, 320)
    MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
    MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
    MainFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 30)
    MainFrame.BorderSizePixel = 0
    MainFrame.BackgroundTransparency = 1
    MainFrame.Parent = ScreenGui
    
    local UICorner = Instance.new("UICorner")
    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = MainFrame
    
    local Shadow = Instance.new("ImageLabel")
    Shadow.Name = "Shadow"
    Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
    Shadow.BackgroundTransparency = 1
    Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
    Shadow.Size = UDim2.new(1, 30, 1, 30)
    Shadow.ZIndex = -1
    Shadow.Image = "rbxassetid://6014261993"
    Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
    Shadow.ImageTransparency = 1
    Shadow.ScaleType = Enum.ScaleType.Slice
    Shadow.SliceCenter = Rect.new(49, 49, 450, 450)
    Shadow.Parent = MainFrame
    
    local UIGradient = Instance.new("UIGradient")
    UIGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(30, 30, 40)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 30))
    })
    UIGradient.Rotation = 45
    UIGradient.Parent = MainFrame
    
    local Logo = Instance.new("ImageLabel")
    Logo.Name = "Logo"
    Logo.Size = UDim2.new(0, 40, 0, 40)
    Logo.Position = UDim2.new(0, 15, 0, 15)
    Logo.BackgroundTransparency = 1
    Logo.Image = "rbxassetid://14133403086"
    Logo.ImageTransparency = 1
    Logo.Parent = MainFrame
    
    local Title = Instance.new("TextLabel")
    Title.Name = "Title"
    Title.Size = UDim2.new(0, 150, 0, 25)
    Title.Position = UDim2.new(0, 65, 0, 15)
    Title.BackgroundTransparency = 1
    Title.Text = "Lurnai Hub"
    Title.TextColor3 = Color3.fromRGB(255, 255, 255)
    Title.TextSize = 18
    Title.Font = Enum.Font.GothamBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.TextTransparency = 1
    Title.Parent = MainFrame
    
    local Subtitle = Instance.new("TextLabel")
    Subtitle.Name = "Subtitle"
    Subtitle.Size = UDim2.new(0, 150, 0, 20)
    Subtitle.Position = UDim2.new(0, 65, 0, 35)
    Subtitle.BackgroundTransparency = 1
    Subtitle.Text = "Select Your Language"
    Subtitle.TextColor3 = Color3.fromRGB(180, 180, 180)
    Subtitle.TextSize = 12
    Subtitle.Font = Enum.Font.Gotham
    Subtitle.TextXAlignment = Enum.TextXAlignment.Left
    Subtitle.TextTransparency = 1
    Subtitle.Parent = MainFrame
    
    local LanguageContainer = Instance.new("Frame")
    LanguageContainer.Name = "LanguageContainer"
    LanguageContainer.Size = UDim2.new(0, 230, 0, 210)
    LanguageContainer.Position = UDim2.new(0.5, 0, 0, 70)
    LanguageContainer.AnchorPoint = Vector2.new(0.5, 0)
    LanguageContainer.BackgroundTransparency = 1
    LanguageContainer.BorderSizePixel = 0
    LanguageContainer.Parent = MainFrame
    
    local ScrollFrame = Instance.new("ScrollingFrame")
    ScrollFrame.Name = "ScrollFrame"
    ScrollFrame.Size = UDim2.new(1, 0, 1, 0)
    ScrollFrame.BackgroundTransparency = 1
    ScrollFrame.BorderSizePixel = 0
    ScrollFrame.ScrollBarThickness = 3
    ScrollFrame.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
    ScrollFrame.ScrollBarImageTransparency = 0.7
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollFrame.Parent = LanguageContainer
    
    local UIListLayout = Instance.new("UIListLayout")
    UIListLayout.Padding = UDim.new(0, 5)
    UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center
    UIListLayout.Parent = ScrollFrame
    
    local ButtonHeight = 32
    
    local sortedLanguages = {}
    for langCode, langInfo in pairs(self.AvailableLanguages) do
        table.insert(sortedLanguages, {code = langCode, info = langInfo})
    end
    
    table.sort(sortedLanguages, function(a, b)
        return a.info.name < b.info.name
    end)
    
    for _, langData in ipairs(sortedLanguages) do
        local langCode = langData.code
        local langInfo = langData.info
        
        local Button = Instance.new("TextButton")
        Button.Name = langCode .. "Button"
        Button.Size = UDim2.new(0.95, 0, 0, ButtonHeight)
        Button.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
        Button.BackgroundTransparency = 1
        Button.Text = ""
        Button.Parent = ScrollFrame
        
        local ButtonCorner = Instance.new("UICorner")
        ButtonCorner.CornerRadius = UDim.new(0, 6)
        ButtonCorner.Parent = Button
        
        local SelectionIndicator = Instance.new("Frame")
        SelectionIndicator.Name = "SelectionIndicator"
        SelectionIndicator.Size = UDim2.new(0, 3, 1, -8)
        SelectionIndicator.Position = UDim2.new(0, 4, 0, 4)
        SelectionIndicator.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
        SelectionIndicator.BorderSizePixel = 0
        SelectionIndicator.Visible = (langCode == CurrentLanguage)
        SelectionIndicator.BackgroundTransparency = 1
        SelectionIndicator.Parent = Button
        
        local IndicatorCorner = Instance.new("UICorner")
        IndicatorCorner.CornerRadius = UDim.new(0, 2)
        IndicatorCorner.Parent = SelectionIndicator
        
        local FlagLabel = Instance.new("TextLabel")
        FlagLabel.Name = "FlagLabel"
        FlagLabel.Size = UDim2.new(0, 24, 0, 24)
        FlagLabel.Position = UDim2.new(0, 12, 0.5, 0)
        FlagLabel.AnchorPoint = Vector2.new(0, 0.5)
        FlagLabel.BackgroundTransparency = 1
        FlagLabel.Text = langInfo.flag
        FlagLabel.TextSize = 16
        FlagLabel.Font = Enum.Font.GothamBold
        FlagLabel.TextTransparency = 1
        FlagLabel.Parent = Button
        
        local NameLabel = Instance.new("TextLabel")
        NameLabel.Name = "NameLabel"
        NameLabel.Size = UDim2.new(1, -50, 1, 0)
        NameLabel.Position = UDim2.new(0, 40, 0, 0)
        NameLabel.BackgroundTransparency = 1
        NameLabel.Text = langInfo.name
        NameLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
        NameLabel.TextSize = 12
        NameLabel.Font = Enum.Font.Gotham
        NameLabel.TextXAlignment = Enum.TextXAlignment.Left
        NameLabel.TextTransparency = 1
        NameLabel.Parent = Button
        
        Button.MouseButton1Click:Connect(function()
            SelectedLanguage = langCode
            
            for _, child in pairs(ScrollFrame:GetChildren()) do
                if child:IsA("TextButton") then
                    local indicator = child:FindFirstChild("SelectionIndicator")
                    if indicator then
                        indicator.Visible = (child.Name == langCode .. "Button")
                    end
                    
                    if child.Name == langCode .. "Button" then
                        child.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
                    else
                        child.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                    end
                end
            end
        end)
        
        if langCode == CurrentLanguage then
            Button.BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            SelectionIndicator.Visible = true
        end
        
        Button.MouseEnter:Connect(function()
            game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {
                BackgroundColor3 = Color3.fromRGB(60, 60, 80)
            }):Play()
        end)
        
        Button.MouseLeave:Connect(function()
            if langCode ~= SelectedLanguage then
                game:GetService("TweenService"):Create(Button, TweenInfo.new(0.2), {
                    BackgroundColor3 = Color3.fromRGB(40, 40, 50)
                }):Play()
            end
        end)
    end
    
    ScrollFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 5)
    
    local ConfirmButton = Instance.new("TextButton")
    ConfirmButton.Name = "ConfirmButton"
    ConfirmButton.Size = UDim2.new(0.9, 0, 0, 30)
    ConfirmButton.Position = UDim2.new(0.5, 0, 1, -40)
    ConfirmButton.AnchorPoint = Vector2.new(0.5, 0)
    ConfirmButton.BackgroundColor3 = Color3.fromRGB(0, 120, 215)
    ConfirmButton.BorderSizePixel = 0
    ConfirmButton.Text = "Confirm"
    ConfirmButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    ConfirmButton.TextSize = 14
    ConfirmButton.Font = Enum.Font.GothamBold
    ConfirmButton.BackgroundTransparency = 1
    ConfirmButton.TextTransparency = 1
    ConfirmButton.Parent = MainFrame
    
    local ConfirmCorner = Instance.new("UICorner")
    ConfirmCorner.CornerRadius = UDim.new(0, 6)
    ConfirmCorner.Parent = ConfirmButton
    
    local CloseButton = Instance.new("TextButton")
    CloseButton.Name = "CloseButton"
    CloseButton.Size = UDim2.new(0, 24, 0, 24)
    CloseButton.Position = UDim2.new(1, -10, 0, 10)
    CloseButton.AnchorPoint = Vector2.new(1, 0)
    CloseButton.BackgroundColor3 = Color3.fromRGB(60, 60, 70)
    CloseButton.BorderSizePixel = 0
    CloseButton.Text = "✓"
    CloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    CloseButton.TextSize = 14
    CloseButton.Font = Enum.Font.GothamBold
    CloseButton.BackgroundTransparency = 1
    CloseButton.TextTransparency = 1
    CloseButton.ZIndex = 10
    CloseButton.Parent = MainFrame
    
    local CloseCorner = Instance.new("UICorner")
    CloseCorner.CornerRadius = UDim.new(1, 0)
    CloseCorner.Parent = CloseButton
    
    ConfirmButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(ConfirmButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 140, 235)
        }):Play()
    end)
    
    ConfirmButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(ConfirmButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(0, 120, 215)
        }):Play()
    end)
    
    CloseButton.MouseEnter:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(80, 80, 90)
        }):Play()
    end)
    
    CloseButton.MouseLeave:Connect(function()
        game:GetService("TweenService"):Create(CloseButton, TweenInfo.new(0.2), {
            BackgroundColor3 = Color3.fromRGB(60, 60, 70)
        }):Play()
    end)
    
    local function confirmSelection()
        CurrentLanguage = SelectedLanguage
        print("Selected language: " .. CurrentLanguage)
        
        local tweenService = game:GetService("TweenService")
        local outTweenInfo = TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.In)
        
        tweenService:Create(Overlay, outTweenInfo, {BackgroundTransparency = 1}):Play()
        tweenService:Create(MainFrame, outTweenInfo, {BackgroundTransparency = 1}):Play()
        tweenService:Create(Shadow, outTweenInfo, {ImageTransparency = 1}):Play()
        tweenService:Create(Logo, outTweenInfo, {ImageTransparency = 1}):Play()
        tweenService:Create(Title, outTweenInfo, {TextTransparency = 1}):Play()
        tweenService:Create(Subtitle, outTweenInfo, {TextTransparency = 1}):Play()
        tweenService:Create(ConfirmButton, outTweenInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        tweenService:Create(CloseButton, outTweenInfo, {BackgroundTransparency = 1, TextTransparency = 1}):Play()
        tweenService:Create(blur, outTweenInfo, {Size = 0}):Play()
        
        for _, child in pairs(ScrollFrame:GetChildren()) do
            if child:IsA("TextButton") then
                tweenService:Create(child, outTweenInfo, {BackgroundTransparency = 1}):Play()
                
                local nameLabel = child:FindFirstChild("NameLabel")
                if nameLabel then
                    tweenService:Create(nameLabel, outTweenInfo, {TextTransparency = 1}):Play()
                end
                
                local flagLabel = child:FindFirstChild("FlagLabel")
                if flagLabel then
                    tweenService:Create(flagLabel, outTweenInfo, {TextTransparency = 1}):Play()
                end
                
                local indicator = child:FindFirstChild("SelectionIndicator")
                if indicator then
                    tweenService:Create(indicator, outTweenInfo, {BackgroundTransparency = 1}):Play()
                end
            end
        end
        
        task.delay(0.5, function()
            ScreenGui:Destroy()
            blur:Destroy()
            
            if callback then
                callback(CurrentLanguage)
            end
        end)
    end
    
    ConfirmButton.MouseButton1Click:Connect(confirmSelection)
    CloseButton.MouseButton1Click:Connect(confirmSelection)
    
    local UserInputService = game:GetService("UserInputService")
    local inputConnection
    
    inputConnection = UserInputService.InputBegan:Connect(function(input, gameProcessed)
        if not gameProcessed and (input.KeyCode == Enum.KeyCode.Return or input.KeyCode == Enum.KeyCode.KeypadEnter) then
            confirmSelection()
            if inputConnection then
                inputConnection:Disconnect()
            end
        end
    end)
    
    local tweenService = game:GetService("TweenService")
    local inTweenInfo = TweenInfo.new(0.5, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)
    
    MainFrame.BackgroundTransparency = 1
    Overlay.BackgroundTransparency = 1
    Shadow.ImageTransparency = 1
    Logo.ImageTransparency = 1
    Title.TextTransparency = 1
    Subtitle.TextTransparency = 1
    ConfirmButton.BackgroundTransparency = 1
    ConfirmButton.TextTransparency = 1
    CloseButton.BackgroundTransparency = 1
    CloseButton.TextTransparency = 1
    
    for _, child in pairs(ScrollFrame:GetChildren()) do
        if child:IsA("TextButton") then
            child.BackgroundTransparency = 1
            
            local nameLabel = child:FindFirstChild("NameLabel")
            if nameLabel then
                nameLabel.TextTransparency = 1
            end
            
            local flagLabel = child:FindFirstChild("FlagLabel")
            if flagLabel then
                flagLabel.TextTransparency = 1
            end
            
            local indicator = child:FindFirstChild("SelectionIndicator")
            if indicator then
                indicator.BackgroundTransparency = 1
            end
        end
    end
    
    tweenService:Create(blur, inTweenInfo, {Size = 10}):Play()
    tweenService:Create(Overlay, inTweenInfo, {BackgroundTransparency = 0.5}):Play()
    
    task.delay(0.1, function()
        tweenService:Create(MainFrame, inTweenInfo, {BackgroundTransparency = 0}):Play()
        tweenService:Create(Shadow, inTweenInfo, {ImageTransparency = 0.5}):Play()
    end)
    
    task.delay(0.2, function()
        tweenService:Create(Logo, inTweenInfo, {ImageTransparency = 0}):Play()
        tweenService:Create(CloseButton, inTweenInfo, {BackgroundTransparency = 0, TextTransparency = 0}):Play()
    end)
    
    task.delay(0.3, function()
        tweenService:Create(Title, inTweenInfo, {TextTransparency = 0}):Play()
    end)
    
    task.delay(0.4, function()
        tweenService:Create(Subtitle, inTweenInfo, {TextTransparency = 0}):Play()
    end)
    
    task.delay(0.5, function()
        for i, child in ipairs(ScrollFrame:GetChildren()) do
            if child:IsA("TextButton") then
                task.delay((i-1) * 0.03, function()
                    tweenService:Create(child, inTweenInfo, {BackgroundTransparency = 0}):Play()
                    
                    local nameLabel = child:FindFirstChild("NameLabel")
                    if nameLabel then
                        tweenService:Create(nameLabel, inTweenInfo, {TextTransparency = 0}):Play()
                    end
                    
                    local flagLabel = child:FindFirstChild("FlagLabel")
                    if flagLabel then
                        tweenService:Create(flagLabel, inTweenInfo, {TextTransparency = 0}):Play()
                    end
                    
                    local indicator = child:FindFirstChild("SelectionIndicator")
                    if indicator and indicator.Visible then
                        tweenService:Create(indicator, inTweenInfo, {BackgroundTransparency = 0}):Play()
                    end
                end)
            end
        end
    end)
    
    task.delay(0.6, function()
        tweenService:Create(ConfirmButton, inTweenInfo, {
            BackgroundTransparency = 0,
            TextTransparency = 0
        }):Play()
    end)
    
    return ScreenGui
end

function Translator:LoadLanguage(languageCode)
    local url = self.LanguageUrls[languageCode]
    if not url then
        warn("Language not found: " .. tostring(languageCode))
        return nil
    end
    
    local success, languageData = pcall(function()
        return game:HttpGet(url)
    end)
    
    if success then
        local langModule = loadstring(languageData)()
        return langModule
    else
        warn("Failed to load language data: " .. tostring(languageCode))
        return nil
    end
end

function Translator:SelectAndLoadLanguage(callback)
    local selectedLanguage = self:DetectUserLanguage()
    
    self:CreateLanguageUI(function(langCode)
        selectedLanguage = langCode
        
        local langData = self:LoadLanguage(langCode)
        
        if callback then
            callback(langCode, langData)
        end
    end)
    
    return selectedLanguage
end

local Lang = {}

function GetTranslation(key)
    if not key then return "MISSING_KEY" end
    
    local parts = string.split(key, ".")
    local current = Lang
    
    for _, part in ipairs(parts) do
        if current and current[part] then
            current = current[part]
        else
            return key
        end
    end
    
    if type(current) == "string" then
        return current
    else
        return key
    end
end

Translator:SelectAndLoadLanguage(function(languageCode, languageData)
    Lang = languageData or {}
    
    if not languageData then
        warn("Failed to load language data, falling back to English")
        Lang = Translator:LoadLanguage("English") or {}
    end
    
    InitializeUI()
end)


function InitializeUI()

-- Тут нечего смотреть, очередной говно-код (серьезно код говно). Прошу покинуть данный файл -_-

local VERSION = "0.1.3"

local frame = CreateFrame("Frame")
local optionsF = CreateFrame("Frame", nil, UIParent)
local absF = CreateFrame("Frame", nil, UIParent)
local combatFrame = CreateFrame("Frame")
local combatLogF = CreateFrame("Frame")
local combatLogUnfilteredF = CreateFrame("Frame")
local specChangeF = CreateFrame("Frame")
local timerF = CreateFrame("Frame")
local itemChangeF = CreateFrame("Frame")
local tempF = CreateFrame("Frame")

local currentAbsorb = 0
local inCombat = false
local currentSpec = ""
local T5 = 0
local trinketAbsorb1 = 0
local trinketAbsorb2 = { 0, 0 }
local trinketAbsorb3 = 0
local trinketAbsorb4 = 0

local function specCheck()
    if (IsSpellKnown(55262)) then
        currentSpec = "Blood"
    elseif (IsSpellKnown(55268)) then
        currentSpec = "Frost"
    elseif (IsSpellKnown(9634)) then
        currentSpec = "DruidProt"
    elseif (IsSpellKnown(48827)) then
        currentSpec = "PaladinProt"
    else
        currentSpec = ""
    end
end

local T5_Dk = {
    { -- Head
        "87612", -- 277
        "103499", -- 290
        "151693" -- 297
    },
    { -- Shoulder
        "87494",
        "103496",
        "151690"
    },
    { -- Chest
        "90600",
        "103500",
        "151694"
    },
    { -- Hands
        "87601",
        "103498",
        "151692"
    },
    { -- Legs
        "87589",
        "103497",
        "151691"
    }
}

local T5_DruidProt = {
    { -- Head
        "30228", -- 277
        "103483", -- 290
        "151677" -- 297
    },
    { -- Shoulder
        "30230",
        "103485",
        "151679"
    },
    { -- Chest
        "30222",
        "103481",
        "151675"
    },
    { -- Hands
        "30223",
        "103482",
        "151676"
    },
    { -- Legs
        "30229",
        "103484",
        "151678"
    }
}

local T5_PaladinProt = {
    { -- Head
        "30125", -- 277
        "103418", -- 290
        "151612" -- 297
    },
    { -- Shoulder
        "30127",
        "103420",
        "151614"
    },
    { -- Chest
        "30123",
        "103416",
        "151610"
    },
    { -- Hands
        "30124",
        "103417",
        "151611"
    },
    { -- Legs
        "30126",
        "103419",
        "151613"
    }
}

local function howManyT5(spec)

    T5 = 0

    if (spec == "Blood" or spec == "Frost") then
        for i = 1, #T5_Dk do
            local item = T5_Dk[i]
            for x = 1, #item do
                if (i == 1) then
                    local itemId = GetInventoryItemID("player", 1)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 2) then
                    local itemId = GetInventoryItemID("player", 3)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 3) then
                    local itemId = GetInventoryItemID("player", 5)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 4) then
                    local itemId = GetInventoryItemID("player", 10)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 5) then
                    local itemId = GetInventoryItemID("player", 7)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
            end
        end
    end

    if (spec == "DruidProt") then
        for i = 1, #T5_DruidProt do
            local item = T5_DruidProt[i]
            for x = 1, #item do
                if (i == 1) then
                    local itemId = GetInventoryItemID("player", 1)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 2) then
                    local itemId = GetInventoryItemID("player", 3)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 3) then
                    local itemId = GetInventoryItemID("player", 5)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 4) then
                    local itemId = GetInventoryItemID("player", 10)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 5) then
                    local itemId = GetInventoryItemID("player", 7)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
            end
        end
    end

    if (spec == "PaladinProt") then
        for i = 1, #T5_PaladinProt do
            local item = T5_PaladinProt[i]
            for x = 1, #item do
                if (i == 1) then
                    local itemId = GetInventoryItemID("player", 1)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 2) then
                    local itemId = GetInventoryItemID("player", 3)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 3) then
                    local itemId = GetInventoryItemID("player", 5)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 4) then
                    local itemId = GetInventoryItemID("player", 10)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
                if (i == 5) then
                    local itemId = GetInventoryItemID("player", 7)
                    if (itemId ~= nil) then if (tostring(item[x]) == tostring(itemId)) then T5 = T5 + 1 end  end
                end
            end
        end
    end
end

frame:RegisterEvent("ADDON_LOADED")
frame:SetScript("OnEvent", function (self, event, addOnName)
    if (event == "ADDON_LOADED" and addOnName == "AbsorbT5") then
        print("|cff2499ed[AbsorbT5]|r v"..VERSION)

        if (isFixPos == nil) then isFixPos = false end
        if (showOnlyInCombat == nil) then isFixPos = false end
        if (hideIfNoBuff == nil) then hideIfNoBuff = false end
        if (showTimer == nil) then showTimer = false end
        if (showRageRP == nil) then showRageRP = false end
        if (showAbs == nil) then showAbs = false end
        if (testMode == nil) then testMode = false end
        if (displayMode == nil) then displayMode = 1 end

        options()
        howManyT5(currentSpec)
    end
end)

combatFrame:RegisterEvent("PLAYER_REGEN_DISABLED")
combatFrame:RegisterEvent("PLAYER_REGEN_ENABLED")

combatLogF:RegisterEvent("COMBAT_LOG_EVENT")
combatLogUnfilteredF:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")

specChangeF:RegisterEvent("SPELLS_CHANGED")

itemChangeF:RegisterEvent("UNIT_INVENTORY_CHANGED")
itemChangeF:SetScript("OnEvent", function (self, event, unit)
    if (unit == "player") then
        howManyT5(currentSpec)
    end
end)

function options()
    specCheck()
    local function saveAbsPoint(absFrame)
        local point, relativeTo, relativePoint, xOfs, yOfs = absFrame:GetPoint()
        oldPos = {}
        oldPos.point = point; oldPos.relativeTo = relativeTo; oldPos.relativePoint = relativePoint; oldPos.xOfs = xOfs; oldPos.yOfs = yOfs
    end
    local function saveAbsTimerPoint(absTimerFrame)
        local point, _, relativePoint, xOfs, yOfs = absTimerFrame:GetPoint()
        oldPosTimer = {}
        oldPosTimer.point = point;
        oldPosTimer.relativePoint = relativePoint; oldPosTimer.xOfs = xOfs;
        oldPosTimer.yOfs = yOfs
    end
    optionsF:SetWidth("350")
    optionsF:SetHeight("550")
    optionsF:SetPoint("CENTER")
    optionsF:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    optionsF:SetBackdropColor(0, 0, 0, .8)
    optionsF:EnableMouse(true)
    optionsF:SetMovable(true)
    optionsF:RegisterForDrag("LeftButton")
    optionsF:SetScript("OnDragStart", optionsF.StartMoving)
    optionsF:SetScript("OnDragStop", optionsF.StopMovingOrSizing)
    optionsF:Hide()






    absF:SetWidth("100")
    absF:SetHeight("30")
    if (oldPos == nil) then
        absF:SetPoint("RIGHT", optionsF, "RIGHT", 130, 0)
    else
        absF:SetPoint(oldPos.point, oldPos.relativeTo, oldPos.relativePoint, oldPos.xOfs, oldPos.yOfs)
    end
    absF:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    absF:SetBackdropColor(0, 0, 0, .8)
    absF:EnableMouse(not isFixPos)
    absF:SetMovable(true)
    absF:RegisterForDrag("LeftButton")
    absF:SetScript("OnDragStart", absF.StartMoving)
    absF:SetScript("OnDragStop", function ()
        saveAbsPoint(absF)
        absF:StopMovingOrSizing()
    end)

    if (hideIfNoBuff) then
        absF:Hide()
    else
        if (showAbs) then
            absF:Show()
        else
            absF:Hide()
        end
    end

    absF.Text = absF:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    absF.Text:SetPoint("CENTER")
    absF.Text:SetText(currentAbsorb)

    absF.Text2 = absF:CreateFontString(nil, "OVERLAY", "GameFontHighlightLarge")
    absF.Text2:SetPoint("RIGHT", absF, "RIGHT", -10, 0)
    absF.Text2:SetText("")
    if (displayMode == 1) then
        absF:SetHeight(30)
        absF.Text:ClearAllPoints()
        absF.Text:SetPoint("CENTER")
        absF.Text:SetTextColor(1,1,1,1)
        absF.Text:SetText(math.floor(currentAbsorb))
        absF.Text2:Hide()
    elseif (displayMode == 2) then
        absF.Text2:Show()
        absF:SetHeight(50)

        absF.Text:SetHeight(absF:GetHeight() / 2)
        absF.Text2:SetHeight(absF:GetHeight() / 2)

        absF.Text:ClearAllPoints()
        absF.Text2:ClearAllPoints()
        absF.Text:SetPoint("TOP", absF, "TOP", 0, 0)
        absF.Text2:SetPoint("BOTTOM", absF, "BOTTOM", 0, 0)

        if (currentSpec == "Frost") then
            absF.Text:SetTextColor(0,.9,1,1)
        elseif (currentSpec == "Blood") then
            absF.Text:SetTextColor(1,.1,.1,1)
        elseif (currentSpec == "DruidProt") then
            absF.Text:SetTextColor(1,.4,0,1)
        elseif (currentSpec == "PaladinProt") then
            absF.Text:SetTextColor(.9,.2,.7,1)
        end

        absF.Text:SetText("("..math.floor(currentAbsorb)..")")
        absF.Text2:SetText(UnitHealth("player"))
    elseif (displayMode == 3) then
        absF.Text2:Show()
        absF:SetHeight(50)

        absF.Text:SetHeight(absF:GetHeight() / 2)
        absF.Text2:SetHeight(absF:GetHeight() / 2)

        absF.Text:ClearAllPoints()
        absF.Text2:ClearAllPoints()
        absF.Text:SetPoint("BOTTOM", absF, "BOTTOM", 0, 0)
        absF.Text2:SetPoint("TOP", absF, "TOP", 0, 0)

        if (currentSpec == "Frost") then
            absF.Text:SetTextColor(0,.9,1,1)
        elseif (currentSpec == "Blood") then
            absF.Text:SetTextColor(1,.1,.1,1)
        elseif (currentSpec == "DruidProt") then
            absF.Text:SetTextColor(1,.4,0,1)
        elseif (currentSpec == "PaladinProt") then
            absF.Text:SetTextColor(.9,.2,.7,1)
        end

        absF.Text:SetText("("..math.floor(currentAbsorb)..")")
        absF.Text2:SetText(UnitHealth("player"))
    elseif (displayMode == 4) then
        absF:SetHeight(30)
        absF.Text:ClearAllPoints()
        absF.Text:SetPoint("CENTER")

        if (currentSpec == "Frost" and currentAbsorb > 0) then
            absF.Text:SetTextColor(0,.9,1,1)
        elseif (currentSpec == "Blood" and currentAbsorb > 0) then
            absF.Text:SetTextColor(1,.1,.1,1)
        elseif (currentSpec == "DruidProt" and currentAbsorb > 0) then
            absF.Text:SetTextColor(1,.4,0,1)
        elseif (currentSpec == "PaladinProt" and currentAbsorb > 0) then
            absF.Text:SetTextColor(.9,.2,.7,1)
        else
            absF.Text:SetTextColor(1,1,1,1)
        end

        absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
        absF.Text2:Hide()
    end


    absF.Timer = CreateFrame("Frame", nil, absF)
    absF.Timer:SetWidth("30")
    absF.Timer:SetHeight("20")
    if (oldPosTimer == nil) then
        absF.Timer:SetPoint("RIGHT", absF, "RIGHT", 30, 0)
    else
        absF.Timer:SetPoint(oldPosTimer.point, absF, oldPosTimer.relativePoint, oldPosTimer.xOfs, oldPosTimer.yOfs)
    end
    absF.Timer:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    absF.Timer:SetBackdropColor(0, 0, 0, .8)

    absF.Timer.Text = absF.Timer:CreateFontString(nil, "OVERLAY", "GameFontNormalLarge")
    absF.Timer.Text:SetPoint("CENTER")
    absF.Timer.Text:SetText("")
    if (showTimer) then
        absF.Timer:Show()
    else
        absF.Timer:Hide()
    end

    optionsF.Title = optionsF:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsF.Title:SetPoint("TOP", 0, -10)
    optionsF.Title:SetText("AbsorbT5 Основные настройки")

    optionsF.ShowAbs = CreateFrame("Frame", nil, optionsF)
    optionsF.ShowAbs:SetWidth(220)
    optionsF.ShowAbs:SetHeight(18)
    optionsF.ShowAbs:SetPoint("TOP", optionsF.Title, "TOP", 0, -30)
    optionsF.ShowAbs:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    optionsF.ShowAbs:SetBackdropColor(1, .4, 0, 1)
    optionsF.ShowAbs:EnableMouse(true)
    optionsF.ShowAbs.Text = optionsF.ShowAbs:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsF.ShowAbs.Text:SetPoint("CENTER")
    optionsF.ShowAbs.Text:SetText("Показать / Скрыть окно абсорба")
    optionsF.ShowAbs:SetScript("OnEnter", function ()
        optionsF.ShowAbs:SetBackdropColor(0, 0, 0, 1)
    end)
    optionsF.ShowAbs:SetScript("OnLeave", function ()
        optionsF.ShowAbs:SetBackdropColor(1, .4, 0, 1)
    end)
    optionsF.ShowAbs:SetScript("OnMouseUp", function ()
        if (not absF:IsShown()) then
            absF:Show()
            showAbs = true
        else
            absF:Hide()
            showAbs = false
        end
    end)

    optionsF.ResetPos = CreateFrame("Frame", nil, optionsF)
    optionsF.ResetPos:SetWidth(160)
    optionsF.ResetPos:SetHeight(18)
    optionsF.ResetPos:SetPoint("TOP", optionsF.ShowAbs, "TOP", 0, -40)
    optionsF.ResetPos:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    optionsF.ResetPos:SetBackdropColor(1, 0, 0, 1)
    optionsF.ResetPos:EnableMouse(true)
    optionsF.ResetPos.Text = optionsF.ResetPos:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsF.ResetPos.Text:SetPoint("CENTER")
    optionsF.ResetPos.Text:SetText("Сбросить позицию")
    optionsF.ResetPos:SetScript("OnEnter", function ()
        optionsF.ResetPos:SetBackdropColor(0, 0, 0, 1)
    end)
    optionsF.ResetPos:SetScript("OnLeave", function ()
        optionsF.ResetPos:SetBackdropColor(1, 0, 0, 1)
    end)
    optionsF.ResetPos:SetScript("OnMouseUp", function ()
        absF:ClearAllPoints()
        absF:SetPoint("TOPLEFT", nil, "TOPLEFT", (GetScreenWidth() / 2) - (absF:GetWidth() / 2), -(GetScreenHeight() / 2) - (absF:GetHeight() / 2))
        saveAbsPoint(absF)
    end)

    optionsF.FixPosAbs = CreateFrame("CheckButton", nil, optionsF, "InterfaceOptionsCheckButtonTemplate")
	optionsF.FixPosAbs:SetPoint("TOP", optionsF.ResetPos, "TOPLEFT", 10, -45)
	optionsF.FixPosAbs.Text:SetText("Зафиксировать позицию")
    optionsF.FixPosAbs:SetChecked(isFixPos)
    optionsF.FixPosAbs:SetScript("OnClick", function()
        isFixPos = not(not optionsF.FixPosAbs:GetChecked())
        absF:EnableMouse(not isFixPos)
	end)

    optionsF.ShowOnlyInCombat = CreateFrame("CheckButton", nil, optionsF, "InterfaceOptionsCheckButtonTemplate")
	optionsF.ShowOnlyInCombat:SetPoint("TOP", optionsF.FixPosAbs, "TOP", 0, -45)
	optionsF.ShowOnlyInCombat.Text:SetText("Показывать только в бою")
    optionsF.ShowOnlyInCombat:SetChecked(showOnlyInCombat)
    optionsF.ShowOnlyInCombat:SetScript("OnClick", function()
        showOnlyInCombat = not(not optionsF.ShowOnlyInCombat:GetChecked())

        if (showOnlyInCombat) then
            if (inCombat) then absF:Show() else absF:Hide() end
        else
            if (not hideIfNoBuff) then absF:Show() end
        end
        
	end)

    combatFrame:SetScript("OnEvent", function(self, event)
        if (event == "PLAYER_REGEN_DISABLED") then
            inCombat = true

            if (showOnlyInCombat) then absF:Show() end
        end
    
        if (event == "PLAYER_REGEN_ENABLED") then
            inCombat = false

            if (showOnlyInCombat) then absF:Hide() end

            tempF:SetScript("OnUpdate", nil)
        end
    end)

    optionsF.HideIfNoBuff = CreateFrame("CheckButton", nil, optionsF, "InterfaceOptionsCheckButtonTemplate")
	optionsF.HideIfNoBuff:SetPoint("TOP", optionsF.ShowOnlyInCombat, "TOP", 0, -45)
	optionsF.HideIfNoBuff.Text:SetText("Скрывать если нет абсорба")
    optionsF.HideIfNoBuff:SetChecked(hideIfNoBuff)
    optionsF.HideIfNoBuff:SetScript("OnClick", function()
        hideIfNoBuff = not(not optionsF.HideIfNoBuff:GetChecked())

        if (hideIfNoBuff) then
            if (currentAbsorb == 0) then absF:Hide() end
        else
            if (not showOnlyInCombat) then absF:Show() end
        end
	end)

    optionsF.ShowTimer = CreateFrame("CheckButton", nil, optionsF, "InterfaceOptionsCheckButtonTemplate")
    optionsF.TimerPos = CreateFrame("Frame", nil, optionsF)

	optionsF.ShowTimer:SetPoint("TOP", optionsF.HideIfNoBuff, "TOP", 0, -45)
	optionsF.ShowTimer.Text:SetText("Отображать таймер")
    optionsF.ShowTimer:SetChecked(showTimer)
    optionsF.ShowTimer:SetScript("OnClick", function()
        showTimer = not(not optionsF.ShowTimer:GetChecked())

        if (showTimer) then
            absF.Timer:Show()
            optionsF.TimerPos:Show()
        else
            absF.Timer:Hide()
            optionsF.TimerPos:Hide()
            optionsF.TimerPos.List:Hide()
            optionsF.TimerPos:SetBackdropColor(1, 1, 1, .7)
        end
	end)

    optionsF.TimerPos:SetWidth(90)
    optionsF.TimerPos:SetHeight(15)
	optionsF.TimerPos:SetPoint("LEFT", optionsF.ShowTimer, "LEFT", optionsF.TimerPos:GetWidth() + 60, 0)
    optionsF.TimerPos:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    optionsF.TimerPos:SetBackdropColor(1, 1, 1, .7)
    optionsF.TimerPos:EnableMouse(true)
    if (not showTimer) then
        optionsF.TimerPos:Hide()
    end
    optionsF.TimerPos.Text = optionsF.TimerPos:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    optionsF.TimerPos.Text:SetPoint("CENTER")
    optionsF.TimerPos.Text:SetText("Выбрать позицию")

    optionsF.TimerPos.List = CreateFrame("Frame", nil, optionsF)
    optionsF.TimerPos.List:SetWidth(optionsF.TimerPos:GetWidth())
    optionsF.TimerPos.List:SetHeight(100)
    optionsF.TimerPos.List:EnableMouse(true)
    optionsF.TimerPos.List:SetFrameStrata("TOOLTIP")
    optionsF.TimerPos.List:SetPoint("BOTTOM", optionsF.TimerPos, "BOTTOM", 0, -(optionsF.TimerPos.List:GetHeight()))
    optionsF.TimerPos.List:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    optionsF.TimerPos.List:SetBackdropColor(0, 0, 0, 1)
    optionsF.TimerPos.List:Hide()

    optionsF.TimerPos:SetScript("OnMouseDown", function ()
        if (optionsF.TimerPos.List:IsShown()) then
            optionsF.TimerPos.List:Hide()
            optionsF.TimerPos:SetBackdropColor(1, 1, 1, .7)
        else
            optionsF.TimerPos.List:Show()
            optionsF.TimerPos:SetBackdropColor(0, 0, 0, 1)
        end
    end)

    local timerPositons = { "Слева", "Сверху", "Справа", "Внизу" }
    local tPos = { "LEFT", "TOP", "RIGHT", "BOTTOM" }

    local timerPosFrames = {}

    for i = 1, #timerPositons do
        timerPosFrames[i] = CreateFrame("Frame", nil, optionsF.TimerPos.List)
        timerPosFrames[i]:SetWidth(optionsF.TimerPos.List:GetWidth())
        timerPosFrames[i]:SetHeight(optionsF.TimerPos.List:GetHeight() / #timerPositons)
        if (i == 1) then
            timerPosFrames[i]:SetPoint("TOP", optionsF.TimerPos.List, "TOP")
        else
            timerPosFrames[i]:SetPoint("TOP", timerPosFrames[i - 1], "TOP", 0, -(timerPosFrames[i]:GetHeight()))
        end
        timerPosFrames[i]:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        })
        timerPosFrames[i]:SetBackdropColor(0, 0, 0, 0)
        timerPosFrames[i].Text = timerPosFrames[i]:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
        timerPosFrames[i].Text:SetPoint("CENTER")
        timerPosFrames[i].Text:SetText(timerPositons[i])
        timerPosFrames[i]:EnableMouse(true)
        timerPosFrames[i]:SetScript("OnEnter", function ()
            timerPosFrames[i]:SetBackdropColor(1, 1, 1, .4)
        end)
        timerPosFrames[i]:SetScript("OnLeave", function ()
            timerPosFrames[i]:SetBackdropColor(0, 0, 0, 0)
        end)
        timerPosFrames[i]:SetScript("OnMouseDown", function ()
            absF.Timer:ClearAllPoints()
            if (i == 1) then
                absF.Timer:SetPoint(tPos[i], absF, tPos[i], -(absF.Timer:GetWidth()), 0)
            elseif (i == 2) then
                absF.Timer:SetPoint(tPos[i], absF, tPos[i], 0, absF.Timer:GetHeight())
            elseif (i == 3) then
                absF.Timer:SetPoint(tPos[i], absF, tPos[i], absF.Timer:GetWidth(), 0)
            elseif (i == 4) then
                absF.Timer:SetPoint(tPos[i], absF, tPos[i], 0, -(absF.Timer:GetHeight()))
            end
            saveAbsTimerPoint(absF.Timer)
        end)
    end

    optionsF.TestMode = CreateFrame("CheckButton", nil, optionsF, "InterfaceOptionsCheckButtonTemplate")
    optionsF.TestMode:SetPoint("TOP", optionsF.ShowTimer, "TOP", 0, -45)
	optionsF.TestMode.Text:SetText("Тестовый режим")
    optionsF.TestMode:SetChecked(testMode)
    optionsF.TestMode:SetScript("OnClick", function()
        testMode = not(not optionsF.TestMode:GetChecked())
	end)

    optionsF.DisplayMode = CreateFrame("Frame", nil, optionsF)
    optionsF.DisplayMode:SetWidth(160)
    optionsF.DisplayMode:SetHeight(18)
    optionsF.DisplayMode:SetPoint("TOP", optionsF.ResetPos, "TOP", 0,  -(optionsF:GetHeight()) + (optionsF:GetHeight() / 100 * 50))
    optionsF.DisplayMode:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    optionsF.DisplayMode:SetBackdropColor(.8, .8, 1, 1)
    optionsF.DisplayMode:EnableMouse(true)

    optionsF.DisplayMode.Text = optionsF.DisplayMode:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsF.DisplayMode.Text:SetPoint("CENTER")
    optionsF.DisplayMode.Text:SetText("Отображение абсорба")

    optionsF.DisplayMode.List = CreateFrame("Frame", nil, optionsF)
    optionsF.DisplayMode.List:SetWidth(optionsF.DisplayMode:GetWidth())
    optionsF.DisplayMode.List:SetHeight(70)
    optionsF.DisplayMode.List:EnableMouse(true)
    optionsF.DisplayMode.List:SetPoint("BOTTOM", optionsF.DisplayMode, "BOTTOM", 0, -(optionsF.DisplayMode.List:GetHeight()))
    optionsF.DisplayMode.List:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    optionsF.DisplayMode.List:SetBackdropColor(0, 0, 0, 1)
    optionsF.DisplayMode.List:Hide()
    
    optionsF.DisplayMode:SetScript("OnMouseDown", function ()
        if (optionsF.DisplayMode.List:IsShown()) then
            optionsF.DisplayMode.List:Hide()
            optionsF.DisplayMode:SetBackdropColor(.8, .8, 1, 1)
        else
            optionsF.DisplayMode.List:Show()
            optionsF.DisplayMode:SetBackdropColor(0, 0, .1, 1)
        end
    end)

    local displayModes = {
        "Абсорб",
        "ХП (Абсорб)",
        "(Абсорб) ХП",
        "ХП + Абсорб"
    }

    local displayModeFrames = {}

    for i = 1, #displayModes do
        displayModeFrames[i] = CreateFrame("Frame", nil, optionsF.DisplayMode.List)
        displayModeFrames[i]:SetWidth(optionsF.DisplayMode.List:GetWidth())
        displayModeFrames[i]:SetHeight(optionsF.DisplayMode.List:GetHeight() / #displayModes)
        if (i == 1) then
            displayModeFrames[i]:SetPoint("TOP", optionsF.DisplayMode.List, "TOP")
        else
            displayModeFrames[i]:SetPoint("TOP", displayModeFrames[i - 1], "TOP", 0, -(displayModeFrames[i]:GetHeight()))
        end
        displayModeFrames[i]:SetBackdrop({
            bgFile = "Interface/Tooltips/UI-Tooltip-Background",
        })
        displayModeFrames[i]:SetBackdropColor(0, 0, 0, 0)
        displayModeFrames[i].Text = displayModeFrames[i]:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
        displayModeFrames[i].Text:SetPoint("CENTER")
        displayModeFrames[i].Text:SetText(displayModes[i])
        displayModeFrames[i]:EnableMouse(true)
        displayModeFrames[i]:SetScript("OnEnter", function ()
            displayModeFrames[i]:SetBackdropColor(1, 1, 1, .4)
        end)
        displayModeFrames[i]:SetScript("OnLeave", function ()
            displayModeFrames[i]:SetBackdropColor(0, 0, 0, 0)
        end)
        displayModeFrames[i]:SetScript("OnMouseDown", function ()
            if (i == 1) then
                absF:SetHeight(30)
                absF.Text:ClearAllPoints()
                absF.Text:SetPoint("CENTER")

                if (currentSpec == "Frost" and currentAbsorb > 0) then
                    absF.Text:SetTextColor(0,.9,1,1)
                elseif (currentSpec == "Blood" and currentAbsorb > 0) then
                    absF.Text:SetTextColor(1,.1,.1,1)
                elseif (currentSpec == "DruidProt" and currentAbsorb > 0) then
                    absF.Text:SetTextColor(1,.4,0,1)
                elseif (currentSpec == "PaladinProt" and currentAbsorb > 0) then
                    absF.Text:SetTextColor(.9,.2,.7,1)
                else
                    absF.Text:SetTextColor(1,1,1,1)
                end

                absF.Text:SetText(math.floor(currentAbsorb))
                absF.Text2:Hide()
            elseif (i == 2) then
                absF.Text2:Show()
                absF:SetHeight(50)

                absF.Text:SetHeight(absF:GetHeight() / 2)
                absF.Text2:SetHeight(absF:GetHeight() / 2)

                absF.Text:ClearAllPoints()
                absF.Text2:ClearAllPoints()
                absF.Text:SetPoint("TOP", absF, "TOP", 0, 0)
                absF.Text2:SetPoint("BOTTOM", absF, "BOTTOM", 0, 0)

                if (currentSpec == "Frost") then
                    absF.Text:SetTextColor(0,.9,1,1)
                elseif (currentSpec == "Blood") then
                    absF.Text:SetTextColor(1,.1,.1,1)
                elseif (currentSpec == "DruidProt") then
                    absF.Text:SetTextColor(1,.4,0,1)
                elseif (currentSpec == "PaladinProt") then
                    absF.Text:SetTextColor(.9,.2,.7,1)
                end

                absF.Text:SetText("("..math.floor(currentAbsorb)..")")
                absF.Text2:SetText(UnitHealth("player"))
            elseif (i == 3) then
                absF.Text2:Show()
                absF:SetHeight(50)

                absF.Text:SetHeight(absF:GetHeight() / 2)
                absF.Text2:SetHeight(absF:GetHeight() / 2)

                absF.Text:ClearAllPoints()
                absF.Text2:ClearAllPoints()
                absF.Text:SetPoint("BOTTOM", absF, "BOTTOM", 0, 0)
                absF.Text2:SetPoint("TOP", absF, "TOP", 0, 0)

                if (currentSpec == "Frost") then
                    absF.Text:SetTextColor(0,.9,1,1)
                elseif (currentSpec == "Blood") then
                    absF.Text:SetTextColor(1,.1,.1,1)
                elseif (currentSpec == "DruidProt") then
                    absF.Text:SetTextColor(1,.4,0,1)
                elseif (currentSpec == "PaladinProt") then
                    absF.Text:SetTextColor(.9,.2,.7,1)
                end

                absF.Text:SetText("("..math.floor(currentAbsorb)..")")
                absF.Text2:SetText(UnitHealth("player"))
            elseif (i == 4) then
                absF:SetHeight(30)
                absF.Text:ClearAllPoints()
                absF.Text:SetPoint("CENTER")

                if (currentSpec == "Frost" and currentAbsorb > 0) then
                    absF.Text:SetTextColor(0,.9,1,1)
                elseif (currentSpec == "Blood" and currentAbsorb > 0) then
                    absF.Text:SetTextColor(1,.1,.1,1)
                elseif (currentSpec == "DruidProt" and currentAbsorb > 0) then
                    absF.Text:SetTextColor(1,.4,0,1)
                elseif (currentSpec == "PaladinProt" and currentAbsorb > 0) then
                    absF.Text:SetTextColor(.9,.2,.7,1)
                else
                    absF.Text:SetTextColor(1,1,1,1)
                end

                absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
                absF.Text2:Hide()
            end
            displayMode = i
        end)
    end


    optionsF.Close = CreateFrame("Frame", nil, optionsF)
    optionsF.Close:SetWidth(25)
    optionsF.Close:SetHeight(25)
    optionsF.Close:SetPoint("TOPRIGHT")
    optionsF.Close:SetBackdrop({
        bgFile = "Interface/Tooltips/UI-Tooltip-Background",
    })
    optionsF.Close:SetBackdropColor(1, 0, 0, .5)
    optionsF.Close:EnableMouse(true)
    optionsF.Close.Text = optionsF.Close:CreateFontString(nil, "OVERLAY", "GameFontHighlight")
    optionsF.Close.Text:SetPoint("CENTER")
    optionsF.Close.Text:SetText("x")
    optionsF.Close:SetScript("OnEnter", function ()
        optionsF.Close:SetBackdropColor(0, 0, 0, 1)
    end)
    optionsF.Close:SetScript("OnLeave", function ()
        optionsF.Close:SetBackdropColor(1, 0, 0, .5)
    end)
    optionsF.Close:SetScript("OnMouseUp", function ()
        optionsF.TimerPos.List:Hide()
        optionsF.TimerPos:SetBackdropColor(1, 1, 1, .7)
        
        optionsF.DisplayMode.List:Hide()
        optionsF.DisplayMode:SetBackdropColor(.8, .8, 1, 1)
        optionsF:Hide()
    end)


    local hpFrame = CreateFrame("Frame")
    hpFrame:RegisterEvent("UNIT_HEALTH")
    hpFrame:SetScript("OnEvent", function(self, event, arg1)
        if (arg1 == "player") then
            if (displayMode == 2 or displayMode == 3) then
                absF.Text2:SetText(UnitHealth("player"))
            elseif (displayMode == 4) then
                if (currentAbsorb > 0) then
                    if (currentSpec == "Frost") then
                        absF.Text:SetTextColor(0,.9,1,1)
                    elseif (currentSpec == "Blood") then
                        absF.Text:SetTextColor(1,.1,.1,1)
                    elseif (currentSpec == "DruidProt") then
                        absF.Text:SetTextColor(1,.4,0,1)
                    elseif (currentSpec == "PaladinProt") then
                        absF.Text:SetTextColor(.9,.2,.7,1)
                    end
                else 
                    absF.Text:SetTextColor(1, 1, 1, 1)
                end
                absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
            end
        end
    end)

    local absorbQueue = {}

    local function addAbsorbFdk(dmg)
        local calc = ((dmg * 2) * (150 + GetDodgeChance() * 3 + GetParryChance() * 3) / 100)
    
        currentAbsorb = currentAbsorb + calc
        if (currentAbsorb > 50000) then currentAbsorb = 50000 end

        if (displayMode == 1) then
            absF.Text:SetText(math.floor(currentAbsorb))
            absF.Text:SetTextColor(0,.9,1,1)
        elseif (displayMode == 2 or displayMode == 3) then
            absF.Text:SetText("("..math.floor(currentAbsorb)..")")
            absF.Text:SetTextColor(0,.9,1,1)
            absF.Text2:SetText(UnitHealth("player"))
        elseif (displayMode == 4) then
            absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
            absF.Text:SetTextColor(0,.9,1,1)
        end
        
        if (testMode) then
            print("Ледяной удар нанес "..dmg.." урона и повесил "..math.floor(calc).." абсорба.")
        end
    end

    local function addAbsorbBdk()
        local calc = (UnitHealthMax("player") - UnitHealth("player")) + ((UnitHealth("player") / 100) * 14)

        currentAbsorb = calc

        if (displayMode == 1) then
            absF.Text:SetText(math.floor(currentAbsorb))
            absF.Text:SetTextColor(1,.1,.1,1)
        elseif (displayMode == 2 or displayMode == 3) then
            absF.Text:SetText("("..math.floor(currentAbsorb)..")")
            absF.Text:SetTextColor(1,.1,.1,1)
            absF.Text2:SetText(UnitHealth("player"))
        elseif (displayMode == 4) then
            absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
            absF.Text:SetTextColor(1,.1,.1,1)
        end

        if (testMode) then
            print("Удар смерти повесил "..math.floor(calc).." абсорба.")
        end
    end

    local function addAbsordProtoDruid()
        baseAP, posBuffAP= UnitAttackPower("player")
        local calc = 0
        if (T5 == 2 or T5 == 3) then
            calc = ((baseAP + posBuffAP) / 100) * 25
        elseif (T5 == 4 or T5 == 5) then
            calc = ((baseAP + posBuffAP) / 100) * 100
        end


        currentAbsorb = currentAbsorb + calc
        if (currentAbsorb > 50000) then currentAbsorb = 50000 end

        if (displayMode == 1) then
            absF.Text:SetText(math.floor(currentAbsorb))
            absF.Text:SetTextColor(1,.4,0,1)
        elseif (displayMode == 2 or displayMode == 3) then
            absF.Text:SetText("("..math.floor(currentAbsorb)..")")
            absF.Text:SetTextColor(1,.4,0,1)
            absF.Text2:SetText(UnitHealth("player"))
        elseif (displayMode == 4) then
            absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
            absF.Text:SetTextColor(1,.4,0,1)
        end

        if (testMode) then
            print("Критический удар повесил "..math.floor(calc).. " абсорба")
        end
    end

    local function addAbsorbProtoPaladin(t5_stacks)
        local calc = ((GetParryChance() + GetBlockChance()) / 100 * GetShieldBlock()) * t5_stacks
    
        currentAbsorb = calc
        if (currentAbsorb > 50000) then currentAbsorb = 50000 end

        if (displayMode == 1) then
            absF.Text:SetText(math.floor(currentAbsorb))
            absF.Text:SetTextColor(.9,.2,.7,1)
        elseif (displayMode == 2 or displayMode == 3) then
            absF.Text:SetText("("..math.floor(currentAbsorb)..")")
            absF.Text:SetTextColor(.9,.2,.7,1)
            absF.Text2:SetText(UnitHealth("player"))
        elseif (displayMode == 4) then
            absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
            absF.Text:SetTextColor(.9,.2,.7,1)
        end
        
        if (testMode) then
            print("Священное пламя повесил "..math.floor(calc).." абсорба.")
        end
    end
    
    local function removeAbsorb(dmg, subevent, schoolDmg, trinket)
        if (absorbQueue[1] == "Затвердевшая кожа" or 
            absorbQueue[1] == "Железное сердце" and absorbQueue[2] == "Затвердевшая кожа" and trinket == trinketAbsorb2) then
            if (trinketAbsorb1 > 0 and trinket ~= trinketAbsorb1) then
                if (trinketAbsorb1 > 0) then
                    if (trinketAbsorb1 - dmg < 0) then
                        local remainder = dmg - trinketAbsorb1
                        trinketAbsorb1 = 0
                        removeAbsorb(remainder, subevent, schoolDmg, trinketAbsorb1)
                        return
                    elseif (trinketAbsorb1 - dmg > 0) then
                        trinketAbsorb1 = trinketAbsorb1 - dmg
                        return
                    elseif (trinketAbsorb1 - dmg == 0) then
                        trinketAbsorb1 = 0
                        return
                    end
                end
            end
        end

        if (absorbQueue[1] == "Железное сердце" and trinket ~= trinketAbsorb2) then
            if (subevent == "SPELL_MISSED" and trinket ~= trinketAbsorb2 and
            schoolDmg == 2 or
            schoolDmg == 4 or
            schoolDmg == 8 or
            schoolDmg == 16 or
            schoolDmg == 32 or
            schoolDmg == 64) then
                if (trinketAbsorb2[1] > 0) then
                    if (trinketAbsorb2[1] - dmg < 0) then
                        local remainder = dmg - trinketAbsorb2[1]
                        removeAbsorb(remainder, subevent, schoolDmg, trinketAbsorb2)
                        return
                    end
                end
            end
            
            if (subevent == "SPELL_PERIODIC_MISSED" and trinket ~= trinketAbsorb2 and
            schoolDmg == 2 or
            schoolDmg == 4 or
            schoolDmg == 8 or
            schoolDmg == 16 or
            schoolDmg == 32 or
            schoolDmg == 64) then
                if (trinketAbsorb2[2] > 0) then
                    if (trinketAbsorb2[2] - dmg < 0) then
                        local remainder = dmg - trinketAbsorb2[2]
                        removeAbsorb(remainder, subevent, schoolDmg, trinketAbsorb2)
                        return
                    end
                end
            end
        end

        if (absorbQueue[1] == "Пелена лжи" or
        absorbQueue[1] == "Железное сердце" and absorbQueue[2] == "Пелена лжи" and trinket == trinketAbsorb2) then
            if (trinketAbsorb3 > 0 and trinket ~= trinketAbsorb3) then
                if (trinketAbsorb3 > 0) then
                    if (trinketAbsorb3 - dmg < 0) then
                        local remainder = dmg - trinketAbsorb3
                        trinketAbsorb3 = 0
                        removeAbsorb(remainder, subevent, schoolDmg, trinketAbsorb3)
                        return
                    elseif (trinketAbsorb3 - dmg > 0) then
                        trinketAbsorb3 = trinketAbsorb3 - dmg
                        return
                    elseif (trinketAbsorb3 - dmg == 0) then
                        trinketAbsorb3 = 0
                        return
                    end
                end
            end
        end

        if (absorbQueue[1] == "Стойкая преграда" or
        absorbQueue[1] == "Железное сердце" and absorbQueue[2] == "Стойкая преграда" and trinket == trinketAbsorb2) then
            if (trinketAbsorb4 > 0 and trinket ~= trinketAbsorb4) then
                if (trinketAbsorb4 > 0) then
                    if (trinketAbsorb4 - dmg < 0) then
                        local remainder = dmg - trinketAbsorb4
                        trinketAbsorb4 = 0
                        removeAbsorb(remainder, subevent, schoolDmg, trinketAbsorb4)
                        return
                    elseif (trinketAbsorb4 - dmg > 0) then
                        trinketAbsorb4 = trinketAbsorb4 - dmg
                        return
                    elseif (trinketAbsorb4 - dmg == 0) then
                        trinketAbsorb4 = 0
                        return
                    end
                end
            end
        end

        if (absorbQueue[1] == "Ледяной доспех" or
            absorbQueue[1] == "Кровавый щит" or
            absorbQueue[1] == "Дикая защита" or
            absorbQueue[1] == "Барьер света" or
        absorbQueue[1] == "Железное сердце" and absorbQueue[2] == "Ледяной доспех" and trinket == trinketAbsorb2 or
        absorbQueue[1] == "Железное сердце" and absorbQueue[2] == "Кровавый щит" and trinket == trinketAbsorb2 or
        absorbQueue[1] == "Железное сердце" and absorbQueue[2] == "Дикая защита" and trinket == trinketAbsorb2 or
        absorbQueue[1] == "Железное сердце" and absorbQueue[2] == "Барьер света" and trinket == trinketAbsorb2) then
            currentAbsorb = currentAbsorb - dmg
            if (currentAbsorb <= 0) then
                currentAbsorb = 0
                if (displayMode == 1) then
                    absF.Text:SetText(0)
                    absF.Text:SetTextColor(1,1,1,1)
                elseif (displayMode == 2 or displayMode == 3) then
                    absF.Text:SetText("(0)")
                elseif (displayMode == 4) then
                    absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
                    absF.Text:SetTextColor(1,1,1,1)
                end
            end
            
            if (displayMode == 1) then
                absF.Text:SetText(math.floor(currentAbsorb))
            elseif (displayMode == 2 or displayMode == 3) then
                absF.Text:SetText("("..math.floor(currentAbsorb)..")")
            elseif (displayMode == 4) then
                absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
            end
        end
    end

    local function setTimer(spell)
        timerF:SetScript("OnUpdate", function (self, elapsed)
            name, _, _, _, _, duration, expirationTime
            = UnitBuff("player", spell)

            absF.Timer.Text:SetText(math.floor(expirationTime - GetTime()))
        end)
    end

    local function removeTimer()
        timerF:SetScript("OnUpdate", nil)
        absF.Timer.Text:SetText("")
    end
    local function sortAbsorbQueue()
        if (#absorbQueue > 1) then
            for i = 1, #absorbQueue do
                if (absorbQueue[i] == nil) then
                    for y = i + 1, (#absorbQueue + 1) do
                        if (absorbQueue[y] ~= nil) then
                            absorbQueue[i] = absorbQueue[y]
                            absorbQueue[y] = nil
                            break
                        end
                    end
                end
            end
        end
    end

    local function addAbsorbQueue(absorb)
        sortAbsorbQueue()

        for i = 1, #absorbQueue + 1 do
            if (absorbQueue[i] == nil) then
                absorbQueue[i] = absorb
            end
        end
    end

    local function removeAbsorbQueue(absorb)
        for i = 1, #absorbQueue do
            if (absorbQueue[i] == absorb) then
                absorbQueue[i] = nil
            end
        end

        sortAbsorbQueue()
    end

    local function fixBugWithFdkAbsorb(timeFS) -- жесткий костыль из-за ******* бага сируса с Т5
        tempF:SetScript("OnUpdate", function ()
            local buffName1 = UnitBuff("player", "Ледяной доспех")
            if (buffName1 == nil) then
                if (GetTime() - timeFS > 0.5) then currentAbsorb = 0 end
                if (displayMode == 1) then
                    absF.Text:SetText(0)
                    absF.Text:SetTextColor(1,1,1,1)
                elseif (displayMode == 2 or displayMode == 3) then
                    absF.Text:SetText("(0)")
                    absF.Text:SetTextColor(0,.9,1,1)
                elseif (displayMode == 4) then
                    absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
                    absF.Text:SetTextColor(1,1,1,1)
                end
            else
                tempF:SetScript("OnUpdate", nil)
            end
        end)
    end

    combatLogUnfilteredF:SetScript("OnEvent", function (self, event, timestamp, subevent, 
        arg3, name, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18)
        local playerName = GetUnitName("player")

        if (subevent == "SPELL_DAMAGE" and name == playerName) then
            if (arg10 == "Ранящие слова") then
                if (trinketAbsorb3 + 9225 >= 46125) then
                    trinketAbsorb3 = 46125
                else
                    trinketAbsorb3 = trinketAbsorb3 + 9225
                end
            end
        end

        if (subevent == "SPELL_AURA_APPLIED" and name == playerName) then
            if (arg10 == "Затвердевшая кожа") then
                if (trinketAbsorb1 == 0) then
                    trinketAbsorb1 = 24600
                    addAbsorbQueue("Затвердевшая кожа")
                end
            end

            if (arg10 == "Железное сердце") then
                trinketAbsorb2[1] = 5000
                trinketAbsorb2[2] = 1250
                addAbsorbQueue("Железное сердце")
            end

            if (arg10 == "Пелена лжи") then
                addAbsorbQueue("Пелена лжи")
            end

            if (arg10 == "Стойкая преграда") then
                local itemId = {[1] = GetInventoryItemID("player", 13), [2] = GetInventoryItemID("player", 14)}
                for i = 1, 2 do
                    local itemName = GetItemInfo(itemId[i])
                    if (itemName == "Расколотое солнце") then itemId[0] = itemId[i] end
                end
                if (itemId[0] == 154412 or itemId[0] == 154417 or itemId[0] == 154422) then
                    trinketAbsorb4 = 3660
                elseif (itemId[0] == 154411 or itemId[0] == 154416 or itemId[0] == 154421) then
                    trinketAbsorb4 = 3240
                elseif (itemId[0] == 154410 or itemId[0] == 154415 or itemId[0] == 154420) then
                end
                addAbsorbQueue("Стойкая преграда")
            end
        end

        if (subevent == "SPELL_AURA_REMOVED" and name == playerName) then
            if (arg10 == "Затвердевшая кожа") then
                trinketAbsorb1 = 0
                removeAbsorbQueue("Затвердевшая кожа")
            end

            if (arg10 == "Железное сердце") then
                trinketAbsorb2[1] = 0
                trinketAbsorb2[2] = 0
                removeAbsorbQueue("Железное сердце")
            end

            if (arg10 == "Пелена лжи") then
                trinketAbsorb3 = 0
                removeAbsorbQueue("Пелена лжи")
            end

            if (arg10 == "Стойкая преграда") then
                trinketAbsorb4 = 0
                removeAbsorbQueue("Стойкая преграда")
            end
        end

        if (subevent == "SWING_MISSED" and arg7 == playerName and arg9 == "ABSORB") then
            removeAbsorb(arg10, subevent, _, _) -- arg10 - Absorbed damage
        end
        if (subevent == "SPELL_MISSED" and arg7 == playerName and arg12 == "ABSORB") then
            removeAbsorb(arg13, subevent, arg11, _) -- arg13 Absorbed damage, arg11 School damage
        end
        if (subevent == "SPELL_PERIODIC_MISSED" and arg7 == playerName and arg12 == "ABSORB") then
            removeAbsorb(arg13, subevent, arg11, _) -- arg13 Absorbed damage, arg11 School damage
        end

        if (currentSpec == "Frost" and T5 >= 2) then
            
            if (subevent == "SPELL_AURA_REMOVED" and name == playerName) then
                if (arg10 == "Ледяной доспех") then -- arg10 = Spell Name
                    if (hideIfNoBuff) then absF:Hide() end
                    removeAbsorb(currentAbsorb+1, "", "", _)
                    removeAbsorbQueue("Ледяной доспех")
                    removeTimer()
                end
            end

            if (subevent == "SPELL_AURA_APPLIED" and name == playerName) then
                if (arg10 == "Ледяной доспех") then -- arg10 = Spell Name
                    tempF:SetScript("OnUpdate", nil)
                    addAbsorbQueue("Ледяной доспех")
                    setTimer(arg10)
                    if (displayMode == 1) then
                        absF.Text:SetText(math.floor(currentAbsorb))
                        absF.Text:SetTextColor(0,.9,1,1)
                    elseif (displayMode == 2 or displayMode == 3) then
                        absF.Text:SetText("("..math.floor(currentAbsorb)..")")
                        absF.Text:SetTextColor(0,.9,1,1)
                    elseif (displayMode == 4) then
                        absF.Text:SetText(UnitHealth("player") + math.floor(currentAbsorb))
                        absF.Text:SetTextColor(0,.9,1,1)
                    end
                end
            end

            if (subevent == "SPELL_DAMAGE" and name == playerName) then
                if (arg10 == "Ледяной удар") then -- arg10 = Spell Name
                    if (arg12 >= 0) then -- arg12 = damage
                        if (hideIfNoBuff) then absF:Show() end
                        local buffName = UnitBuff("player", "Власть льда")
                        if (buffName ~= nil) then
                            addAbsorbFdk(arg12)
                            fixBugWithFdkAbsorb(GetTime())
                        end
                    end
                end
            end
        end

        if (currentSpec == "Blood" and T5 == 4) then

            if (subevent == "SPELL_AURA_REMOVED" and name == playerName) then
                if (arg10 == "Кровавый щит") then -- arg10 = Spell Name
                    if (hideIfNoBuff) then absF:Hide() end
                    removeAbsorb(currentAbsorb+1, "", "", _)
                    removeAbsorbQueue("Кровавый щит")
                    removeTimer()
                end
            end

            if (subevent == "SPELL_AURA_APPLIED" and name == playerName) then
                if (arg10 == "Кровавый щит") then -- arg10 = Spell Name
                    setTimer(arg10)
                    addAbsorbQueue("Кровавый щит")
                end
            end

            if (subevent == "SPELL_DAMAGE" and name == playerName) then
                if (arg10 == "Удар смерти") then -- arg10 = Spell Name
                    if (hideIfNoBuff) then absF:Show() end
                    local buffName = UnitBuff("player", "Власть льда")
                    if (buffName ~= nil) then
                        local buffName2 = UnitBuff("player", "Гемостаз")
                        if (buffName2 ~= nil) then addAbsorbBdk() end
                    end
                end
            end
        end

        if (currentSpec == "PaladinProt" and T5 == 4) then
            if (subevent == "SPELL_AURA_REMOVED" and name == playerName) then
                if (arg10 == "Барьер света") then -- arg10 = Spell Name
                    if (hideIfNoBuff) then absF:Hide() end
                    removeAbsorb(currentAbsorb+1, "", "", _)
                    removeAbsorbQueue("Барьер света")
                    removeTimer()
                end
            end

            if (subevent == "SPELL_AURA_APPLIED" and name == playerName) then
                if (arg10 == "Барьер света") then -- arg10 = Spell Name
                    setTimer(arg10)
                    addAbsorbQueue("Барьер света")
                end
            end

            if (subevent == "SPELL_DAMAGE" and name == playerName) then
                if (arg10 == "Щит праведности") then -- arg10 = Spell Name
                    if (hideIfNoBuff) then absF:Show() end
                    local buffName, _, _, buffStacks = UnitBuff("player", "Бастион праведности")
                    if (buffName ~= nil) then
                        addAbsorbProtoPaladin(buffStacks)
                    end
                end
            end
        end

        -- if (currentSpec == "DruidProt" and T5 >= 2) then
        --     if (subevent == "SPELL_AURA_REMOVED" and name == playerName) then
        --         if (arg10 == "Дикая защита") then -- arg10 = Spell Name
        --             if (hideIfNoBuff) then absF:Hide() end
        --             removeAbsorb(currentAbsorb+1, "", "", _)
        --             removeAbsorbQueue("Дикая защита")
        --             removeTimer()
        --         end
        --     end

        --     if (subevent == "SPELL_AURA_APPLIED" and name == playerName) then
        --         if (arg10 == "Дикая защита") then -- arg10 = Spell Name
        --             setTimer(arg10)
        --             addAbsorbQueue("Дикая защита")
        --         end
        --     end

        --     local baffName = UnitBuff("player", "Облик лютого медведя")
        --     if (baffName ~= nil) then

        --         if (subevent == "SWING_DAMAGE" and name == playerName and arg15 == 1) then -- arg15 = crit
        --             if (hideIfNoBuff) then absF:Show() end
        --             addAbsordProtoDruid()
        --         end

        --         if (subevent == "SPELL_DAMAGE" and name == playerName and arg18 == 1) then -- arg18 = crit
        --             if (hideIfNoBuff) then absF:Show() end
        --             addAbsordProtoDruid()
        --         end

        --         if (subevent == "SPELL_PERIODIC_DAMAGE" and name == playerName and arg18 == 1) then
        --             if (hideIfNoBuff) then absF:Show() end
        --             addAbsordProtoDruid()
        --         end
        --     end
        -- end
    end)

    specChangeF:SetScript("OnEvent", function ()
        specCheck()
        howManyT5(currentSpec)
        removeAbsorb(currentAbsorb+1, "", "", _)
        removeTimer()

        if (displayMode == 1 or displayMode == 4) then
            if (currentSpec == "Frost" and currentAbsorb > 0) then
                absF.Text:SetTextColor(0,.9,1,1)
            elseif (currentSpec == "Blood" and currentAbsorb > 0) then
                absF.Text:SetTextColor(1,.1,.1,1)
            elseif (currentSpec == "DruidProt" and currentAbsorb > 0) then
                absF.Text:SetTextColor(1,.4,0,1)
            elseif (currentSpec == "PaladinProt" and currentAbsorb > 0) then
                absF.Text:SetTextColor(.9,.2,.7,1)
            else
                absF.Text:SetTextColor(1,1,1,1)
            end
        elseif (displayMode == 2 or displayMode == 3) then
            if (currentSpec == "Frost") then
                absF.Text:SetTextColor(0,.9,1,1)
            elseif (currentSpec == "Blood") then
                absF.Text:SetTextColor(1,.1,.1,1)
            elseif (currentSpec == "DruidProt") then
                absF.Text:SetTextColor(1,.4,0,1)
            elseif (currentSpec == "PaladinProt") then
                absF.Text:SetTextColor(.9,.2,.7,1)
            end
        end
    end)
end

SlashCmdList.ABST5 = function(msg, editBox)

    if (optionsF:IsShown()) then
        optionsF:Hide()
    else
        optionsF:Show()
    end
end

SLASH_ABST51 = "/at5"
SLASH_ABST52 = "/abst5"
SLASH_ABST53 = "/absorbt5"

path = "objects.xml"

--TASTI
--MOVING ON AXIS
--SCRIVERE ALLA STESSA MANIERA O CREA BUG SU SALVATAGGIO POSIZIONE OGGETTI
actionKeys = {
    ["arrow_u"] = "arrow_u",
    ["arrow_d"] = "arrow_d",
    ["arrow_l"] = "arrow_l",
    ["arrow_r"] = "arrow_r",
    ["num_0"] = "num_0",
    ["num_1"] = "num_1",
    ["num_2"] = "num_2",
    ["num_3"] = "num_3",
    ["num_4"] = "num_4",
    ["num_5"] = "num_5",
    ["num_6"] = "num_6",
    ["num_8"] = "num_8",
    ["num_9"] = "num_9",
    ["num_add"] = "num_add",
    ["num_sub"] = "num_sub",
    ["num_dec"] = "num_dec",
    ["pgup"] = "pgup",
    ["pgdn"] = "pgdn",
}

--ACTIVE OBJECTS
active = "[✔]"
inactive = "[✘]"

--VARIABILI GLOBALI
isEditing = false
isWindowsOpen = false

--OBJECT CONTAINER
groupTable = {}
subgroupTable = {}
objectTable = {}

--UTILS
rootRow = 0

GUIEditor = {
    checkbox = {},
    staticimage = {},
    edit = {},
    window = {},
    tabpanel = {},
    button = {},
    label = {},
    tab = {},
    gridlist = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(21, 172, 664, 396, "Posiziona Oggetti [F6]", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetProperty(GUIEditor.window[1], "CaptionColour", "FF00F75D")

        GUIEditor.tabpanel[1] = guiCreateTabPanel(16, 31, 239, 351, false, GUIEditor.window[1])

        GUIEditor.tab[1] = guiCreateTab("Oggetti", GUIEditor.tabpanel[1])

        GUIEditor.gridlist[1] = guiCreateGridList(0, 0, 239, 326, false, GUIEditor.tab[1])
        guiGridListAddColumn(GUIEditor.gridlist[1], "ID", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[1], "NOME", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[1], "ATTIVO", 0.3)

        GUIEditor.tab[2] = guiCreateTab("Veicoli", GUIEditor.tabpanel[1])

        GUIEditor.gridlist[2] = guiCreateGridList(0, 0, 239, 326, false, GUIEditor.tab[2])
        guiGridListAddColumn(GUIEditor.gridlist[2], "ID", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[2], "NOME", 0.3)
        guiGridListAddColumn(GUIEditor.gridlist[2], "ATTIVO", 0.3)


        GUIEditor.edit[1] = guiCreateEdit(295, 60, 49, 21, "", false, GUIEditor.window[1])
        GUIEditor.edit[2] = guiCreateEdit(348, 60, 49, 21, "", false, GUIEditor.window[1])
        GUIEditor.edit[3] = guiCreateEdit(401, 60, 49, 21, "", false, GUIEditor.window[1])
        GUIEditor.edit[4] = guiCreateEdit(454, 60, 49, 21, "", false, GUIEditor.window[1])
        GUIEditor.edit[5] = guiCreateEdit(508, 60, 49, 21, "", false, GUIEditor.window[1])
        GUIEditor.edit[6] = guiCreateEdit(561, 60, 49, 21, "", false, GUIEditor.window[1])
        GUIEditor.checkbox[1] = guiCreateCheckBox(273, 149, 74, 25, "Collisione", false, false, GUIEditor.window[1])
        GUIEditor.button[1] = guiCreateButton(334, 113, 28, 26, "+", false, GUIEditor.window[1])
        GUIEditor.button[2] = guiCreateButton(273, 113, 28, 26, "-", false, GUIEditor.window[1])
        GUIEditor.label[1] = guiCreateLabel(305, 117, 26, 18, "1", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[1], "center", false)
        guiLabelSetVerticalAlign(GUIEditor.label[1], "center")
        GUIEditor.label[2] = guiCreateLabel(301, 90, 33, 17, "SCALE", false, GUIEditor.window[1])
        GUIEditor.label[3] = guiCreateLabel(298, 43, 36, 17, "X", false, GUIEditor.window[1])
        GUIEditor.label[4] = guiCreateLabel(351, 43, 36, 17, "Y", false, GUIEditor.window[1])
        GUIEditor.label[5] = guiCreateLabel(404, 43, 36, 17, "Z", false, GUIEditor.window[1])
        GUIEditor.label[6] = guiCreateLabel(457, 43, 36, 17, "Rot. X", false, GUIEditor.window[1])
        GUIEditor.label[7] = guiCreateLabel(511, 43, 36, 17, "Rot. Y", false, GUIEditor.window[1])
        GUIEditor.label[8] = guiCreateLabel(564, 43, 36, 17, "Rot. Z", false, GUIEditor.window[1])
        GUIEditor.button[3] = guiCreateButton(341, 90, 16, 17, "?", false, GUIEditor.window[1])
        GUIEditor.button[4] = guiCreateButton(372, 89, 123, 24, "Teleport To Object", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[4], "NormalTextColour", "FF2BDEFF")
        GUIEditor.button[5] = guiCreateButton(372, 115, 123, 24, "Teleport Object Here", false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.button[5], "NormalTextColour", "FF26F788")
        GUIEditor.checkbox[2] = guiCreateCheckBox(273, 175, 88, 25, "Visible", true, false, GUIEditor.window[1])
        GUIEditor.tabpanel[2] = guiCreateTabPanel(262, 204, 240, 182, false, GUIEditor.window[1])

        GUIEditor.tab[3] = guiCreateTab("Oggetti", GUIEditor.tabpanel[2])

        GUIEditor.gridlist[3] = guiCreateGridList(0, 0, 240, 158, false, GUIEditor.tab[3])
        guiGridListAddColumn(GUIEditor.gridlist[3], "ID", 0.5)
        guiGridListAddColumn(GUIEditor.gridlist[3], "NOME", 0.5)

        GUIEditor.tab[4] = guiCreateTab("Veicoli", GUIEditor.tabpanel[2])

        GUIEditor.gridlist[4] = guiCreateGridList(0, 0, 240, 158, false, GUIEditor.tab[4])
        guiGridListAddColumn(GUIEditor.gridlist[4], "ID", 0.5)
        guiGridListAddColumn(GUIEditor.gridlist[4], "NOME", 0.5)


        GUIEditor.label[9] = guiCreateLabel(512, 233, 142, 143, "", false, GUIEditor.window[1])
        guiLabelSetHorizontalAlign(GUIEditor.label[9], "left", true)
        GUIEditor.staticimage[1] = guiCreateStaticImage(502, 89, 140, 140, "pic/gtanomalylogo.png", false, GUIEditor.window[1])


        GUIEditor.window[2] = guiCreateWindow(1014, 280, 246, 119, "SCALE INFO", false)
        guiWindowSetSizable(GUIEditor.window[2], false)
        guiSetAlpha(GUIEditor.window[2], 1.00)
        guiSetProperty(GUIEditor.window[2], "CaptionColour", "FF82F506")

        GUIEditor.label[10] = guiCreateLabel(10, 26, 226, 61, "Quando si cambia la scala di un oggetto, si modifica soltanto la grandezza della sua skin, ma le sue collisioni restano delle dimensioni originali!!!", false, GUIEditor.window[2])
        guiLabelSetHorizontalAlign(GUIEditor.label[10], "center", true)
        GUIEditor.button[6] = guiCreateButton(10, 87, 226, 22, "CHIUDI", false, GUIEditor.window[2])
        guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFFD2B2B")  

        -- fillObjectListXml()
        fillObjectList()
        fillVehicleList()

        guiSetVisible(GUIEditor.window[1], false)
        guiSetVisible(GUIEditor.window[2], false)
        addEventHandler("onClientGUIClick", GUIEditor.button[3], scaleInfo, false)
        addEventHandler("onClientGUIClick", GUIEditor.button[6], scaleInfo, false)
        addEventHandler("onClientGUIDoubleClick", GUIEditor.gridlist[1], spawnObject, false)
        addEventHandler("onClientKey", root, updatePosWithKeys, false)
        addEventHandler("onClientGUIClick", GUIEditor.checkbox[1], updateCollision, false)
        addEventHandler("onClientGUIClick", GUIEditor.checkbox[2], updateVisibility, false)
        addEventHandler("onClientGUIChanged", GUIEditor.edit[1], updateWhitEdit, false)
        addEventHandler("onClientGUIChanged", GUIEditor.edit[2], updateWhitEdit, false)
        addEventHandler("onClientGUIChanged", GUIEditor.edit[3], updateWhitEdit, false)
        addEventHandler("onClientGUIChanged", GUIEditor.edit[4], updateWhitEdit, false)
        addEventHandler("onClientGUIChanged", GUIEditor.edit[5], updateWhitEdit, false)
        addEventHandler("onClientGUIChanged", GUIEditor.edit[6], updateWhitEdit, false)

        
    end
)

-- function fillObjectListXml()
--     local xmlRoot = xmlLoadFile(path)
--     if not xmlRoot then return end
--     local groups = xmlNodeGetChildren(xmlRoot)
--     for i=1, #groups do
--         local getSubgroups = xmlNodeGetChildren(xmlRoot, i-1)
--         local subgroups = xmlNodeGetChildren(getSubgroups)
--         groupTable[i] = ("+ "..xmlNodeGetAttribute(groups[i], "name"))
--         if not subgroups then
--             local objects = xmlNodeGetChildren(groups[i], i-1)
--             for i=1, #objects do
--                 local id = xmlNodeGetAttribute(objects[i], "model")
--                 local name = xmlNodeGetAttribute(objects[i], "name")
--                 table.insert(objectTable, {id, name, inactive})
--             end
--         else
--             for n=1, #subgroups do
--                 local getObjects = xmlNodeGetChildren(subgroups[i], i-1)
--                 subgroupTable[i] = ("+ "..xmlNodeGetAttribute(subgroups[i], "name"))
--                 if not getObjects then break end
--                 objects = xmlNodeGetChildren(getObjects)
--                 for i=1, #objects do
--                     local id = xmlNodeGetAttribute(objects[i], "model")
--                     local name = xmlNodeGetAttribute(objects[i], "name")
--                     table.insert(objectTable, {id, name, inactive})
--                 end
--             end
--         end
--     end

--     for i=1, #groupTable do
--         guiGridListAddRow(GUIEditor.gridlist[1], groupTable[i])

--     end
--     xmlUnloadFile(xmlRoot)
-- end

function fillObjectList()
    guiGridListClear(GUIEditor.gridlist[1])
    for i=1, #objects do
        guiGridListAddRow(GUIEditor.gridlist[1], objects[i][1], objects[i][2], objects[i][3])
        if objects[i][3] == inactive then
            guiGridListSetItemColor(GUIEditor.gridlist[1], i-1, 3, 255, 0, 0)
        else
            guiGridListSetItemColor(GUIEditor.gridlist[1], i-1, 3, 255, 255, 255)
        end
    end
end

function fillVehicleList()
    guiGridListClear(GUIEditor.gridlist[2])
    guiGridListAddRow(GUIEditor.gridlist[2], "Aerei")
    guiGridListSetItemText(GUIEditor.gridlist[2], 0, 1, "Aerei", true, false)
    for i=1, #vehicles.airplanes do 
        guiGridListAddRow(GUIEditor.gridlist[2], vehicles.airplanes[i][1], vehicles.airplanes[i][2], vehicles.airplanes[i][3])
        if vehicles.airplanes[i][3] == inactive then
            guiGridListSetItemColor(GUIEditor.gridlist[2], i, 3, 255, 0, 0)
        else
            guiGridListSetItemColor(GUIEditor.gridlist[2], i, 3, 255, 255, 255)
        end
    end

    for i=1, #vehicles.helicopters do 
        guiGridListAddRow(GUIEditor.gridlist[2], vehicles.helicopters[i][1], vehicles.helicopters[i][2], vehicles.helicopters[i][3])
        if vehicles.helicopters[i][3] == inactive then
            guiGridListSetItemColor(GUIEditor.gridlist[2], i, 3, 255, 0, 0)
        else
            guiGridListSetItemColor(GUIEditor.gridlist[2], i, 3, 255, 255, 255)
        end
    end
    
    guiGridListSetItemText(GUIEditor.gridlist[2], guiGridListAddRow(GUIEditor.gridlist[2], "Elicotteri"), 1, "Elicotteri", true, false)
    --TODO: riempire con lista veicoli
end

function scaleInfo()
    guiSetVisible(GUIEditor.window[2], not guiGetVisible(GUIEditor.window[2]))
end

addEventHandler("onClientRender", root, 
function()
    --DATI PG
    x, y, z = getElementPosition(localPlayer)
    rotX, rotY, rotZ = getElementRotation(localPlayer)
    currentDimension = getElementDimension(localPlayer)
    currentInterior = getElementInterior(localPlayer)
    guiSetText(GUIEditor.label[9], "X: "..math.floor(x).."\nY: "..math.floor(y).."\nZ: "..math.floor(z).."\nRot. X: "..math.floor(rotX).."\nRot. Y: "..math.floor(rotY).."\nRot. Z: "..math.floor(rotZ).."\nDimension: "..currentDimension.."\nInterior: "..currentInterior.."")
end)

function openDialog(btn, press)
    if not press then return end
    if btn == "F6" then
        guiSetVisible(GUIEditor.window[1], not guiGetVisible(GUIEditor.window[1]))
        isWindowsOpen = guiGetVisible(GUIEditor.window[1])
        showCursor(isWindowsOpen)
    end
end
addEventHandler("onClientKey", root, openDialog)

function updateCollision()
    if not isWindowsOpen then return end
    local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
    if guiGridListGetItemText(GUIEditor.gridlist[1], row, 1) == inactive then return end
    if row == -1 or col == -1 then return end
    local itemID = guiGridListGetItemText(GUIEditor.gridlist[1], row, 1)
    local newCol = guiCheckBoxGetSelected(GUIEditor.checkbox[1])
    triggerServerEvent("updatingCollision", localPlayer, itemID, newCol)
end

function updateVisibility()
    if not isWindowsOpen then return end
    local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
    if guiGridListGetItemText(GUIEditor.gridlist[1], row, 1) == inactive then return end
    if row == -1 or col == -1 then return end
    local itemID = guiGridListGetItemText(GUIEditor.gridlist[1], row, 1)
    local newVis = guiCheckBoxGetSelected(GUIEditor.checkbox[2])
    triggerServerEvent("updatingVisibility", localPlayer, itemID, newVis and 255 or 0)
end

function updateWhitEdit()
    if not isWindowsOpen then return end
    local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
    if guiGridListGetItemText(GUIEditor.gridlist[1], row, 1) == inactive then return end
    if row == -1 or col == -1 then return end
    local itemID = guiGridListGetItemText(GUIEditor.gridlist[1], row, 1)
    local newParameters = {tonumber(guiGetText(GUIEditor.edit[1])), tonumber(guiGetText(GUIEditor.edit[2])), tonumber(guiGetText(GUIEditor.edit[3])), tonumber(guiGetText(GUIEditor.edit[4])), tonumber(guiGetText(GUIEditor.edit[5])), tonumber(guiGetText(GUIEditor.edit[6]))}
    outputDebugString(inspect(newParameters))
    if tonumber(guiGetText(GUIEditor.edit[1])) and tonumber(guiGetText(GUIEditor.edit[2])) and tonumber(guiGetText(GUIEditor.edit[3])) and tonumber(guiGetText(GUIEditor.edit[4])) and tonumber(guiGetText(GUIEditor.edit[5])) and tonumber(guiGetText(GUIEditor.edit[6])) then
        triggerServerEvent("updateWithEdit", localPlayer, itemID, newParameters)
    end
end

function updatePosWithKeys(btn, press)
    if not isWindowsOpen then return end
    if not actionKeys[btn] then return end
    if not press then return end
    local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
    if guiGridListGetItemText(GUIEditor.gridlist[1], row, 1) == inactive then return end
    if row == -1 or col == -1 then return end
    local itemID = guiGridListGetItemText(GUIEditor.gridlist[1], row, 1)
    if not tonumber(itemID) then return end
    local newParameters = {0, 0, 0, 0, 0, 0, 0}
    if btn == "arrow_l" then
        if getKeyState("lshift") then
            newParameters[1] = newParameters[1] - 0.1
        else
            newParameters[1] = newParameters[1] - 0.01
        end
    elseif btn == "arrow_r" then
        if getKeyState("lshift") then
            newParameters[1] = newParameters[1] + 0.1
        else
            newParameters[1] = newParameters[1] + 0.01
        end
    elseif btn == "arrow_u" then
        if getKeyState("lshift") then
            newParameters[2] = newParameters[2] + 0.1
        else
            newParameters[2] = newParameters[2] + 0.01
        end
    elseif btn == "arrow_d" then
        if getKeyState("lshift") then
            newParameters[2] = newParameters[2] - 0.1
        else
            newParameters[2] = newParameters[2] - 0.01
        end
    elseif btn == "pgup" then
        if getKeyState("lshift") then
            newParameters[3] = newParameters[3] + 0.1
        else
            newParameters[3] = newParameters[3] + 0.01
        end
    elseif btn == "pgdn" then
        if getKeyState("lshift") then
            newParameters[3] = newParameters[3] - 0.1
        else
            newParameters[3] = newParameters[3] - 0.01
        end
    elseif btn == "num_4" then
        if getKeyState("lshift") then
            newParameters[4] = newParameters[4] + 1
        else
            newParameters[4] = newParameters[4] + 0.2
        end
    elseif btn == "num_6" then
        if getKeyState("lshift") then
            newParameters[4] = newParameters[4] - 1
        else
            newParameters[4] = newParameters[4] - 0.2
        end
    elseif btn == "num_9" then
        if getKeyState("lshift") then
            newParameters[5] = newParameters[5] + 1
        else
            newParameters[5] = newParameters[5] + 0.2
        end
    elseif btn == "num_3" then
        if getKeyState("lshift") then
            newParameters[5] = newParameters[5] - 1
        else
            newParameters[5] = newParameters[5] - 0.01
        end
    elseif btn == "num_0" then
        if getKeyState("lshift") then
            newParameters[6] = newParameters[6] - 1
        else
            newParameters[6] = newParameters[6] - 0.2
        end
    elseif btn == "num_dec" then
        if getKeyState("lshift") then
            newParameters[6] = newParameters[6] + 1
        else
            newParameters[6] = newParameters[6] + 0.2
        end
    elseif btn == "num_add" then
        if getKeyState("lshift") then
            newParameters[7] = newParameters[7] + 0.1
        else
            newParameters[7] = newParameters[7] + 0.01
        end
    elseif btn == "num_sub" then
        if getKeyState("lshift") then
            newParameters[7] = newParameters[7] - 0.1
        else
            newParameters[7] = newParameters[7] - 0.01
        end
    end

    triggerServerEvent("onUpdatingObject", localPlayer, tostring(itemID), newParameters)

end

function spawnObject()
    if not isWindowsOpen then return end
    local row, col = guiGridListGetSelectedItem(GUIEditor.gridlist[1])
    if row == -1 or col == -1 then return end
    local itemID = guiGridListGetItemText(GUIEditor.gridlist[1], row, 1)
    if not tonumber(itemID) then return end
    outputDebugString("ID: "..itemID)
    if guiGridListGetItemText(GUIEditor.gridlist[1], row, 3) == inactive then
        guiGridListSetItemText(GUIEditor.gridlist[1], row, 3, active, false, false)
        guiGridListSetItemColor(GUIEditor.gridlist[1], row, 3, 0, 255, 0)
        triggerServerEvent("onCreatingObject", localPlayer, tostring(itemID), x, y, z, rotX, rotY, rotZ, currentDimension, currentInterior, false, 255)
    else
        for i=1, 6 do
            guiSetText(GUIEditor.edit[i], 0)
        end
        guiGridListSetItemText(GUIEditor.gridlist[1], row, 3, inactive, false, false)
        guiGridListSetItemColor(GUIEditor.gridlist[1], row, 3, 255, 0, 0)
        triggerServerEvent("onDestroyObject", localPlayer, tostring(itemID))
    end
end

function updateData (objectData)
    outputDebugString(inspect(objectData))
    guiSetText(GUIEditor.edit[1], objectData[1])
    guiSetText(GUIEditor.edit[2], objectData[2])
    guiSetText(GUIEditor.edit[3], objectData[3])
    guiSetText(GUIEditor.edit[4], objectData[4])
    guiSetText(GUIEditor.edit[5], objectData[5])
    guiSetText(GUIEditor.edit[6], objectData[6])
    guiSetText(GUIEditor.label[1], objectData[7])
end
addEvent("clientUpdateData", true)
addEventHandler("clientUpdateData", getRootElement(), updateData)
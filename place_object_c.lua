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
}

--ROTATION
ruotaDestra = "num_6"
ruotaSinistra = "num_4"

--SCALE
scalaInc = "num_9"
scaleDec = "num_3"


--VARIABILI GLOBALI
isEditing = false
isWindowsOpen = false



GUIEditor = {
    tab = {},
    label = {},
    tabpanel = {},
    edit = {},
    gridlist = {},
    window = {},
    checkbox = {},
    button = {}
}
addEventHandler("onClientResourceStart", resourceRoot,
    function()
        GUIEditor.window[1] = guiCreateWindow(21, 172, 664, 396, "Posiziona Oggetti [F6]", false)
        guiWindowSetSizable(GUIEditor.window[1], false)
        guiSetProperty(GUIEditor.window[1], "Tooltip", "Finestra Diarrea")
        guiSetProperty(GUIEditor.window[1], "CaptionColour", "FF00F75D")
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
        guiSetProperty(GUIEditor.checkbox[1], "HoverTextColour", "FFFCF803")
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
        GUIEditor.checkbox[2] = guiCreateCheckBox(273, 175, 88, 25, "Visible", false, false, GUIEditor.window[1])
        guiSetProperty(GUIEditor.checkbox[2], "HoverTextColour", "FFFCF803")
        GUIEditor.tabpanel[2] = guiCreateTabPanel(262, 204, 240, 182, false, GUIEditor.window[1])

        GUIEditor.tab[3] = guiCreateTab("Oggetti", GUIEditor.tabpanel[2])

        GUIEditor.gridlist[3] = guiCreateGridList(0, 0, 240, 158, false, GUIEditor.tab[3])
        guiGridListAddColumn(GUIEditor.gridlist[3], "ID", 0.5)
        guiGridListAddColumn(GUIEditor.gridlist[3], "NOME", 0.5)

        GUIEditor.tab[4] = guiCreateTab("Veicoli", GUIEditor.tabpanel[2])

        GUIEditor.gridlist[4] = guiCreateGridList(0, 0, 240, 158, false, GUIEditor.tab[4])
        guiGridListAddColumn(GUIEditor.gridlist[4], "ID", 0.5)
        guiGridListAddColumn(GUIEditor.gridlist[4], "NOME", 0.5)


        GUIEditor.window[2] = guiCreateWindow(1014, 280, 246, 119, "SCALE INFO", false)
        guiWindowSetSizable(GUIEditor.window[2], false)
        guiSetAlpha(GUIEditor.window[2], 1.00)
        guiSetProperty(GUIEditor.window[2], "Visible", "False")
        guiSetProperty(GUIEditor.window[2], "ClippedByParent", "False")
        guiSetProperty(GUIEditor.window[2], "SizingBorderThickness", "10.000000")
        guiSetProperty(GUIEditor.window[2], "AlwaysOnTop", "True")
        guiSetProperty(GUIEditor.window[2], "CaptionColour", "FF82F506")

        GUIEditor.label[9] = guiCreateLabel(10, 26, 226, 61, "Quando si cambia la scala di un oggetto, si modifica soltanto la grandezza della sua skin, ma le sue collisioni restano delle dimensioni originali!!!", false, GUIEditor.window[2])
        guiLabelSetHorizontalAlign(GUIEditor.label[9], "center", true)
        GUIEditor.button[6] = guiCreateButton(10, 87, 226, 22, "CHIUDI", false, GUIEditor.window[2])
        guiSetProperty(GUIEditor.button[6], "NormalTextColour", "FFFD2B2B")    
    end
)


function openDialog(btn, press)
    if not press then return end
    if btn == "F6" then
        guiSetVisible(GUIEditor.window[1], not guiGetVisible(GUIEditor.window[1]))
        isWindowsOpen = guiGetVisible(GUIEditor.window[1])
    end
end
addEventHandler("onClientKey", root, openDialog)
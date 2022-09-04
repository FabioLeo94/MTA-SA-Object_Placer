objectList = {}

function sendDataToClient(itemID)
    local x, y, z = getElementPosition(objectList[tostring(itemID)])
    local rx, ry, rz = getElementRotation(objectList[tostring(itemID)])
    local scale = getObjectScale(objectList[tostring(itemID)])
    local col = getElementCollisionsEnabled(objectList[tostring(itemID)])
    local vis = getElementAlpha(objectList[tostring(itemID)])
    local param = {x, y, z, rx, ry, rz, scale, col, vis}
    triggerClientEvent(root, "clientUpdateData", getRootElement(), param)
end

function spawnObject(itemID, x, y, z, rx, ry, rz, dim, int, col, vis)
    local myObj = createObject(itemID, x, y, z, rx, ry, rz)
    objectList[tostring(itemID)] = myObj
    setElementDimension(myObj, tonumber(dim))
    setElementInterior(myObj, tonumber(int))
    setElementCollisionsEnabled(objectList[tostring(itemID)], col)
    setElementAlpha(objectList[tostring(itemID)], vis)
    sendDataToClient(itemID)
end

function destroyObject(itemID)
    if objectList[tostring(itemID)] then
        destroyElement(objectList[tostring(itemID)])
        objectList[tostring(itemID)] = nil
    end
end

function updateObject(itemID,newParameter)
    local ox, oy, oz = getElementPosition(objectList[tostring(itemID)])
    local orx, ory, orz = getElementRotation(objectList[tostring(itemID)])
    local oscale = getObjectScale(objectList[tostring(itemID)])
    setElementPosition(objectList[tostring(itemID)], ox+newParameter[1], oy+newParameter[2], oz+newParameter[3])
    setElementRotation(objectList[tostring(itemID)], orx+newParameter[4], ory+newParameter[5], orz+newParameter[6])
    setObjectScale(objectList[tostring(itemID)], oscale+newParameter[7])
    sendDataToClient(itemID)
end

function updateCollision(itemID, newCollision)
    setElementCollisionsEnabled(objectList[tostring(itemID)], newCollision)
    sendDataToClient(itemID)
end

function updateVisibility(itemID, newVisibility)
    setElementAlpha(objectList[tostring(itemID)], newVisibility)
    sendDataToClient(itemID)
end

function setNewParameters(itemID, newPar)
    setElementPosition(objectList[tostring(itemID)], newPar[1], newPar[2], newPar[3])
    setElementRotation(objectList[tostring(itemID)], newPar[4], newPar[5], newPar[6])
end

addEvent("onCreatingObject", true)
addEvent("onDestroyObject", true)
addEvent("onUpdatingObject", true)
addEvent("updatingCollision", true)
addEvent("updatingVisibility", true)
addEvent("updateWithEdit", true)
addEventHandler("onCreatingObject", root, spawnObject)
addEventHandler("onDestroyObject", root, destroyObject)
addEventHandler("onUpdatingObject", root, updateObject)
addEventHandler("updatingCollision", root, updateCollision)
addEventHandler("updatingVisibility", root, updateVisibility)
addEventHandler("updateWithEdit", root, setNewParameters)
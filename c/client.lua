local idcardData = false
local cam = 0
local currentCamPosition = nil
local movements = {}
local movements2 = {}
local creating = false
local function createPrompts(keysTable, prompts)
    local array = {}
    for _, keyData in pairs(keysTable) do
        local str = "TEST"
        local movement = PromptRegisterBegin() 
        PromptSetControlAction(movement, keyData[2])
        str = CreateVarString(10, 'LITERAL_STRING', keyData[1])
        PromptSetText(movement, str)
        PromptSetEnabled(movement, 1)
        PromptSetVisible(movement, 1)
        PromptSetStandardMode(movement, 1)
        PromptSetGroup(movement, prompts)
        Citizen.InvokeNative(0xC5F428EE08FA7F2C, movement, true)
        PromptRegisterEnd(movement)
        table.insert(array, movement) 
        PromptSetHoldMode(movement, 500)
    end
    return array
end

local prompts = GetRandomIntInRange(0, 0xffffff)
local prompts2 = GetRandomIntInRange(0, 0xffffff)

local keysTable = {
    {Locale("takephoto"), Config.Keybinds["takephoto"]},
    {Locale("printphoto"), Config.Keybinds["printphoto"]},
    {Locale("exit"), Config.Keybinds["exit"]},
    {Locale("camUp"), Config.Keybinds["camUp"]},
    {Locale("camDown"), Config.Keybinds["camDown"]},
    {Locale("camLeft"), Config.Keybinds["camLeft"]},
    {Locale("camRight"), Config.Keybinds["camRight"]},
    {Locale("camForward"), Config.Keybinds["camForward"]},
    {Locale("camBack"), Config.Keybinds["camBack"]},
}

local keysTable2 = {
    {Locale("takeidcard"), Config.Keybinds["takeidcard"]},
}

Citizen.CreateThread(function()
    Citizen.Wait(10)
    movements = createPrompts(keysTable, prompts)
    movements2 = createPrompts(keysTable2, prompts2)
end)

RegisterNUICallback('close',function()
    SetNuiFocus(false,false)
    AnimpostfxStop("OJDominoBlur")
    Config.ShowHud()
    creating = false
end)
RegisterNUICallback('notify',function(data)
    Notify({
        text = Locale(data.text),
        type = "error",
        time = 4000
    })
end)
RegisterNUICallback('print',function(data)
    SetNuiFocus(false,false)
    if data.imgLink then
        TriggerServerEvent('fx-idcard:server:print', data.imgLink)
    end
end)

RegisterNetEvent('fx-idcard:client:setData',function(data)
    idcardData = data
end)

RegisterNUICallback('createIdCard',function(data)
   TriggerServerEvent('fx-idcard:server:buyIdCard',data)
end)

function GetClosestPlayer()
    local players, closestDistance, closestPlayer = GetActivePlayers(), -1, {}
    local playerPed, playerId = PlayerPedId(), PlayerId()
    local coords, usePlayerPed = coords, false
    
    if coords then
        coords = vector3(coords.x, coords.y, coords.z)
    else
        usePlayerPed = true
        coords = GetEntityCoords(playerPed)
    end
    
    for i=1, #players, 1 do
        local tgt = GetPlayerPed(players[i])

        if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then

            local targetCoords = GetEntityCoords(tgt)
            local distance = #(coords - targetCoords)
            if distance < Config.ShowDistance then
                closestPlayer[#closestPlayer+1] = GetPlayerServerId(players[i])
            end
            -- if closestDistance == -1 or closestDistance > distance then
                -- closestPlayer = players[i]
                -- closestDistance = distance
            -- end
        end
    end
    return closestPlayer
end

RegisterNetEvent('fx-idcard:client:updateData',function()
    TriggerServerEvent('fx-idcard:server:GetData')
end)

RegisterNetEvent('fx-idcard:client:showIDCardSQL',function()
    if idcardData then
        TriggerServerEvent('fx-idcard:server:ShowIdCard',idcardData)
    else
        TriggerServerEvent('fx-idcard:server:GetData')
        Wait(2000)
        TriggerEvent('fx-idcard:client:showIDCardSQL')
    end
end)

RegisterNetEvent("fx-idcard:client:PreviewPhoto", function(typee, data)
    SetNuiFocus(true,true)
    if typee == "photo" then
        SendNUIMessage({
            action = 'showphoto',
            array = data
        })
    else
        SendNUIMessage({
            action = 'openIdCard',
            array = data
        })
    end
end)
RegisterNetEvent("fx-idcard:client:CreateIdcardUi", function(data, illegal)
    creating = true
    Config.HideHud()
    AnimpostfxPlay("OJDominoBlur")
    AnimpostfxSetStrength("OJDominoBlur", 0.5)
    SetNuiFocus(true,true)
    SendNUIMessage({
        action = 'createidcard',
        array = data,
        illegal = illegal
    })
end)

RegisterNetEvent("fx-idcard:client:ShowUi", function(typee, data)
    local closestPlayers = GetClosestPlayer()
    if typee == "photo" then
        if #closestPlayers > 0 then
            TriggerServerEvent("fx-idcard:server:ShowUi", closestPlayers, typee, data)
        else
            SetNuiFocus(true,true)
            SendNUIMessage({
                action = 'showphoto',
                array = data
            })
        end
    else
        if #closestPlayers > 0 then
            TriggerServerEvent("fx-idcard:server:ShowUi", closestPlayers, typee, data)
        else
            SetNuiFocus(true,true)
            SendNUIMessage({
                action = 'openIdCard',
                array = data
            })
        end
    end
end)

local function setActivePrompts(Type)
    if Type == "photo" then
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[1], true)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[2], true)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[3], false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[4], false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[5], false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[6], false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[7], false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[8], false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[9], false)
    elseif Type == "camera" then
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[1], false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[2], false)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[3], true)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[4], true)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[5], true)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[6], true)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[7], true)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[8], true)
        Citizen.InvokeNative(0x71215ACCFDE075EE, movements[9], true)
    -- elseif Type == "idcard" then
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[1], false)
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[2], false)
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[3], false)
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[4], false)
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[5], false)
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[6], false)
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[7], false)
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[8], false)
    --     Citizen.InvokeNative(0x71215ACCFDE075EE, movements[9], false)
    end
end

local function changeCamPosition(x,y,z)
    currentCamPosition = GetOffsetFromCoordAndHeadingInWorldCoords(currentCamPosition.x, currentCamPosition.y, currentCamPosition.z, currentCamPosition.w, x, y, z)
    local coords = GetEntityCoords(PlayerPedId())
    local dist = #(coords - currentCamPosition)
    if dist < 1.5 then
        SetCamCoord(cam, currentCamPosition.x, currentCamPosition.y, currentCamPosition.z)
    end
end

local function takePhoto(v)
    DoScreenFadeOut(1000)
    Wait(1000)
    TriggerServerEvent('fx-idcard:server:setBucket',GetPlayerServerId(PlayerId()))
    local ped = PlayerPedId()
    SetEntityCoords(ped,v.pedCoords.x,v.pedCoords.y,v.pedCoords.z-1)
    SetEntityHeading(ped,v.pedCoords.w)
    FreezeEntityPosition(ped, true)
    SetPlayerControl(PlayerId(), false)	
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)
    currentCamPosition = v.camCoords
    local fov = v.camFov
    SetCamCoord(cam, currentCamPosition.x, currentCamPosition.y, currentCamPosition.z)
    SetCamRot(cam, 0, 0, currentCamPosition.w, 2)
    Citizen.InvokeNative(0x27666E5988D9D429, cam, fov)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 0, true, true)
    Wait(1000)
    DoScreenFadeIn(1000)

    Citizen.CreateThread(function()
        while cam do
            local title = CreateVarString(10, 'LITERAL_STRING',"Photographer")
            PromptSetActiveGroupThisFrame(prompts, title)
            setActivePrompts("camera")
            if IsDisabledControlPressed(0,Config.Keybinds["exit"]) then
                RenderScriptCams(false, false, 0, true, true)
                DestroyCam(cam, true)
                cam = nil            
                SetPlayerControl(PlayerId(), true)
                FreezeEntityPosition(PlayerPedId(), false)
                TriggerServerEvent('fx-idcard:server:setBucket',0)
                Config.ShowHud()
            elseif IsDisabledControlPressed(0,Config.Keybinds["camUp"]) then
                changeCamPosition(0,0,0.01)
            elseif IsDisabledControlPressed(0,Config.Keybinds["camDown"]) then
                changeCamPosition(0,0,-0.01)
            elseif IsDisabledControlPressed(0,Config.Keybinds["camLeft"]) then
                changeCamPosition(0,-0.01,0)
            elseif IsDisabledControlPressed(0,Config.Keybinds["camRight"]) then
                changeCamPosition(0,0.01,0)
            elseif IsDisabledControlPressed(0,Config.Keybinds["camForward"]) then
                changeCamPosition(-0.01,0,0)
            elseif IsDisabledControlPressed(0,Config.Keybinds["camBack"]) then
                changeCamPosition(0.01,0,0)
            end
            Wait(1)
        end
    end)
end

Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        for k,v in pairs(Config.Photographers) do
            local ped = PlayerPedId()
            local coords = GetEntityCoords(ped)
            local dist = #(vector3(v.promptCoords.x,v.promptCoords.y,v.promptCoords.z) - coords)
            if dist < v.promptDistance then
                sleep = 1 
                local title = CreateVarString(10, 'LITERAL_STRING',Locale("promptitle"))
                if Config.Prices.printphoto then
                    title = CreateVarString(10, 'LITERAL_STRING',Locale("promptitle2").." $"..Config.Prices.printphoto)
                end
                PromptSetActiveGroupThisFrame(prompts, title)
                setActivePrompts("photo")
                if PromptHasHoldModeCompleted(movements[1]) then
                    sleep = 2000
                    Config.HideHud()
                    takePhoto(v)
                elseif PromptHasHoldModeCompleted(movements[2]) then
                    sleep = 2000
                    SetNuiFocus(true,true)
                    SendNUIMessage({
                        action = 'print',
                    })
                end
            end
        end
        Wait(sleep)
    end
end)

local function isOpen(settings)
    if not settings then
        return true
    end
    local time = GetClockHours()
    return time >= settings.open and time <= settings.close
end

local function spawnPed(v,coords)
    local modelHash = GetHashKey(v.models)
    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(10)
    end
    local npc = CreatePed(modelHash, coords.x, coords.y, coords.z-1, coords.w, false, 0)
    FreezeEntityPosition(npc, true)
    Citizen.InvokeNative(0x283978A15512B2FE, npc, true)
    SetEntityCanBeDamaged(npc, false)
    SetEntityInvincible(npc, true)
    SetBlockingOfNonTemporaryEvents(npc, true)
    SetModelAsNoLongerNeeded(modelHash)
    SetEntityAsMissionEntity(npc, true, true)
    if v.anims and v.anims.name then
        RequestAnimDict(v.anims.dict)
        while not HasAnimDictLoaded(v.anims.dict) do
            Citizen.Wait(100)
        end
        TaskPlayAnim(npc, v.anims.dict, v.anims.name, 1.0, -1.0, -1, 1, 0, true, 0, false, 0, false)
    elseif v.anims then
        TaskStartScenarioInPlace(npc, GetHashKey(v.anims.dict), 0, true, false, false, false)
    end
    return npc
end

local function createBlip(v)
    local blip = N_0x554d9d53f696d002(1664425300, v.coords.x,v.coords.y,v.coords.z)
    Citizen.InvokeNative(0x0DF2B55F717DDB10, blip, false)
    Citizen.InvokeNative(0x662D364ABF16DE2F, blip, joaat(v.blips.modifier))
    SetBlipSprite(blip, v.blips.sprite, 1)
    SetBlipScale(blip, v.blips.scale)
    Citizen.InvokeNative(0x9CB1A1623062F402, blip, v.blips.name)
    return blip
end

local function checkNPCS()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    for k,v in pairs(Config.IDCardNPC) do
        local dist = #(coords - vector3(v.coords.x,v.coords.y,v.coords.z))
        if dist < Config.PedSpawnDistance and not v.npc and isOpen(v.timeSettings) then
            v.npc = spawnPed(v,v.coords)
            v.canInteract = true
        elseif v.npc and (dist > Config.PedSpawnDistance or not isOpen(v.timeSettings)) then
            DeletePed(v.npc)
            v.npc = nil
            v.canInteract = nil
        end
        if v.blips and not v.blip then
            v.blip = createBlip(v)
        end 
        if v.blip then
            if isOpen(v.timeSettings) then
                Citizen.InvokeNative(0x662D364ABF16DE2F, v.blip, joaat(v.blips.modifier))
            else
                Citizen.InvokeNative(0x662D364ABF16DE2F, v.blip, joaat(v.timeSettings.blipmodifier))
            end
        end
    end
end 
Citizen.CreateThread(function()
    while true do
        checkNPCS()
        Wait(2000)
    end
end)
Citizen.CreateThread(function()
    while true do
        local sleep = 2000
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        for k,v in pairs(Config.IDCardNPC) do
            local dist = #(coords - vector3(v.coords.x,v.coords.y,v.coords.z))
            if dist < v.distance and v.canInteract then
                sleep = 1
                local title = CreateVarString(10, 'LITERAL_STRING',Locale("promptitle2"))
                if Config.Prices.idcard then
                    title = CreateVarString(10, 'LITERAL_STRING',Locale("promptitle2").." $"..Config.Prices.idcard)
                    if v.illegal then
                        if Config.Prices.illegal then
                            title = CreateVarString(10, 'LITERAL_STRING',Locale("promptitle3").." $"..Config.Prices.illegal)
                        end
                    end
                end
                PromptSetActiveGroupThisFrame(prompts2, title)
                if PromptHasHoldModeCompleted(movements2[1]) then
                    Wait(50)
                    Notify({
                        text = Locale("useitem", {time=Config.SelectPhotoTime}),
                        time = 10000,
                        type = "success"
                    })
                    TriggerServerEvent('fx-idcard:server:useImagePlease', k)
                end
            end
        end
        Wait(sleep)
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        SetTimeout(2000, function()
            TriggerServerEvent('fx-idcard:server:requestFramework')
        end)
    end
end)

RegisterNetEvent('fx-idcard:client:receiveFramework')
AddEventHandler('fx-idcard:client:receiveFramework', function(receivedFramework)
    Framework = receivedFramework
end)



AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end
    for k,v in pairs(Config.IDCardNPC) do
        if v.npc then
            DeletePed(v.npc)
        end
        if v.blip then
            RemoveBlip(v.blip)
        end
    end
    if cam then
        RenderScriptCams(false, false, 0, true, true)
        DestroyCam(cam, true)
        cam = nil            
        SetPlayerControl(PlayerId(), true)
        FreezeEntityPosition(PlayerPedId(), false)
    end
    if creating then
        AnimpostfxStop("OJDominoBlur")
    end
end)


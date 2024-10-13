Framework = "none"
onPlayerLoadEvent = "none" 
LoadTimeout = 30 

if IsDuplicityVersion() then
    local vorpResource = GetResourceState('vorp_core')
    local rsgResource = GetResourceState('rsg-core')
    
    if vorpResource == 'started' then
        Framework = "VORP"
        onPlayerLoadEvent = "vorp:SelectedCharacter" 
    elseif rsgResource == 'started' then
        Framework = "RSG"
        LoadTimeout = 5
        onPlayerLoadEvent = "RSGCore:Client:OnPlayerLoaded"
    else
        Citizen.CreateThread(function()
            while true do
                Citizen.Wait(2000)
                print("^1[ERROR]^0 No suitable framework found. ^2Please install ^3vorp_core^2 or ^3rsg-core^2.")
                print("^1[ERROR]^0 Make sure to start ^3fx-idcard^0 after the frameworks in your ^2server.cfg^0 file.")
            end
        end)
    end
    print("^2[INFO]^0 Framework selected: ^3" .. Framework .. "^0")
end

if Framework == "VORP" then
    if IsDuplicityVersion() then
        --[[
            Server Side
        ]]
        local VorpCore = exports.vorp_core:GetCore()
    
        VorpInv = {}
        VorpInv = exports.vorp_inventory:vorp_inventoryApi()
        
        function FXRegisterUsableItem(itemname,callBack)
            exports.vorp_inventory:registerUsableItem(itemname, function(data)
                local array = {
                    source = data.source,
                    item = data.item
                }
                callBack(array)
            end)
        end
        
        function FXCloseInventory(src)
            exports.vorp_inventory:closeInventory(src)
        end
        
        function FXRemoveItem(src,itemName,itemCount,Metadata)
            return exports.vorp_inventory:subItem(src, itemName, itemCount, Metadata)
        end
        
        function FXAddItem(src,itemName,itemCount,Metadata)
            return exports.vorp_inventory:addItem(src, itemName, itemCount, Metadata)
        end

        function FXHaveMoney(src,moneytype,count)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            if Character.money >= count and moneytype == "cash" then
                return true
            elseif Character.gold >= count and moneytype == "gold" then
                return true
            end
            return false
        end
        function FXRemoveMoney(src,moneytype,count)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            local vorpmoneytype = moneytype == "gold" and 1 or 0
            Character.removeCurrency(vorpmoneytype, count)
            return true
        end
        function FXAddMoney(src,moneytype,count)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            local vorpmoneytype = moneytype == "gold" and 1 or 0
            Character.addCurrency(vorpmoneytype, count)
            return true
        end
    
        function FXGetCharacterInformations(src, charid,cb)
            local array = {}
            exports.oxmysql:execute("SELECT * FROM characters WHERE charidentifier = ?", {charid},function(result)
                if result[1] then
                    array.height = json.decode(result[1].skinPlayer).Scale
                    array.sex = result[1].gender
                    array.weight = math.random(45,65)
                    if array.sex == "Male" then
                        array.weight = math.random(70,100)
                    end
                    array.firstname = result[1].firstname
                    array.lastname = result[1].lastname
                    array.age = result[1].age
                end
                cb(array)
            end)
        end
        
        function FXGetPlayerData(src)
            local User = VorpCore.getUser(src)
            local Character = User.getUsedCharacter
            local array = {
                firstname = Character.firstname,
                lastname = Character.lastname,
                charIdentifier = Character.charIdentifier,
                cash = Character.money,
                gold = Character.gold,
                admin = User.getGroup == "admin"
            }
            return array
        end
    
    else
    --[[
        Client Side
    ]]    
    
        VorpCore = exports.vorp_core:GetCore()
        
        RegisterNetEvent('vorp:SelectedCharacter',function()
            TriggerServerEvent('fx-idcard:server:GetData')
        end)
        
    end
elseif Framework == "RSG" then
    if IsDuplicityVersion() then
        --[[
            Server Side
        ]]
        RSGCore = exports['rsg-core']:GetCoreObject()

        function FXRegisterUsableItem(itemname,callBack)
            RSGCore.Functions.CreateUseableItem(itemname, function(source,item)
                local array = {
                    source = source,
                    item = item
                }
                array.item.item = item.name
                array.item.metadata = item.info
                callBack(array)
            end)
        end
        
        function FXCloseInventory(src)
            TriggerClientEvent("rsg-inventory:client:closeinv", src)
        end
        
        function FXRemoveItem(src,itemName,itemCount,Metadata)
            local Player = RSGCore.Functions.GetPlayer(src)
            local foundslot = false
            for slot,item in pairs(Player.PlayerData.items) do
                if item.name:lower() == itemName:lower() then
                    if Metadata then
                        if item.info.privateID == Metadata.privateID then
                            foundslot = slot
                            break
                        end
                    else
                        foundslot = slot
                        break
                    end
                end
            end
            if not foundslot then return false end
            Player.Functions.RemoveItem(itemName, itemCount,foundslot)
            return true
        end
        
        function FXAddItem(src,itemName,itemCount,Metadata)
            local Player = RSGCore.Functions.GetPlayer(src)
            Player.Functions.AddItem(itemName, itemCount,false,Metadata)
        end
        function FXHaveMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            local pcash = Player.PlayerData.money['cash']
            local pbank = Player.PlayerData.money['bank']
            if pcash >= count and moneytype == "cash" then
                return true
            else
                if pbank >= count and moneytype == "gold" then
                    return true
                end
            end
            return false
        end
        function FXRemoveMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if moneytype == "cash" then
                Player.Functions.RemoveMoney('cash', count, 'fx-idcard')
            else
                Player.Functions.RemoveMoney('bank', count, 'fx-idcard')
            end
            return true
        end
        function FXAddMoney(src,moneytype,count)
            local Player = RSGCore.Functions.GetPlayer(src)
            if moneytype == "cash" then
                Player.Functions.AddMoney('cash', count, 'fx-idcard')
            else
                Player.Functions.AddMoney('bank', count, 'fx-idcard')
            end
            return true
        end
        ---- RSG UYARLANACAK --- SQL = players.charinfo and playerskins
        function FXGetCharacterInformations(src, charid,cb)
            local array = {}
            local Player = RSGCore.Functions.GetPlayer(src)

            exports.oxmysql:execute("SELECT * FROM playerskins WHERE citizenid = ?", {charid},function(result)
                if result[1] then
                    local height = json.decode(result[1].skin) and json.decode(result[1].skin).height or 100
                    array.height = math.floor(tonumber(height) / 100)
                    array.sex = Player.PlayerData.charinfo.gender == 1 and "Female" or "Male"
                    array.weight = math.random(45,65)
                    if array.sex == "Male" then
                        array.weight = math.random(70,100)
                    end
                    array.firstname = Player.PlayerData.charinfo.firstname
                    array.lastname = Player.PlayerData.charinfo.lastname
                    local year = string.sub(Player.PlayerData.charinfo.birthdate,1,4)
             
                    array.age = 1899 - tonumber(year)
                end
                cb(array)
            end)
        end
        
        function FXGetPlayerData(src)
            local Player = RSGCore.Functions.GetPlayer(src)
            local array = {
                firstname = Player.PlayerData.charinfo.firstname,
                lastname = Player.PlayerData.charinfo.lastname,
                job = Player.PlayerData.job.name,
                grade = Player.PlayerData.job.grade.level,
                charIdentifier = Player.PlayerData.citizenid,
                cash = Player.PlayerData.money["cash"],
                gold = Player.PlayerData.money["bank"],
                admin = RSGCore.Functions.HasPermission(src, 'admin') or IsPlayerAceAllowed(src, 'command') 
            }
            return array
        end
    else
    --[[
        Client Side
    ]]    
        RSGCore = exports['rsg-core']:GetCoreObject()
    
        RegisterNetEvent('RSGCore:Client:OnPlayerLoaded',function()
            TriggerServerEvent('fx-idcard:server:GetData')
        end)
    end    
end



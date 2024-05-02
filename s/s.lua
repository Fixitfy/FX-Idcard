local vesikalikPlease = {}

RegisterNetEvent("fx-idcard:server:print", function(link)
    local src = source
    if Config.Prices.printphoto then
        local HaveMoney = FXHaveMoney(src, "cash", Config.Prices.printphoto)
        if HaveMoney then
            FXRemoveMoney(src,"cash",Config.Prices.printphoto)
        else
            return Notify({
                source = src,
                text = Locale("nomoney", {money=Config.Prices.printphoto}),
                type = "success",
                time = 4000
            })
        end
    end
    local metadata = {
        description = Locale("photodesc").."</br>"..link,
        img = link
    }

    FXAddItem(src, Config.PrintPhotoItem, 1, metadata)
    Notify({
        source = src,
        text = Locale("successprint"),
        type = "success",
        time = 4000
    })
end)

RegisterNetEvent('fx-idcard:server:GetData', function()
    local src = source
    local Character = FXGetPlayerData(src)
    local charid = Character.charIdentifier
    exports.oxmysql:execute("SELECT * FROM fx_idcard WHERE charid = ?", {charid},function(result)
        if result[1] then
            TriggerClientEvent('fx-idcard:client:setData',src,json.decode(result[1].data))
        end
    end)
end)


RegisterNetEvent('fx-idcard:server:useImagePlease',function(city)
    vesikalikPlease[tostring(source)] = city
    SetTimeout(Config.SelectPhotoTime * 1000,function()
        vesikalikPlease[tostring(source)] = nil
    end)
end)

RegisterNetEvent('fx-idcard:server:setBucket',function(bucket)
    SetPlayerRoutingBucket(source,bucket)
end)
RegisterNetEvent("fx-idcard:server:ShowUi", function(targets, typee, data)
    local src = source
    if typee == "photo" then
        TriggerClientEvent("fx-idcard:client:PreviewPhoto", src,typee, data)
        for k,v in ipairs(targets) do
            TriggerClientEvent("fx-idcard:client:PreviewPhoto", v,typee, data)
        end
    else
        TriggerClientEvent("fx-idcard:client:PreviewPhoto", src,typee, data)
        for k,v in ipairs(targets) do
            TriggerClientEvent("fx-idcard:client:PreviewPhoto", v,typee, data)
        end
    end
end)

FXRegisterUsableItem(Config.PrintPhotoItem,function(data)
    local src = data.source
    local link = data.item.metadata.img
    local data = {img = link}
    FXCloseInventory(src)
    if vesikalikPlease[tostring(src)] then
        local city = vesikalikPlease[tostring(src)]
        vesikalikPlease[tostring(src)] = nil
        local Character = FXGetPlayerData(src)
        FXGetCharacterInformations(src, Character.charIdentifier,function(data)
            data = {
                name= data.firstname.." "..data.lastname,
                age = data.age,
                gender = data.sex,
                charid=Character.charIdentifier,
                height = data.height,
                weight = data.weight,
                city = city,
                img = link,
                religious = Config.Religious[math.random(1,#Config.Religious)],
            }
            Wait(1000)
            TriggerClientEvent("fx-idcard:client:CreateIdcardUi", src, data)
        end)
    else
        TriggerClientEvent("fx-idcard:client:ShowUi", src, "photo", data)
    end
end)

FXRegisterUsableItem(Config.ManIdCardItem,function(data)
    local src = data.source
    local itemData = data.item.metadata
    FXCloseInventory(src)
    TriggerClientEvent("fx-idcard:client:ShowUi", src, "idcard", itemData.CardData)
end)
FXRegisterUsableItem(Config.WomanIdCardItem,function(data)
    local src = data.source
    local itemData = data.item.metadata
    FXCloseInventory(src)
    TriggerClientEvent("fx-idcard:client:ShowUi", src, "idcard", itemData.CardData)
end)

RegisterNetEvent("fx-idcard:server:ShowIdCard", function(data)
    local src = source
    TriggerClientEvent("fx-idcard:client:ShowUi", src, "idcard", data)
end)

-- ### Data
-- name, cityname, religious, age, height, weight, hair, eye, sex, img
RegisterNetEvent('fx-idcard:server:buyIdCard',function(data)
    local src = source
    local Character = FXGetPlayerData(src)
    if Config.TakeCardType == "sql" then
        local charid = Character.charIdentifier
        data.charid = charid
        if Config.Prices.idcard then
            local HaveMoney = FXHaveMoney(src, "cash", Config.Prices.idcard)
            if HaveMoney then
                FXRemoveMoney(src,"cash",Config.Prices.idcard)
            else
                return Notify({
                    source = src,
                    text = Locale("nomoney", {money=Config.Prices.idcard}),
                    type = "success",
                    time = 4000
                })
            end
        end
        exports.oxmysql:execute("SELECT * FROM fx_idcard WHERE charid = ?", {charid},function(result)
            if not result[1] then
                local Parameters = {
                    ['charid'] = charid,
                    ['data'] = tostring(json.encode(data)),
                }
                exports.oxmysql:execute("INSERT INTO fx_idcard (`charid`, `data`) VALUES (@charid, @data)", Parameters)
                TriggerClientEvent('fx-idcard:client:setData',src,data)
                Notify({
                    source = src,
                    text = Locale("successidcard"),
                    type = "success",
                    time = 4000
                })
                CharData = data
            else
                Notify({
                    source = src,
                    text = Locale("alreadyidcard"),
                    type = "error",
                    time = 4000
                })
            end
        end)
    elseif Config.TakeCardType == "item" then
        local item = Config.ManIdCardItem
        local metadata = {
            description = Locale("idcarddesc",{
                name=data.name,
                age = Character.age,
                charid=Character.charIdentifier,
            }),
            -- name, cityname, religious, age, date, height, weight, hair, eye, sex, img
            CardData = {
                name=data.name,
                cityname=data.cityname,
                religious = data.religious,
                age = data.age,
                date = data.date,
                height = data.height,
                weight = data.weight,
                hair = data.hair,
                eye = data.eye,
                sex = data.sex,
                charid = Character.charIdentifier,
                img = data.img,
            }
        }
        if data.sex == "Female" then
            item = Config.WomanIdCardItem
        end
        if Config.Prices.idcard then
            local HaveMoney = FXHaveMoney(src, "cash", Config.Prices.idcard)
            if HaveMoney then
                FXRemoveMoney(src,"cash",Config.Prices.idcard)
            else
                return Notify({
                    source = src,
                    text = Locale("nomoney", {money=Config.Prices.idcard}),
                    type = "success",
                    time = 4000
                })
            end
        end
        
        FXAddItem(src, item, 1, metadata)

        Notify({
            source = src,
            text = Locale("addIdCard"),
            type = "success",
            time = 4000
        })
        
    end
end)
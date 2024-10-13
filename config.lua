Config = {}
Config.Language = "en"
Config.TakeCardType = "item" ---- or "sql" (If you select item, it will give you a special ID card with metada and you can have more than one ID card. If you select sql, it will be saved in everyone's data and you will be able to create id card only 1 time.)
Config.Keybinds = {
    ["takephoto"] = 0x760A9C6F,
    ["exit"] = 0x156F7119,

    ["camUp"] = 0x62800C92,
    ["camDown"] = 0x8BDE7443,

    ["camLeft"] = 0x07CE1E61,
    ["camRight"] = 0xF84FA74F,

    ["camForward"] = 0xCBD5B26E,
    ["camBack"] = 0x110AD1D2,

    ["printphoto"] = 0xC7B5340A,
    ["takeidcard"] = 0x2CD5343E,--
}
Config.Locale = {
    ["en"] = {
        --- PROMPTS ---
        ["promptitle"] = "Photographer",
        ["promptitle2"] = "Id Card System",
        ["takephoto"] = "Take Photo",
        ["printphoto"] = "Print Photo",
        ["exit"] = "Exit",
        ["camUp"] = "Up",
        ["camDown"] = "Down",
        ["camLeft"] = "Left",
        ["camRight"] = "Right",
        ["camForward"] = "Forward",
        ["camBack"] = "Back",
        ["promptitle2"] = "Identity Card System",
        ["promptitle3"] = "Illegal Identity Card",
        ["takeidcard"] = "Take Id Card",
        --- NOTIFY -----
        ["noimg"] = "No picture ~COLOR_YELLOW~link~COLOR_WHITE~ entered !",
        ["successprint"] = "The photo has been added to your inventory, you can view it with a ~COLOR_YELLOW~double click",
        ["addIdCard"] = "The id card has been added to your inventory, you can view it with a ~COLOR_YELLOW~double click",
        ["errorprint"] = "Print ~COLOR_RED~failed ~COLOR_WHITE~!",
        ["erroridcard"] = "ID Card creation ~COLOR_RED~failed ~COLOR_WHITE~!",
        ["photodesc"] = "Photo Id",
        ["nodata"] = "You don't have an identity !",
        ["nomoney"] = "You don't have enough money. Fee : ~COLOR_YELLOW~${money}",
        ["successidcard"] = "Your ID card is attached. You can now show your ID",
        ["useitem"] = "Use your photo from inventory within ~COLOR_YELLOW~${time} ~COLOR_WHITE~seconds",
        ["alreadyidcard"] = "You already have an identity card. You need approval to change your ID card",
        ["idcarddesc"] = "${name}'s identity </br>Identity Number: <span style=color:yellow;>${charid}",
        ["noprintphoto"] = "You do not have a passport photo !",
    },
    ["fr"] = {
        --- PROMPTS ---
        ["promptitle"] = "Photographe",
        ["promptitle2"] = "Service de carte d'identité",
        ["takephoto"] = "Prendre une photo",
        ["printphoto"] = "Imprimer une photo",
        ["exit"] = "Annuler",
        ["camUp"] = "Haut",
        ["camDown"] = "Bas",
        ["camLeft"] = "Gauche",
        ["camRight"] = "Droite",
        ["camForward"] = "Avant",
        ["camBack"] = "Arrière",
        ["promptitle2"] = "Système de carte d'identité",
        ["promptitle3"] = "Illegal Identity Card",
        ["takeidcard"] = "Obtenez votre pièce d'identité",
        --- NOTIFY -----
        ["noimg"] = "Aucun ~COLOR_YELLOW~lien~COLOR_WHITE~ de photo saisi !",
        ["successprint"] = "Votre photo d'identité a été ajoutée à votre inventaire, vous pouvez la regarder avec un ~COLOR_YELLOW~double click~COLOR_WHITE~ dessus.",
        ["addIdCard"] = "Votre carte d'identité a été ajoutée à votre inventaire, vous pouvez la regarder avec un ~COLOR_YELLOW~double click~COLOR_WHITE~ dessus.",
        ["errorprint"] = "~COLOR_RED~Échec de l'impression de la photo !",
        ["erroridcard"] = "~COLOR_RED~La carte d'identité n'a pas pu être créée !",
        ["photodesc"] = "Photo d'identité",
        ["nodata"] = "Vous n'avez aucune pièce d'identité !",
        ["nomoney"] = "Vous n'avez pas assez d'argent. Coût : ~COLOR_YELLOW~${money}}",
        ["successidcard"] = "Votre carte d'identité a été enregistrée. Vous pouvez la présenter",
        ["useitem"] = "Vous avez ~COLOR_YELLOW~${time} ~COLOR_WHITE~secondes pour choisir votre photo d'identité",
        ["alreadyidcard"] = "Vous avez déjà une carte d'identité. Vous devez obtenir une autorisation pour la modifier",
        ["idcarddesc"] = "Carte d'identité de ${name} </br>Numéro d'identification : <span style=color:yellow;>${charid}",
        ["successdelete"] = "La carte d'identité a été supprimée avec succès",
        ["nojob"] = "Vous n'êtes pas autorisé à faire cela !",
        ["errorcommand"] = "Utilisation incorrecte. Commande : /deleteidcard id",
        ["noprintphoto"] = "You do not have a passport photo !",
    },
    ["tr"] = {
        --- PROMPTS ---
        ["promptitle"] = "Kamera Konumunu Ayarla",
        ["promptitle2"] = "Vesikalik Fotograf Sistemi",
        ["takephoto"] = "Fotograf Cekin",
        ["printphoto"] = "Fotografini Al",
        ["exit"] = "Cikis",
        ["camUp"] = "Yukari",
        ["camDown"] = "Asagi",
        ["camLeft"] = "Sol",
        ["camRight"] = "Sag",
        ["camForward"] = "Yakinlastir",
        ["camBack"] = "Uzaklastir",
        ["promptitle2"] = "Kimlik Karti Sistemi",
        ["promptitle3"] = "Illegal Identity Card",
        ["takeidcard"] = "Kimligini Al",
        --- NOTIFY -----
        ["noimg"] = "Fotograf ~COLOR_YELLOW~linki~COLOR_WHITE~ girilmemis!",
        ["successprint"] = "Vesikalik fotografiniz envanterinize eklendi, ~COLOR_YELLOW~iki kez tiklayarak goruntuleyebilirsiniz.",
        ["addIdCard"] = "Kimliginiz envanterinize eklendi, ~COLOR_YELLOW~iki kez tiklayarak goruntuleyebilirsiniz.",
        ["errorprint"] = "Fotograf cikartma ~COLOR_RED~basarisiz ~COLOR_WHITE~!",
        ["erroridcard"] = "Kimlik karti ~COLOR_RED~olusturulamadi ~COLOR_WHITE~!",
        ["photodesc"] = "Photo Id",
        ["nodata"] = "Bir kimliginiz yok !",
        ["nomoney"] = "Yeterli paraniz yok. Ucret : ~COLOR_YELLOW~${money}",
        ["successidcard"] = "Kimlik kartiniz kaydedildi. Kimliginizi gösterebilirsiniz",
        ["useitem"] = "Vesikalik fotografinizi cantanizdan secmek icin ~COLOR_YELLOW~${time} ~COLOR_WHITE~saniyeniz var",
        ["alreadyidcard"] = "Zaten bir kimlik kartiniz var. Kimlik kartinizi degistirmek icin onay almalisiniz",
        ["idcarddesc"] = "${name}'s kimlik </br>Kimlik Numarasi: <span style=color:yellow;>${charid}",
        ["successdelete"] = "IDCard has been deleted successful",
        ["nojob"] = "You have no authorisation!",
        ["errorcommand"] = "Incorrect usage. use this way /deleteidcard id",
        ["noprintphoto"] = "You do not have a passport photo !",
    }
}
Config.HideHud = function()
	-- exports['fx-hud']:hideHud()
end
Config.ShowHud = function()
	-- exports['fx-hud']:showHud()
end

Config.Prices = { -- cash
    printphoto = 5, -- or false (if false == free)
    idcard = 50, -- or false if false == free)
    illegal = 100, -- or false if false == free)
}

Config.DeletePlayerDataCommand = "deleteidcard" -- /deleteidcard (id)      (Only admin or job "judge" check this s/opnesource.lua)
Config.SelectPhotoTime = 30 -- second
Config.PrintPhotoItem = "printphoto" --- item name
Config.ManIdCardItem = "man_idcard" --- item name
Config.WomanIdCardItem = "woman_idcard" --- item name
Config.ShowDistance = 1.5 --- Show id card and photo distance
Config.Photographers = {
    ["Blackwater"] = {
        promptCoords = vector4(-811.7769, -1373.9686, 44.0733, 104.9485),
        promptDistance = 2,
        pedCoords = vector4(-815.55, -1374.78, 44.28, -91.68),
        camCoords = vector4(-814.40, -1374.85, 44.90, 86.48),
        camFov = 60.0,
    },
}

Config.PedSpawnDistance = 30
Config.Religious = {"Christian"} -- {"Christian","Muslim","Jewish"} 
Config.IDCardNPC = {
    ["Blackwater"] = {
        coords = vector4(-798.8420, -1194.6926, 44.0010, 161.6237),
        models = "cs_brontesbutler",
        distance = 3,
        blips = {
            name = "IDENTITY PROCESS",
            sprite = -1656531561,
            scale = 0.6,
            modifier = "BLIP_MODIFIER_MP_COLOR_32",
        },
        anims = {
            dict = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            name = false,
        },
        timeSettings = { -- or false
            open = 8,
            close = 21,
            blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
        },

    },
    ["Strawberry"] = {
        coords = vector4(-1803.5564, -345.7397, 164.4913, 210.3091),
        models = "cs_brontesbutler",
        distance = 3,
        blips = {
            name = "IDENTITY PROCESS",
            sprite = -1656531561,
            scale = 0.6,
            modifier = "BLIP_MODIFIER_MP_COLOR_32",
        },
        anims = {
            dict = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            name = false,
        },
        timeSettings = { -- or false
            open = 8,
            close = 21,
            blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
        },

    },
    ["Valentine"] = {
        coords = vector4(-175.3824, 631.9274, 114.1396, 322.0134),
        models = "cs_brontesbutler",
        distance = 3,
        blips = {
            name = "IDENTITY PROCESS",
            sprite = -1656531561,
            scale = 0.6,
            modifier = "BLIP_MODIFIER_MP_COLOR_32",
        },
        anims = {
            dict = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            name = false,
        },
        timeSettings = { -- or false
            open = 8,
            close = 21,
            blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
        },

    },
    ["Rhodes"] = {
        coords = vector4(1230.2253, -1298.4535, 76.9544, 216.9492),
        models = "cs_brontesbutler",
        distance = 3,
        blips = {
            name = "IDENTITY PROCESS",
            sprite = -1656531561,
            scale = 0.6,
            modifier = "BLIP_MODIFIER_MP_COLOR_32",
        },
        anims = {
            dict = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            name = false,
        },
        timeSettings = { -- or false
            open = 8,
            close = 21,
            blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
        },

    },
    ["Armadillo"] = {
        coords = vector4(-3729.1255, -2601.2808, -12.8877, 181.9450),
        models = "cs_brontesbutler",
        distance = 3,
        blips = {
            name = "IDENTITY PROCESS",
            sprite = -1656531561,
            scale = 0.6,
            modifier = "BLIP_MODIFIER_MP_COLOR_32",
        },
        anims = {
            dict = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            name = false,
        },
        timeSettings = { -- or false
            open = 8,
            close = 21,
            blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
        },

    },
    ["Saintdenis"] = {
        coords = vector4(2510.2656, -1308.9792, 49.0036, 270.7017),
        models = "cs_brontesbutler",
        distance = 3,
        blips = {
            name = "IDENTITY PROCESS",
            sprite = -1656531561,
            scale = 0.6,
            modifier = "BLIP_MODIFIER_MP_COLOR_32",
        },
        anims = {
            dict = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            name = false,
        },
        timeSettings = { -- or false
            open = 8,
            close = 21,
            blipmodifier = "BLIP_MODIFIER_MP_COLOR_2",
        },
    },
    ["IllegalCard"] = {
        illegal = true,
        coords = vector4(-813.2076, -1378.4711, 43.6373, 181.3653),
        fakeLabel = "Rhodes",
        models = "cs_brontesbutler",
        distance = 2,
        blips = false,
        anims = {
            dict = "WORLD_HUMAN_SMOKE_NERVOUS_STRESSED",
            name = false,
        },
        timeSettings = false,
    },
}

function Notify(data)
    local text = data.text or "No message" 
    local time = data.time or 5000  
    local type = data.type or "info" 
    local dict = data.dict or ""
    local icon = data.icon or ""
    local color = data.color or 0
    local src = data.source

    if IsDuplicityVersion() then
        if Framework == "RSG" then
            TriggerClientEvent('ox_lib:notify', src, { title = text, type = type, duration = time })
        elseif Framework == "VORP" then
            if icon then
                TriggerClientEvent('vorp:ShowAdvancedRightNotification', src, text, dict, icon, color, time)
            else
                TriggerClientEvent("vorp:TipBottom",src, text, time, type)
            end
        end
    else
        if Framework == "RSG" then
            TriggerEvent('ox_lib:notify', { title = text, type = type, duration = time })
        elseif Framework == "VORP" then
            if icon then
                TriggerEvent("vorp:ShowAdvancedRightNotification", text, dict, icon, color, time)
            else
                TriggerEvent("vorp:TipBottom", text, time, type)
            end
        end
    end
end


function Locale(key, subs)
    local translate = Config.Locale[Config.Language][key] or "Missing locale: [" .. key .. "]"
    subs = subs or {}

    for k, v in pairs(subs) do
        translate = translate:gsub('%%${' .. k .. '}', tostring(v))
    end

    return translate
end
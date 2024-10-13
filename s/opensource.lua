RegisterCommand(Config.DeletePlayerDataCommand,function(source,args)
    if args and args[1] then
        local src = source
        local Character = FXGetPlayerData(src)
        if Character.admin or Character.job == "judge" then
            local target = FXGetPlayerData(tonumber(args[1]))
            MySQL.query.await('DELETE FROM `fx_idcard` WHERE charid = ?', {target.charIdentifier})
            TriggerClientEvent('fx-idcard:client:updateData',tonumber(args[1]))
            Notify({
                source = source,
                text = Locale("successdelete"),
                type = "success",
                time = 4000
            })
        else
            Notify({
                source = source,
                text = Locale("nojob"),
                type = "error",
                time = 4000
            })
        end
    else
        Notify({
            source = source,
            text = Locale("errorcommand"),
            type = "error",
            time = 4000
        })
    end
end)
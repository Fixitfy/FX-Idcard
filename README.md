### Fixitfy Upload Service

- Upload your pictures here. You will not have any breakage or problems
https://upload.fixitfy.com.tr/

### Usage

- First print out a picture. Then go get your ID card. Whether you want to use sql or choose the meta item option. After making your settings in the config.lua file, enjoy.

### Installation

- Read the fx_idcard sql file to your database.
- Put your item images into your inventory.
- Write ensure fx-idcard at the bottom of your server.cfg file and restart the server

### SETUP VORP
- If you are not using RSG Framework and do not have ox_lib, edit the following code as follows;
```lua
shared_scripts {
    -- '@ox_lib/init.lua',
    "framework/*.lua", 
    "config.lua",
    "consumables.lua"
}
```

### Client Show Event
```lua
TriggerClientEvent("fx-idcard:client:showIDCardSQL")
```

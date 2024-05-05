# FX-IDCard
## Fixitfy Digital Agency
- If you have any problems with the installation or operation of the script, you can get help by creating a ticket on our discord server. We provide 24/7 support to you. https://discord.fixitfy.com.tr/


### Fixitfy Upload Service

- Upload your pictures here. You will not have any breakage or problems
https://upload.fixitfy.com.tr/

### Usage

- First print out a picture. Then go get your ID card. Whether you want to use sql or choose the meta item option. After making your settings in the config.lua file, enjoy.

### Installation

- Read the fx_idcard sql file to your database.
- Put your item images into your inventory.
- Write ensure fx-idcard at the bottom of your server.cfg file and restart the server

## For RSGCore
- go to RSG-core/shared/items.lua
- Add the following code at the bottom of the file.
```lua
    ['printphoto'] = {['name'] = 'printphoto', ['label'] = 'Print Photo', ['weight'] = 5, ['type'] = 'item', ['image'] = 'printphoto.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['level'] = 0, ['description'] = 'Nice Item'},
    ['woman_idcard'] = {['name'] = 'woman_idcard', ['label'] = 'IDCard', ['weight'] = 5, ['type'] = 'item', ['image'] = 'woman_idcard.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['level'] = 0, ['description'] = 'Nice Item'},
    ['man_idcard'] = {['name'] = 'man_idcard', ['label'] = 'IDCard', ['weight'] = 5, ['type'] = 'item', ['image'] = 'man_idcard.png', ['unique'] = true, ['useable'] = true, ['shouldClose'] = true, ['combinable'] = nil, ['level'] = 0, ['description'] = 'Nice Item'},
```

### Client Show Event
```lua
TriggerClientEvent("fx-idcard:client:showIDCardSQL")
```

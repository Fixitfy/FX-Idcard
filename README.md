## Fixitfy Studio
https://forum-cfx-re.akamaized.net/optimized/5X/5/e/e/f/5eef922afdab53caf9882e1e9247bb19eaeebdde_2_690x322.jpeg

### Compatible : VORP/RSG

#### How does it work?
1 - First go to a photographer in Config.Photographers and take a photo.
2 - Go to the ID card attendant with your photo and get an ID card.
3 - When you interact, he will ask you to use a photo you have in your inventory.
4 - The information you use the photo for will be filled in automatically and you can get your ID card.
5 - If Config.TakeCardType is selected as "item", your ID card is added to your inventory with metadata, if "sql" is selected, it is saved to sql and 
You can display it with the Config.ShowIdcardCommand command

### Fixitfy Upload Service

- Upload your pictures here. You will not have any breakage or problems
https://upload.fixitfy.com.tr/

### Usage

- First print out a picture. Then go get your ID card. Whether you want to use sql or choose the meta item option. After making your settings in the config.lua file, enjoy.

### Installation

- Read the fx_idcard sql file to your database.
- Put your item images into your inventory.
- Write ensure fx-idcard at the bottom of your server.cfg file and restart the server

### Client Show Event
```lua
TriggerClientEvent("fx-idcard:client:showIDCardSQL")
```

Showcase
https://forum-cfx-re.akamaized.net/optimized/5X/e/e/1/8/ee18008ca996e62fb59f768eadfdfbe90da87226_2_690x368.jpeg
https://forum-cfx-re.akamaized.net/optimized/5X/b/3/c/2/b3c2278bd037d561cae298a8723c575124abd275_2_606x500.jpeg
https://forum-cfx-re.akamaized.net/original/5X/c/2/5/1/c251cda7c40de6057d89e9e8fc7b356d10d7e336.gif
https://forum-cfx-re.akamaized.net/original/5X/d/3/d/6/d3d6e6241575a239eae6022ff42fddc6102122a8.gif
https://forum-cfx-re.akamaized.net/original/5X/c/2/0/a/c20a584c49cad59c319281f401d408a1564cbb68.gif
https://forum-cfx-re.akamaized.net/original/5X/8/a/b/0/8ab0fd82c0f012ab882f6ddd2ec4a57717e56bfd.gif
https://forum-cfx-re.akamaized.net/original/5X/a/4/c/f/a4cf29ca9ab925b0e2a21d08d62235f269f1a172.jpeg
https://forum-cfx-re.akamaized.net/optimized/5X/5/5/8/e/558ef745003237ec9f8e8d301577a2ef5eacd90e_2_690x359.jpeg
https://forum-cfx-re.akamaized.net/optimized/5X/9/f/5/0/9f50f1ce6457dbe435b3c5c148cbe9784b36d5ad_2_690x396.jpeg

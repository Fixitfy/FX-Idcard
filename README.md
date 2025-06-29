
<p align="center">
  <img src="https://forum-cfx-re.akamaized.net/optimized/5X/5/e/e/f/5eef922afdab53caf9882e1e9247bb19eaeebdde_2_690x322.jpeg" alt="Fixitfy Studio" />
</p>

<h1 align="center">Fixitfy ID Card System</h1>

---

### ✅ Compatible with: VORP / RSG

---

### 📌 How does it work?

1. Go to a photographer (defined in `Config.Photographers`) and take a photo.  
2. Visit the ID card attendant with the photo in your inventory.  
3. When interacting, you’ll be prompted to use that photo.  
4. The photo will automatically pull character data and generate your ID card.  
5. Depending on `Config.TakeCardType`:  
   - `"item"`: ID card is added to your inventory with metadata.  
   - `"sql"`: ID card is saved to your SQL database and viewable with `Config.ShowIdcardCommand`.

---

### ☁️ Fixitfy Upload Service

Upload your pictures without issues:  
🔗 [https://upload.fixitfy.com.tr/](https://upload.fixitfy.com.tr/)

---

### 🛠️ Usage

- Upload & print your picture.  
- Use the photo to get your ID card.  
- Customize whether the system uses metadata or SQL via `config.lua`.  
- Enjoy your unique and immersive ID card system.

---

### 📥 Installation

1. Import the `fx_idcard.sql` into your database.  
2. Add item images to your inventory system.  
3. Add this line to the **bottom** of your `server.cfg`:
   ```txt
   ensure fx-idcard
   ```

---

### 🎮 Client Show Event

```lua
TriggerClientEvent("fx-idcard:client:showIDCardSQL")
```

---

### 📸 Showcase

<p align="center">
  <img src="https://forum-cfx-re.akamaized.net/optimized/5X/e/e/1/8/ee18008ca996e62fb59f768eadfdfbe90da87226_2_690x368.jpeg" width="45%" />
  <img src="https://forum-cfx-re.akamaized.net/optimized/5X/b/3/c/2/b3c2278bd037d561cae298a8723c575124abd275_2_606x500.jpeg" width="45%" />
</p>

<p align="center">
  <img src="https://forum-cfx-re.akamaized.net/original/5X/c/2/5/1/c251cda7c40de6057d89e9e8fc7b356d10d7e336.gif" width="30%" />
  <img src="https://forum-cfx-re.akamaized.net/original/5X/d/3/d/6/d3d6e6241575a239eae6022ff42fddc6102122a8.gif" width="30%" />
  <img src="https://forum-cfx-re.akamaized.net/original/5X/c/2/0/a/c20a584c49cad59c319281f401d408a1564cbb68.gif" width="30%" />
</p>

<p align="center">
  <img src="https://forum-cfx-re.akamaized.net/original/5X/8/a/b/0/8ab0fd82c0f012ab882f6ddd2ec4a57717e56bfd.gif" width="30%" />
  <img src="https://forum-cfx-re.akamaized.net/original/5X/a/4/c/f/a4cf29ca9ab925b0e2a21d08d62235f269f1a172.jpeg" width="30%" />
  <img src="https://forum-cfx-re.akamaized.net/optimized/5X/5/5/8/e/558ef745003237ec9f8e8d301577a2ef5eacd90e_2_690x359.jpeg" width="30%" />
</p>

<p align="center">
  <img src="https://forum-cfx-re.akamaized.net/optimized/5X/9/f/5/0/9f50f1ce6457dbe435b3c5c148cbe9784b36d5ad_2_690x396.jpeg" width="45%" />
</p>

---

### 📣 Need Help?

For questions, contact us at [Fixitfy Discord](https://discord.gg/27MQADtar7)

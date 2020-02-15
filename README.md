# Custom Roleplay Gamemode for Garry's Mod
Ain't got the time to finish this. 

It is heavily inspired by an old french closed-source gamemode that never got publicly released.

Code is ugly, you'll find a lot of legacy code.

Last update I made was on the 26th november 2019. Nothing was tested since.

I won't maintain this repo, feel free to fork it.

# Requirements

 - Server
   - Whatever that can run a Gmod Server
   - MySQL Database
   - Linux (never tested on Windows)
 
 - Addons
   - **"My" customized playermodels** (won't work if you don't have these)
   - [My package that has everything you need to actually make this working (including playermodels)](https://mega.nz/#!UFIx3aBR!aokYXWhlVBHp-cuP-RIggVoFlryoqBDw0pjawXk22ag)
   - [Official VCMod](https://www.gmodstore.com/market/view/21)
   - WeatherMod (available in the repo)
   - TDMCars (available in the workshop, some models are already in my package)
   - My customized version of CW 1.0 (available in the repo)
   - [Extra Customizable Weaponry 1.0 - Complete pack](https://mega.nz/#!hd43ER4S!t74w7ZYT44BoY6b8ehoQ_RSCMym87-Bklb7hPobwlJw)
 
 - C++ Modules
   - Mysqloo
   - Serversecure (nothing relies on this, easily removable)
 
 - Populating the database
   - SQL file is given but you'll need to populate the database (inventory, ranks etc.) to make the gamemode working. This exercise is left to the reader ( ͡° ͜ʖ ͡°) (dig through the code)
  
## Map
The gamemode was initially made for rp_evocity_v33x, so every positions found in the code are for it. Careful if you want to change the map.
## Language
The gamemode default language is french but you can change to english by modifying the init file (shared.lua) of the gamemode, but you'll need to complete the en.lua file in the translation manager.
# Screenshots
Some screenshots can be found on my steam profile: https://steamcommunity.com/id/azzen/screenshots/

Good luck trying to make this gamemode functional again.

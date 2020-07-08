# Custom Roleplay Gamemode for Garry's Mod

It is heavily inspired by an old french closed-source gamemode that never got publicly released.

This project started a long time ago (circa 2016), you'll find legacy code, that means not everything is **secure and optimized**, deadlocks might occur since **nearly all MySQL queries are synchronous**.

Last update I made was on the 26th november 2019. Nothing was tested since.

I won't maintain this repo, feel free to fork it.

Started being updated and newer playermodels added by Crannman.
Changed French to English

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
   - **A SQL file with a populated database is provided within the sql folder, you should use this rather than populating yourself the database.**
   - Rank setup: to be superadmin set in the DB the rank field in the players table to **7**
   
## Map
The gamemode was initially made for rp_evocity_v33x, so every vectors and angles found in the code are for this map. Careful if you want to change.

## Language
The gamemode default language is french but you can change to english by modifying the config file in the translation manager module, but you'll need to complete the en.lua file located in the `lang` subdirectory.

# Screenshots
Some screenshots can be found on my steam profile: https://steamcommunity.com/id/azzen/screenshots/

Good luck trying to make this gamemode functional again and please keep in mind that this project was not initially intended to be publicly released, so it may not follow the standards regarding gmod lua and addons (especially configuration). You'll need to reverse engineer what I've done to make something **reliable, secure and stable**.

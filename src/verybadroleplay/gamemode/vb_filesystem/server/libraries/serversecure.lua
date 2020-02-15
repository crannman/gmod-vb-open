require "serversecure"

serversecure.EnableFileValidation(true)
serversecure.EnableThreadedSocket(true)
serversecure.EnablePacketValidation(true)
serversecure.EnableInfoCache(true)
serversecure.EnableFileValidation(true)

VBRP.log("Successfully loaded C++ module [serversecure]")
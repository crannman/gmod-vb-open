VBSQL = { }
VBSQL.__index = VBSQL
require("mysqloo")
local host = "localhost"
local username = "azzen"
local password = "admin1337"
local database = "vbrpgmod"
local port = 3306
local socket = "/var/run/mysqld/mysqld.sock"
DB = mysqloo.connect(host, username, password, database, port, socket)
local vb_msg = "VB-Framework::Database"

VBRP.log("Successfully loaded C++ module [mysqloo]")

function DB:onConnected()
  VBRP.log("Successfully connected to the database", vb_msg)
end

function DB:onConnectionFailed(err)
  VBRP.log("Connection to the database failed: " .. err, vb_msg)
end

DB:connect()

-- @desc Escape une string;
-- @args string str;
-- @realm Server;
-- @return string str;
function VBSQL:Escape(str)
  return DB:escape(str)
end

function VBSQL:Prepare(str)
  return DB:prepare(str)
end

-- @desc Exécute une requête SQL;
-- @args string str;
-- @realm Server;
-- @return query q;
function VBSQL:Query(str)
  --VBRP.log("Running query: " .. str, vb_msg)
  local q = DB:query(str)
  q:start()

  return q
end
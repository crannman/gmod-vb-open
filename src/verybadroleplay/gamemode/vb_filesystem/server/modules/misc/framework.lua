-- Ranks
-- 1 = U, 2 = V, 3 = S, 4 = G, 5 = M, 6 = A
--
-- @desc Ajout un rank dans la DB;
-- @args char c;
-- @realm Server
function VBRP.AddRank(c)
    query = "INSERT INTO rank(rank_name) VALUE(\"" .. c .. "\");"
    VBSQL:Query(query)
end

-- @desc Enregistre un item dans la DB;
-- @args string ItemIdentifier;
-- @realm Server
function VBRP.RegisterItemToDatabase(Item)
    query = "INSERT INTO item(name) VALUES('" .. VBSQL:Escape(Item) .. "');"
    VBSQL:Query(query)
end

-- @desc Rempli de valeurs par défaut la DB;
-- @realm Server
function VBRP.PopulateDataBase()
    for _, v in pairs(VBCLASS_ITEM.Items) do
        query = "INSERT INTO item(name) VALUES('" .. VBSQL:Escape(v["Identifier"]) .. "');"
        VBSQL:Query(query)
    end

    VBRP.AddRank("U")
    VBRP.AddRank("V")
    VBRP.AddRank("S")
    VBRP.AddRank("G")
    VBRP.AddRank("M")
    VBRP.AddRank("A")
    VBRP.AddRank("X")
end
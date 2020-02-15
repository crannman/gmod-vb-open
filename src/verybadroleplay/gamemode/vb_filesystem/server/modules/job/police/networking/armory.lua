local addNetworkString = util.AddNetworkString
local recv = net.Receive

addNetworkString("VBNET::Jobs::Police::Armory::GetWeapon")

recv("VBNET::Jobs::Police::Armory::GetWeapon", function(len, pl)

  if not pl:GetJob().AccessToArmory then return false end
  local weapon = {
    "cstm_sniper_awp",
    "cstm_rif_m4a1",
    "cstm_shotgun_spas12",
    "cstm_rif_g36c"
  }
  local validate = {
    ["cstm_sniper_awp"] = true,
    ["cstm_rif_m4a1"] = true,
    ["cstm_shotgun_spas12"] = true,
    ["cstm_rif_g36c"] = true,
  }
  local attachments = {
    ["cstm_sniper_awp"] = {},
    ["cstm_rif_m4a1"] = {
      "eotech",
      "kobra",
      "aimpoint",
      "riflereflex",
      "acog",
      "vertgrip",
      "elcan",
      "laser",
      "bipod"
    },
    ["cstm_shotgun_spas12"] = {
      "eotech",
      "kobra",
      "aimpoint",
      "riflereflex",
      "acog",
      "elcan"
    },
    ["cstm_rif_g36c"] = {
      "eotech",
      "kobra",
      "aimpoint",
      "riflereflex",
      "acog",
      "vertgrip",
      "elcan",
      "laser",
      "bipod"
    },
    
  }
  local idx = net.ReadInt(8)

  for k, v in ipairs(pl:GetWeapons()) do
    if validate[v:GetClass()] then
      pl:StripWeapon(v:GetClass())
    end
  end

  pl:Give(weapon[idx])
  pl:GiveLimitedAmmo(pl:GetWeapon(weapon[idx]))
  for k, v in ipairs(attachments[weapon[idx]]) do
    if not pl:HasAttachment(v) then
      pl:PickUpAttachment(v)
    end
  end
end)
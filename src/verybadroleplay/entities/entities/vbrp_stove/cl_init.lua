include("shared.lua")

ENT.RenderGroup = RENDERGROUP_BOTH
ENT.Debug = false

local s3d2d, e3d2d= cam.Start3D2D, cam.End3D2D
local fmt = string.format
local l2w = util.LocalToWorld
local dtex, dmtex = draw.DrawText, draw.MultiLineText
local clamp = math.Clamp
local a, v, clr, ct, rt, mat, either = Angle, Vector, Color, CurTime, RealTime, Material, Either
local sfont, sclr, srect, strect, sorect, size, smat, sline = 
  surface.SetFont, surface.SetDrawColor, surface.DrawRect, surface.DrawTexturedRect, surface.DrawOutlinedRect,
  surface.GetTextSize, surface.SetMaterial, surface.DrawLine

local chefHat = mat("verybadroleplay/icons/jobs/chef_hat.png")
local hotPlate = mat("verybadroleplay/icons/jobs/cook/hotplate.png")

function ENT:Draw()
  self:DrawModel()
end

function ENT:DrawTranslucent()
  local alpha = self:DistanceToAlpha()
  if alpha > 0  then
    
    local ang = a(0, rt() * 70, 0)
    local pos = self:GetPos() + ang:Up()
    ang:RotateAroundAxis(ang:Forward(), 90)
    ang:RotateAroundAxis(ang:Right(), 90)
    local mins, maxs = self:GetModelBounds()
    local height = maxs.Z - mins.Z
    local title = "Four"
    local text = fmt("Interagissez avec le %s pour préparer une recette", title:lower())
    local scale = 0.07

    -- start 3d2d context
    s3d2d(pos + v(0, 0, height + 5), a(0, ang.y, 90), scale)
      
      sfont("VBFONT_3D2DTEXT")
      local w, h = size(title)
      
      sfont("VBFONT_3D2DTEXT_SM")
      local w2, h2 = size(text)

      sclr(0, 0, 0, alpha)
      srect(-225, -h - 10, 450, 250)
      
      sclr(255, 144, 0, alpha)
      smat(chefHat)
      strect(-32, -48, 64, 64)
      dtex(title, "VBFONT_3D2DTEXT", 0, 15, clr(255, 144, 0, alpha), TEXT_ALIGN_CENTER )
      dmtex(text, "VBFONT_3D2DTEXT_SM", 440, 35, 0, h + 5, clr(255, 255, 255, alpha), TEXT_ALIGN_CENTER, _, _, _)
    
    e3d2d()

    ang:RotateAroundAxis( ang:Right(), 180 )

    -- start 3d2d context
    s3d2d(pos + v(0, 0, height + 5), a(0, ang.y, 90), scale)
      
      sfont("VBFONT_3D2DTEXT")
      local w, h = size(title)
      
      sfont("VBFONT_3D2DTEXT_SM")
      local w2, h2 = size(text)
      
      sclr(255, 144, 0, alpha)
      smat(chefHat)
      strect(-32, -48, 64, 64)
      dtex(title, "VBFONT_3D2DTEXT", 0, 15, clr(255, 144, 0, alpha), TEXT_ALIGN_CENTER )
      dmtex(text, "VBFONT_3D2DTEXT_SM", 440, 35, 0, h + 5, clr(255, 255, 255, alpha), TEXT_ALIGN_CENTER, _, _, _)

    e3d2d()

    local ang2 = a(0, 180, 0)
    ang2:RotateAroundAxis( ang2:Forward(), 90 )
    ang2:RotateAroundAxis( ang2:Right(), 90 )

    s3d2d(l2w(self, v(maxs.x, mins.y, maxs.z)), self:LocalToWorldAngles(a(0, 90, 90)), scale)

      sclr(0, 0, 0, alpha)
      srect(35, 60, 49 / scale, 30 / scale)

      local COLOR = either(self:GetDTPlate1(), Color(0, 230, 0), Color(230, 0, 0))
      sclr(COLOR.r, COLOR.g, COLOR.b, alpha)
      smat(hotPlate)
      strect(100, 100, 64, 64)


      local COLOR = either(self:GetDTPlate2(), Color(0, 230, 0), Color(230, 0, 0))      
      sclr(COLOR.r, COLOR.g, COLOR.b, alpha)
      smat(hotPlate)
      strect(170, 100, 64, 64)

      local COLOR = either(self:GetDTPlate3(), Color(0, 230, 0), Color(230, 0, 0))      
      sclr(COLOR.r, COLOR.g, COLOR.b, alpha)
      smat(hotPlate)
      strect(100, 170, 64, 64)

      local COLOR = either(self:GetDTPlate4(), Color(0, 230, 0), Color(230, 0, 0))      
      sclr(COLOR.r, COLOR.g, COLOR.b, alpha)
      smat(hotPlate)
      strect(170, 170, 64, 64)

      dtex(fmt("Plaques disponibles : %d/4", self:GetDTAvailablePlates()), "VBFONT_3D2DTEXT_STOVE", 240, 100, clr(255, 255, 255, alpha), TEXT_ALIGN_LEFT)

      sclr(255, 255, 255, alpha)
      sline(100, 250, 49 / scale - 10, 250)
      sline(100, 255, 49 / scale - 10, 255)
      
      if self.ActiveRecipe and self.CurrentIngredients then
        dtex(string.format("Recette en cours: %s", self.ActiveRecipe.PrettyName),
        "VBFONT_3D2DTEXT_STOVE", 100, 260, clr(255, 255, 255, alpha), TEXT_ALIGN_LEFT)
        dtex("Ingrédients:", "VBFONT_3D2DTEXT_STOVE", 100, 295, clr(255, 255, 255, alpha), TEXT_ALIGN_LEFT)
        for k,v in ipairs(self.CurrentIngredients) do
          dtex(string.format("- %s (%d/%d)", v.What, v.Quantity, v.Needed), "VBFONT_3D2DTEXT_STOVE", 100, 295 + k * 35, Either(v.Quantity == v.Needed, clr(0, 230, 0, alpha), clr(230, 0, 0, alpha)), TEXT_ALIGN_LEFT)
        end
        sclr(255, 255, 255, alpha)
        sorect(49 / scale - 60, 30 / scale - 150, 50, 200)
        local pg = (ct() * 30) % 198
        local clr = LerpColor(pg / 200, clr(230, 0, 0), clr(0, 230, 0))

        sclr(clr.r, clr.g, clr.b, alpha)
        srect( 49 / scale - 59, 30 / scale + 49, 48, -pg)
      else
        dtex("Aucune recette en cours",
        "VBFONT_3D2DTEXT_STOVE", 100, 260, clr(255, 255, 255, alpha), TEXT_ALIGN_LEFT)
      end

    e3d2d()

    if self.Debug then 
      render.SetColorMaterial()
      render.DrawWireframeSphere(l2w(self, v(-10, -11.5, 19)), 5, 10, 10, Either(self:GetDTPlate1(), Color(0, 230, 0), Color(230, 0, 0)), true)
      render.DrawWireframeSphere(l2w(self, v(-10, 11, 19)), 5, 10, 10, Either(self:GetDTPlate2(), Color(0, 230, 0), Color(230, 0, 0)), true)
      render.DrawWireframeSphere(l2w(self, v(3, -11.5, 19)), 5, 10, 10, Either(self:GetDTPlate3(), Color(0, 230, 0), Color(230, 0, 0)), true)
      render.DrawWireframeSphere(l2w(self, v(3, 11, 19)), 5, 10, 10, Either(self:GetDTPlate4(), Color(0, 230, 0), Color(230, 0, 0)), true)
    end
  end
end

local stoveIngredients = {
  ["mushrooms"]        = "Mushrooms",
  ["cabbage"]          = "Cabbage",
  ["avocado"]          = "Avocado",
  ["eggs"]             = "Eggs",
  ["vegetable_oil"]    = "Vegetable Oil",
  ["french_fries"]     = "French fries",
  ["beans"]            = "Beans",
  ["rice"]             = "Rice",
  ["salmon"]           = "Salmon",
  ["garlic"]           = "Garlic",
  ["onion"]            = "Onion",
  ["potato"]           = "Potato",
  ["tomato"]           = "Tomato",
  ["flour"]            = "Flour",
  ["horse"]            = "Horse",
  ["beef"]             = "Beef",
  ["pork"]             = "Pork",
  ["chicken"]          = "Chicken",
  ["sheep"]            = "Sheep",
  ["milk"]             = "Milk",
  ["swiss_cheese"]     = "Swiss cheese",
  ["blue_cheese"]      = "Blue cheese",
}

net.Receive("VBNET::Jobs::Cook::Recipes::UpdateStoveRecipe", function(len, pl)

  local food = net.ReadTable()
  local stove = net.ReadEntity()
  stove.ActiveRecipe = food
  stove.CurrentIngredients = {}
  for k,v in ipairs(food.Recipe) do
    table.insert(stove.CurrentIngredients, { Quantity = 0, What = stoveIngredients[v.What], Needed = v.Quantity })
  end

end)
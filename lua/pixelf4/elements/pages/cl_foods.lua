--[[
-----------------------------------------------------------
                    Informations
-----------------------------------------------------------
Ce fichier provient du site web https://aide-serveur.fr/ et a été publié par Autorun__.
Toute republication sur un site autre que https://aide-serveur.fr/ est autorisée uniquement avec l'accord préalable de Discord : autorun__ (Serveur Discord : Discord.gg/GgH8eKmFpt).
Le créateur du serveur préconfiguré est Autorun__ (Serveur Discord : Discord.gg/GgH8eKmFpt).
Toute revente est strictement interdite, car celui-ci est téléchargeable gratuitement sur https://aide-serveur.fr/.
-----------------------------------------------------------
--]]

--[[
    PIXEL F4
    Copyright (C) 2021 Tom O'Sullivan (Tom.bat)

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License.
    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.
    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
]]

local PANEL = {}

surface.CreateFont("FoodFont1", {
    font = "Open Sans SemiBold",
    extended = false,
    size = PIXEL.Scale(20),
    weight = PIXEL.Scale(500)
})

local localPly

local function canBuyFood(food)

    if (food.requiresCook == nil or food.requiresCook == true) and not localPly:isCook() then return false, true end
    if food.customCheck and not food.customCheck(localPly) then return false, false end

    if not localPly:canAfford(food.price) then return false, false end

    return true

end

local function shouldShow(item)
    local canBuy, important = canBuyFood(item)
    return not ((not canBuy) and (GAMEMODE.Config.hideNonBuyable or (important and GAMEMODE.Config.hideTeamUnbuyable)))
end

function PANEL:Init()
    localPly = LocalPlayer()
    self:Populate(self.Scroller:GetCanvas())

    hook.Add("OnPlayerChangedTeam", self, function(s, ply)
        if ply ~= localPly then return end
        self:Populate(self.Scroller:GetCanvas())
    end)
end

function PANEL:Populate(canvas, searchTerm)
    canvas:Clear()
    table.Empty(self.Categories)

    local vLayout = vgui.Create("DIconLayout", canvas)
    vLayout:Dock(FILL)
    vLayout:DockMargin(PIXEL.Scale(10), PIXEL.Scale(10), PIXEL.Scale(10), PIXEL.Scale(10))
    vLayout:SetSpaceY(PIXEL.Scale(10))
    vLayout:SetSpaceX(PIXEL.Scale(10))

    for i, t in ipairs(FoodItems) do
        
        if not shouldShow(t) then continue end

        local vFood = vgui.Create("DButton", vLayout)
        vFood:SetSize(PIXEL.Scale(392), PIXEL.Scale(100))
        vFood:SetText("")
        function vFood:Paint(w, h)
        
            draw.RoundedBox(0, 0, 0, w, h, (self:IsHovered() and Color(40, 40, 40) or Color(30, 30, 30)))
            draw.RoundedBox(0, PIXEL.Scale(15), PIXEL.Scale(15), PIXEL.Scale(70), PIXEL.Scale(70), Color(20, 20, 20))
        
            draw.SimpleText(t.name, "FoodFont1", PIXEL.Scale(100), PIXEL.Scale(30), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)
            draw.SimpleText(("Prix: %s"):format(DarkRP.formatMoney(t.price)), "FoodFont1", PIXEL.Scale(100), PIXEL.Scale(50), color_white, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP)

        end
        function vFood:DoClick()
            RunConsoleCommand("DarkRP", "buyfood", t.name)
        end

        local vSpawnIcon = vgui.Create("SpawnIcon", vFood)
        vSpawnIcon:SetSize(PIXEL.Scale(60), PIXEL.Scale(60))
        vSpawnIcon:SetPos(PIXEL.Scale(20), PIXEL.Scale(20))
        vSpawnIcon:SetModel(t.model)
        vSpawnIcon:SetModelName(" ")
        vSpawnIcon.PaintOver = nil
        vSpawnIcon.DoClick = vFood.DoClick

    end

end

vgui.Register("PIXEL.F4.Food", PANEL, "PIXEL.F4.ItemPage")
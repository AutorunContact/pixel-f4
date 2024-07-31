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

local colors = PIXEL.F4.Colors.Item

local PANEL = {}

AccessorFunc(PANEL, "sCommand", "Command", FORCE_STRING)

function PANEL:SetItem(ship)
    self:SetModel(ship.model)
    self:SetTitle(ship.name .. " (x" .. ship.amount .. ")", "F4.ItemTitle", colors.Title)
    self:SetSubText("Price: " .. PIXEL.FormatMoney(ship.price), "F4.ItemSubText", colors.SubText)
    self:SetCommand(ship.name)
    self.ModelBackgroundCol = colors.ModelBackground
end

function PANEL:DoClick()
    RunConsoleCommand("DarkRP", "buyshipment", self:GetCommand())
end

vgui.Register("PIXEL.F4.Shipment", PANEL, "PIXEL.F4.Item")
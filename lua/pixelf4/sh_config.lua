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

PIXEL.F4.Config = {
    MenuTitle = "Autorun", -- NOM DU SERVEUR
    SidebarLogo = "M9sum9O", -- LOGO DU SERVEUR (UPLOAD L'IMAGE SUR : https://imgur.com/) EXEMPLE : https://i.imgur.com/M9sum9O.jpg PRENEZ UNIQUEMENT "M9sum9O"
    Announcement = false,
    WebsiteLinks = {
        [1] = {
            Name = "Rewards",
            ChatCommand = "!rewards",
            ImgurID = "HxsUUz2"
        },
        [2] = {
            Name = "Règlement",
            Link = "https://google.com",
            ImgurID = "0aWOlMI"
        },
        [3] = {
            Name = "Discord",
            Link = "https://discord.gg/GgH8eKmFpt",
            ImgurID = "EtvPE3C"
        },
        [4] = {
            Name = "Forum",
            Link = "https://google.com",
            ImgurID = "8ey54bc"
        },
        [5] = {
            Name = "Shop",
            Link = "https://google.com",
            ImgurID = "jbp3ZT5"
        }
    },
    Commands = {
        {
            Name = "Vendre toutes les portes",
            Func = function()
                RunConsoleCommand("say", "/sellalldoors")
            end
        },
        {
            Name = "Jeter de l'argent",
            Func = function()
                PIXEL.F4.ToggleMenu()
                Derma_StringRequest("Drop Money", "Drop an amount of money:", "100", function(txt)
                    RunConsoleCommand("say", "/dropmoney " .. txt or "")
                end )
            end
        },
        {
            Name = "Changer de nom",
            Func = function()
                PIXEL.F4.ToggleMenu()
                Derma_StringRequest("Change Name", "Change your Roleplay name (Leave Blank for your Steam name):", LocalPlayer():Nick(), function(txt)
                    RunConsoleCommand("say", "/rpname " .. Either(#txt >= 2, txt, LocalPlayer():SteamName()))
                end )
            end
        },
        {
            Name = "Diffusion",
            Func = function()
                PIXEL.F4.ToggleMenu()
                Derma_StringRequest("Change Name", "Change your Roleplay name (Leave Blank for your Steam name):", LocalPlayer():Nick(), function(txt)
                    RunConsoleCommand("say", "/rpname " .. Either(#txt >= 2, txt, LocalPlayer():SteamName()))
                end )
            end,
            CanSee = function()
                return LocalPlayer():isMayor()
            end
        }
    },
    WeaponOverrides = {
        ["weapon_bugbait"] = {
            WorldModel = "models/weapons/w_bugbait.mdl",
            PrintName = "Bug Bait"
        }
    }
}

if SERVER then return end

PIXEL.F4.Config.RankTags = {
    [PIXEL.RankTags.VIP] = {"vip", PIXEL.Colors.Gold},
    [PIXEL.RankTags.VIP_PLUS] = {"VIP+", "rainbow"},
    [PIXEL.RankTags.STAFF] = {"Staff Only", PIXEL.Colors.Negative}
}
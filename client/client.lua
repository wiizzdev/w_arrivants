    -- G_Corporation -- wiizz -- 
  -- https://github.com/wiizzdev --
 -- https://discord.gg/VpYP58ZjmD --

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end
end)

local mainMenu = RageUI.CreateMenu("", "Menu d'Aide")
local reseau = RageUI.CreateSubMenu(mainMenu, "", "Réseaux")
local touche = RageUI.CreateSubMenu(mainMenu, "", "Touches")
local commandes = RageUI.CreateSubMenu(mainMenu, "", "Commandes")
local open = false

mainMenu.Closed = function() open = false end

function Arrivants()
    if not open then open = true RageUI.Visible(mainMenu, true)
        CreateThread(function()
            while open do 
                RageUI.IsVisible(mainMenu, function()
                    RageUI.Button("Réseaux", nil, {RightLabel = "→"}, true, {}, reseau)
                    RageUI.Button("Touches", nil, {RightLabel = "→"}, true, {}, touche)
                    RageUI.Button("Commandes", nil, {RightLabel = "→"}, true, {}, commandes)
                    RageUI.Separator("ID~s~ : "..GetPlayerServerId(PlayerId()))
                    RageUI.Separator("Nom Steam : "..GetPlayerName(PlayerId()))
                end)
                RageUI.IsVisible(reseau, function()
                    for _,v in pairs(Config.Reseaux) do 
                        RageUI.Button(v.name, nil, {RightLabel = "→"}, true, {
                            onSelected = function()
                                ESX.ShowAdvancedNotification("Réseaux", "Info", v.info, v.char, 7)
                                PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
                            end
                        })
                    end        
                end)
                RageUI.IsVisible(touche, function()
                    for _,v in pairs(Config.Touches) do RageUI.Button(v.name, nil, {RightLabel = v.touche}, true, {}) end
                end)
                RageUI.IsVisible(commandes, function()
                    for _,v in pairs(Config.Commandes) do RageUI.Button(v.name, v.desc, {RightLabel = v.commande}, true, {}) end
                end)
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    while true do
        ESX.ShowAdvancedNotification("Besoin d'Aide", "Infos", "Vous avez besoin d'Aide ? Un doute sur les touches ? Faites la commande /help", "CHAR_GAYMILITARY", 1)
    Wait(2000000)
    end
end)

RegisterCommand("help", function()
    Arrivants()
end)
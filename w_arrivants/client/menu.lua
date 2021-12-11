    -- G_Corporation -- wiizz -- 
  -- https://github.com/wiizzdev --

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end
end)

local mainMenu = RageUI.CreateMenu("Menu Arrivants", "MENU") -- menu principal
local reseau = RageUI.CreateSubMenu(mainMenu, "Réseaux", "MENU") -- sous-menu réseau
local touche = RageUI.CreateSubMenu(mainMenu, "Touches", "MENU") -- sous-menu touche
local commandes = RageUI.CreateSubMenu(mainMenu, "Commandes", "MENU") -- sous-menu touche
local gps = RageUI.CreateSubMenu(mainMenu, "GPS", "MENU") -- sous-menu touche
local open = false

mainMenu.Display.Glare = true -- afficher la planète sur la bannière ?

mainMenu.X = 0 -- position x du menu (1450 pour la droite de l'écran)
mainMenu.Y = 0 -- position y du menu (780 pour le bas de l'écran)

mainMenu.Closed = function() 
    open = false 
end 

function arrivants() -- fonction principale
    if open then 
        open = false 
            RageUI.Visible(mainMenu, false) 
        return 
    else 
        open = true 
            RageUI.Visible(mainMenu, true)
            CreateThread(function()
                while open do 
                    RageUI.IsVisible(mainMenu, function()
                        RageUI.Button("Réseaux", "Ouvrir le menu Réseaux", {RightLabel = "→"}, true, {}, reseau) -- bouton dans le menu principal pour ouvrir le menu réseaux
                        RageUI.Button("Touches", "Ouvrir le menu Touches", {RightLabel = "→"}, true, {}, touche) -- bouton dans le menu principal pour ouvrir le menu touche
                        RageUI.Button("Commandes", "Ouvrir le menu Commandes", {RightLabel = "→"}, true, {}, commandes) -- bouton dans le menu principal pour ouvrir le menu commandes
                        RageUI.Button("GPS", "Ouvrir le menu GPS", {RightLabel = "→"}, true, {}, gps) -- bouton dans le menu principal pourouvrir le menu gps
                        RageUI.Separator("ID~s~ : " ..GetPlayerServerId(PlayerId())) -- afficher votre id en bas du menu principal
                        RageUI.Separator("Nom Steam : " ..GetPlayerName(PlayerId())) -- afficher votre pseudo en bas du menu principal   
                    end)

                    RageUI.IsVisible(reseau, function()
                        RageUI.Button("Discord", "Afficher le lien du Discord", {RightLabel = "→"}, true, { -- bouton dans le menu réseau pour afficher le lien du discord
                            onSelected = function()
                                ESX.ShowAdvancedNotification("Réseaux", "Info", "Lien du discord: ~b~https://discord.gg/VpYP58ZjmD", "CHAR_AMANDA", 7) -- contenue de la notif
                                PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1) -- "nom du son" / "ref du son"
                            end
                        })                   
                        RageUI.Button("YouTube", "Afficher le lien de la chaîne YouTube", {RightLabel = "→"}, true, { -- bouton dans le menu réseau pour afficher le lien de la chaîne youtube
                            onSelected = function()
                                ESX.ShowAdvancedNotification("Réseaux", "Info", "Lien de la chaîne: ~r~https://www.youtube.com/channel/UCzQJfF4N7fvi66EkRJvjwOQ", "CHAR_YOUTUBE", 7) -- contenue de la notif
                                PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1) -- "nom du son" / "ref du son"
                            end
                        })
                        RageUI.Separator("discord.gg/VpYP58ZjmD") -- afficher le lien du discord en bas du menu réseaux
                    end)

                    RageUI.IsVisible(touche, function()
                        RageUI.Button("Téléphone", nil, {RightLabel = "F1"}, true, {}) -- bouton du menu touche
                        RageUI.Button("Menu Intéraction", nil, {RightLabel = "F5"}, true, {}) -- bouton du menu touche
                        RageUI.Button("Menu Emote", nil, {RightLabel = "F3"}, true, {}) -- bouton du menu touche
                        RageUI.Button("Ceinture", nil, {RightLabel = "K"}, true, {}) -- bouton du menu touche
                        RageUI.Button("Coffre", nil, {RightLabel = "J"}, true, {}) -- bouton du menu touche
                        RageUI.Button("Lever les mains", nil, {RightLabel = "²"}, true, {}) -- bouton du menu touche
                        RageUI.Button("Radio", nil, {RightLabel = "F2"}, true, {}) -- bouton du menu touche
                        RageUI.Button("Menu Job", nil, {RightLabel = "F6"}, true, {}) -- bouton du menu touche
                        RageUI.Button("Menu Orga", nil, {RightLabel = "F7"}, true, {}) -- bouton du menu touche
                        RageUI.Separator("discord.gg/VpYP58ZjmD") -- afficher le lien du discord en bas du menu touche
                    end)
                    RageUI.IsVisible(commandes, function()      
                        RageUI.Button("Signalement", "Signaler un joueur", {RightLabel = "/report"}, true, {}) -- bouton du menu commandes pour monter la commande /report
                        RageUI.Button("Aide", "Ouvrir le menu arrivants", {RightLabel = "/help"}, true, {}) -- bouton du menu commandes pour monter la commande /help
                        RageUI.Separator("discord.gg/VpYP58ZjmD") -- afficher le lien du discord en bas du menu commandes
                    end)
                    RageUI.IsVisible(gps, function()
                        RageUI.Button("Travail ?", "Aller au Pôle Emploi", {RightLabel = "→"}, true, { -- bouton dans le menu gps pour mettre un point au pole emploie
                            onSelected = function()
                                ESX.ShowAdvancedNotification("GPS", "Pôle Emploi", "Position marquée sur votre GPS", "CHAR_AGENT14", 7) -- contenue de la notif
                                PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1) -- "nom du son" / "ref du son"
                                SetNewWaypoint(-268.22, -962.69, 31.22) -- coordonnées du marqueur sur la map du pôle emploi
                            end
                        })
                        RageUI.Button("Argent ?", "Aller a la Banque Principale", {RightLabel = "→"}, true, { -- bouton dans le menu gps pour mettre un point a la banque principale
                            onSelected = function()
                                ESX.ShowAdvancedNotification("GPS", "Banque", "Position marquée sur votre GPS", "CHAR_BANK_FLEECA", 7) -- contenue de la notif
                                PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1) -- "nom du son" / "ref du son"
                                SetNewWaypoint(243.55, 224.55, 106.29) -- coordonnées du marqueur sur la map de la banque
                            end
                        })
                        RageUI.Button("Nourriture ?", "Aller a une supérette", {RightLabel = "→"}, true, { -- bouton dans le menu gps pour mettre un point sur une supérette
                            onSelected = function()
                                ESX.ShowAdvancedNotification("GPS", "Supérette", "Position marquée sur votre GPS", "CHAR_DAVE", 7) -- contenue de la notif
                                PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1) -- "nom du son" / "ref du son"
                                SetNewWaypoint(-48.52, -1757.51, 29.42) -- coordonnées du marqueur sur la map de la supérette la plus proche de l'aéroport
                            end
                        })
                    end)
                Wait(0)
            end
        end)
    end
end

RegisterCommand("help", function(source, args, rawcommand) -- /help pour ouvrir le menu arrivants
    arrivants() -- nom de la fonction principale
end, false)

Keys.Register('F1', 'F1', 'Ouvrir le menu arrivants', function() -- touche par défaut pour ouvrir le menu
    arrivants() -- nom de la fonction principale
end)

--[[ Configuration ]]--
j_sound.config.MethodeOuverture = 1 -- (1: ChatCommand / 2: ContextMenu / 3: Touche au choix)

if j_sound.config.MethodeOuverture == 1 then -- Configuration ChatCommand (NE PAS TOUCHER CETTE LIGNE)
    j_sound.config.ChatCommand = "/sound" -- la commande a entrer dans le chat pour ouvrir le sound menu
    j_sound.config.Titre = "Sound Menu [F3]"
    j_sound.config.TitrePosition = 20 -- Positionnement vertical du titre
    j_sound.config.F3_Fix = false -- Mettre en true seulement si F3 ne fonctionne pas !!!
elseif j_sound.config.MethodeOuverture == 2 then -- Configuration ContextMenu (NE PAS TOUCHER CETTE LIGNE)
    j_sound.config.Titre = "Sound Menu"
    j_sound.config.TitrePosition = 40 -- Positionnement vertical du titre
elseif j_sound.config.MethodeOuverture == 3 then -- Configuration Touche au choix (NE PAS TOUCHER CETTE LIGNE)
    j_sound.config.Touche = 96 -- http://wiki.garrysmod.com/page/Enums/BUTTON_CODE
    j_sound.config.Titre = "Sound Menu [F5]"
    j_sound.config.TitrePosition = 20 -- Positionnement vertical du titre
end -- (NE PAS TOUCHER CETTE LIGNE)

j_sound.config.CouleurTitre = Color(150, 150, 150, 255)
j_sound.config.Hauteur = "400" -- Hauteur du sound menu
j_sound.config.Position = "Droite" -- "Droite" ou "Gauche"
j_sound.config.Couleur = Color(30, 144, 255, 145) -- Couleur des lignes du sound menu
j_sound.config.AntiSpam = 0.8 -- Secondes pour relancer un son

--[[ Liste des sons (CONFIGURABLE) ]]--
j_sound.add[1] = { -- id unique
    sound_name = "Excuse me", -- nom du son
    sound_path = "vo/npc/female01/excuseme01.wav", -- chemin du son
    methode = 1, -- (1: emit le son sur le joueur qui clique dessus, 2: lancer le son sur tous les joueurs)
    allowed = function()
        return j_sound.allowed(LocalPlayer(), { -- les jobs autoriser a utilisé le sound menu
            [TEAM_CITIZEN] = true,
            [TEAM_POLICE] = true
        }, { -- les ranks autoriser a utilisé le sound menu
            ["superadmin"] = true,
            ["admin"] = true
        })
    end
}

-- Exemple: Juste pour plusieurs job
j_sound.add[2] = {
    sound_name = "Finally",
    sound_path = "vo/npc/female01/finally.wav",
    methode = 1,
    allowed = function()
        return j_sound.allowed(LocalPlayer(), {
            [TEAM_CITIZEN] = true,
            [TEAM_POLICE] = true
        }, {
         -- ["superadmin"] = true
        })
    end
}

-- Exemple: Juste pour un job
j_sound.add[3] = {
    sound_name = "Hacks",
    sound_path = "vo/npc/male01/hacks01.wav",
    methode = 1,
    allowed = function()
        return j_sound.allowed(LocalPlayer(), {
            [TEAM_POLICE] = true
        }, {
         -- ["superadmin"] = true
        })
    end
}

-- Exemple: Juste pour un rank
j_sound.add[4] = {
    sound_name = "Get Down",
    sound_path = "vo/npc/female01/getdown02.wav",
    methode = 2,
    allowed = function()
        return j_sound.allowed(LocalPlayer(), {
         -- [TEAM_CITIZEN] = true
            }, {
            ["superadmin"] = true
        })
    end
}

-- Exemple: Juste pour plusieurs ranks
j_sound.add[5] = {
    sound_name = "Ok",
    sound_path = "vo/npc/female01/ok02.wav",
    methode = 2,
    allowed = function()
        return j_sound.allowed(LocalPlayer(), {
         -- [TEAM_CITIZEN] = true
            }, {
            ["superadmin"] = true,
            ["admin"] = true
        })
    end
}

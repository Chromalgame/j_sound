--[[ Configuration ]]--
j_sound.config.ContextMenu = true -- Ouvrir le sound menu avec le contexte menu a la place du ChatCommand

if j_sound.config.ContextMenu == true then -- Ne pas toucher !!!
	j_sound.config.Titre = "Sound Menu"
	j_sound.config.TitrePosition = 40 -- Positionnement vertical du titre (ContextMenu)
else
	j_sound.config.ChatCommand = "/sound" -- la commande a entrer dans le chat pour ouvrir le sound menu
	j_sound.config.Titre = "Sound Menu [F3]"
	j_sound.config.TitrePosition = 20 -- Positionnement vertical du titre (ChatCommand)
end

j_sound.config.CouleurTitre = Color(150, 150, 150, 255)
j_sound.config.Hauteur = "400" -- Hauteur du sound menu
j_sound.config.Position = "Droite" -- "Droite" ou "Gauche"
j_sound.config.Couleur = Color(30, 144, 255, 145) -- Couleur des lignes du sound menu
j_sound.config.AntiSpam = 0.8 -- Secondes pour relancer un son
j_sound.config.F3_Fix = false -- Mettre en true seulement si F3 ne fonctionne pas !!!

--[[ Liste des sons (CONFIGURABLE) ]]--
j_sound.add[1] = { -- id unique
	sound_name = "Excuse me", -- nom du son
	sound_path = "vo/npc/female01/excuseme01.wav", -- chemin du son
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
	allowed = function()
		return j_sound.allowed(LocalPlayer(), {
		 -- [TEAM_CITIZEN] = true
			}, {
			["superadmin"] = true,
			["admin"] = true
		})
	end
}

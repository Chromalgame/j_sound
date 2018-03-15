--[[ Configuration ]]--
j_sound.config.ContextMenu = false -- Ouvrir le menu avec le contexte menu a la place du ChatCommand
if j_sound.config.ContextMenu == true then
	j_sound.config.Titre = "Sound Menu"
	j_sound.config.TitrePosition = 40 -- Positionnement vertical du titre
else
	j_sound.config.ChatCommand = "/sound" -- la commande a entrer dans le chat pour ouvrir le menu
	j_sound.config.Titre = "Sound Menu [F3]"
	j_sound.config.TitrePosition = 20 -- Positionnement vertical du titre
end
j_sound.config.CouleurTitre = Color(150, 150, 150, 255)
j_sound.config.Hauteur = "400" -- Hauteur du menu
j_sound.config.Position = "Droite" -- "Droite" ou "Gauche"
j_sound.config.Couleur = Color(30, 144, 255, 145) -- Couleur des lignes du menu
j_sound.config.AntiSpam = 0.8 -- Secondes pour relancer un son
j_sound.config.F3_Fix = false -- Mettre en true seulement si F3 ne fonctionne pas !!!
j_sound.config.WhiteList = false -- true = seuls les jobs dans WhiteListJobs peuvent ouvrir le menu
j_sound.config.WhiteListJobs = {TEAM_CITIZEN, TEAM_POLICE} -- a ignorer si vous laissé WhiteList = false !

--[[ Liste des sons (CONFIGURABLE) ]]--
j_sound.add[1] = { -- unique id
	sound_name = "Excuse me", -- nom du son
    sound_path = "vo/npc/female01/excuseme01.wav", -- chemin du son
    allowed = function() return j_sound.allowed(LocalPlayer(), {TEAM_CITIZEN, TEAM_POLICE}, {"superadmin", "admin"}) end -- Ajouter les jobs/ranks autoriser a utilisé le son 
}
-- Exemple: Juste pour plusieurs job
j_sound.add[2] = {
	sound_name = "Finally",
    sound_path = "vo/npc/female01/finally.wav",
    allowed = function() return j_sound.allowed(LocalPlayer(), {TEAM_CITIZEN, TEAM_POLICE}, {}) end
}
-- Exemple: Juste pour un job
j_sound.add[3] = {
	sound_name = "Hacks",
    sound_path = "vo/npc/male01/hacks01.wav",
    allowed = function() return j_sound.allowed(LocalPlayer(), {TEAM_POLICE}, {}) end
}
-- Exemple: Juste pour un rank
j_sound.add[4] = {
	sound_name = "Get Down",
    sound_path = "vo/npc/female01/getdown02.wav",
    allowed = function() return j_sound.allowed(LocalPlayer(), {}, {"superadmin"}) end
}
-- Exemple: Juste pour plusieurs ranks
j_sound.add[5] = {
	sound_name = "Ok",
    sound_path = "vo/npc/female01/ok02.wav",
    allowed = function() return j_sound.allowed(LocalPlayer(), {}, {"superadmin", "admin"}) end
}

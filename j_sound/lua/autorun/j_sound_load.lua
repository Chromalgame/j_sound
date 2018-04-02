j_sound = {}
j_sound.config = {}
j_sound.add = {}
j_sound.allowed = {}
AddCSLuaFile()

function j_sound.allowed(ply, team, rank)
    if team[ply:Team()] || rank[ply:GetUserGroup()] then return true end
end

if SERVER then
    util.AddNetworkString("j_sound_emit")
    util.AddNetworkString("j_sound_open_close")
    util.AddNetworkString("j_sound_playsound")
    AddCSLuaFile("j_sound/configuration.lua")
    include("j_sound/configuration.lua")
    AddCSLuaFile("j_sound/cl_j_sound.lua")
    include("j_sound/sv_j_sound.lua")
else
    include("j_sound/configuration.lua")
    include("j_sound/cl_j_sound.lua")
end

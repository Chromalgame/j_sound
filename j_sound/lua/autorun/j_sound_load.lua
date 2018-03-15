j_sound = {}
j_sound.config = {}
j_sound.add = {}
j_sound.allowed = {}

function j_sound.allowed(ply, team, rank)
    if table.HasValue(team, ply:Team()) or table.HasValue(rank, ply:GetUserGroup()) then return true end
end

if SERVER then
    util.AddNetworkString("j_sound_emit")
    AddCSLuaFile("j_sound/cl_j_sound.lua")
    AddCSLuaFile("j_sound/configuration.lua")
    include("j_sound/configuration.lua")
    include("j_sound/sv_j_sound.lua")
else
    include("j_sound/configuration.lua")
    include("j_sound/cl_j_sound.lua")
end

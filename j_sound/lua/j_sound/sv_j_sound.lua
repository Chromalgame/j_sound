net.Receive("j_sound_emit", function(len, ply)
    if ply.StopSpam && ply.StopSpam > CurTime() then return end
    if !ply:Alive() || !ply:IsValid() then return end
    local tableNumber = net.ReadUInt(32)
    ply:EmitSound(j_sound.add[tableNumber].sound_path, 80, 100)
    ply.StopSpam = CurTime() + j_sound.config.AntiSpam
end)

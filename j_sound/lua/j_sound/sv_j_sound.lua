net.Receive("j_sound_emit", function(len, ply)
    if ply.StopSpam and ply.StopSpam > CurTime() then return end
    if not ply:Alive() or not ply:IsValid() then return end
    local tableNumber = net.ReadUInt(32)
    ply:EmitSound(j_sound.add[tableNumber].sound_path, 80, 100)
    ply.StopSpam = CurTime() + j_sound.config.AntiSpam
end)
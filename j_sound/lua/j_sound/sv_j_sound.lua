net.Receive("j_sound_emit", function(len, ply)
	local tableNumber = net.ReadUInt(32)
    if (!ply:Alive() || !ply:IsValid()) || (ply.StopSpam && ply.StopSpam > CurTime()) then return end
    ply:EmitSound(j_sound.add[tableNumber].sound_path, 80, 100)
    ply.StopSpam = CurTime() + j_sound.config.AntiSpam
end)

if j_sound.config.MethodeOuverture == 3 then
	hook.Add( "PlayerButtonDown", "SoundMenu.OpenClose.Touche", function(ply, btn) 
		if !ply:Alive() || !ply:IsValid() then return end
		if ( btn == j_sound.config.Touche ) then
			net.Start("j_sound_open_close")
			net.Send(ply)
		end
	end)
end

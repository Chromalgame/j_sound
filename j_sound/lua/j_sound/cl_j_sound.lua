function j_sound.Menu()
    if IsValid(j_sound.SoundFrame) && j_sound.SoundFrame:IsVisible() then return end

    if string.lower(j_sound.config.Position) == "gauche" then
        j_sound.Frame_Pos = -200
        j_sound.MoveTo_Open = 0
    elseif string.lower(j_sound.config.Position) == "droite" then
        j_sound.Frame_Pos = ScrW() + 200
        j_sound.MoveTo_Open = ScrW() - 200
    end

    j_sound.SoundFrame = vgui.Create("DFrame")
    j_sound.SoundFrame:SetSize(200, j_sound.config.Hauteur)
    j_sound.SoundFrame:SetPos(j_sound.Frame_Pos, (ScrH() / 2) - (j_sound.SoundFrame:GetTall() / 2))
    j_sound.SoundFrame:SetTitle("")
    j_sound.SoundFrame:SetDraggable(false)
    j_sound.SoundFrame:ShowCloseButton(false)
    j_sound.SoundFrame:MoveTo(j_sound.MoveTo_Open, (ScrH() / 2) - (j_sound.SoundFrame:GetTall() / 2), .4, 0, -1)

    if j_sound.config.MethodeOuverture == 2 then
        j_sound.SoundFrame:MakePopup()
    elseif j_sound.config.MethodeOuverture == 1 then
        j_sound.SoundFrame:SetKeyboardInputEnabled(false)
    elseif j_sound.config.MethodeOuverture == 3 then
        j_sound.SoundFrame:MakePopup()
        j_sound.SoundFrame:SetKeyboardInputEnabled(false)
    end

    j_sound.SoundFrame.Paint = function(self, w, h)
        surface.SetDrawColor(Color(28, 26, 29, 245))
        surface.DrawRect(0, 0, w, h)
        surface.SetDrawColor(j_sound.config.Couleur)
        surface.DrawOutlinedRect(0, 0, w, h)
    end

    local SoundFrameClose = vgui.Create("DButton", j_sound.SoundFrame)
    SoundFrameClose:SetSize(20, 20)
    SoundFrameClose:SetPos(j_sound.SoundFrame:GetWide() - 20, 0)
    SoundFrameClose:SetText("")

    SoundFrameClose.Paint = function(self, w, h)
        if SoundFrameClose:IsDown() then
            draw.SimpleText("x", "Trebuchet24", w / 2, (h / 2) + 1, Color(175, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        elseif SoundFrameClose:IsHovered() then
            draw.SimpleText("x", "Trebuchet24", w / 2, h / 2, Color(175, 0, 0), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        else
            draw.SimpleText("x", "Trebuchet24", w / 2, h / 2, Color(150, 150, 150), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
        end
    end

    SoundFrameClose.DoClick = function()
        j_sound.SoundFrame:MoveTo(j_sound.Frame_Pos, ScrH() / 2 - j_sound.SoundFrame:GetTall() / 2, .4, 0, -1, function()
            j_sound.SoundFrame:Remove()
            gui.EnableScreenClicker(false)
        end)
    end

    local SoundDScrollPanel = vgui.Create("DScrollPanel", j_sound.SoundFrame)
    SoundDScrollPanel:Dock(FILL)
    SoundDScrollPanel:DockMargin(0, 2, 0, 0)

    SoundDScrollPanel.VBar.Paint = function(self, w, h)
        draw.RoundedBox(0, 4, 0, 8, h, j_sound.config.Couleur)
    end

    SoundDScrollPanel.VBar.btnUp.Paint = function(self, w, h)
        draw.RoundedBox(0, 4, 0, 8, h + 22, Color(5, 5, 5, 205))
        draw.SimpleText("↑", "Trebuchet18", w / 2, (h / 2) + 1, j_sound.config.Couleur, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    SoundDScrollPanel.VBar.btnDown.Paint = function(self, w, h)
        draw.RoundedBox(0, 4, 0, 8, h + 22, Color(5, 5, 5, 205))
        draw.SimpleText("↓", "Trebuchet18", w / 2, (h / 2) - 6, j_sound.config.Couleur, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

    SoundDScrollPanel.VBar.btnGrip.Paint = function(self, w, h)
        draw.RoundedBox(0, 6, 0, 4, h + 22, Color(5, 5, 5, 205))
    end

    local SoundFrameText = vgui.Create("DLabel", j_sound.SoundFrame)
    SoundFrameText:SetFont("Trebuchet24")
    SoundFrameText:SetText(j_sound.config.Titre)
    SoundFrameText:SetPos(j_sound.config.TitrePosition, 4)
    SoundFrameText:SizeToContents()

    SoundFrameText.Paint = function(self, w, h)
        self:SetColor(j_sound.config.CouleurTitre)
    end

    for k, v in pairs(j_sound.add) do
        if !v.allowed() then continue end
        j_sound.Boutton = SoundDScrollPanel:Add("DButton")
        j_sound.Boutton:SetText(v.sound_name)
        j_sound.Boutton:SetTextColor(Color(150, 150, 150))
        j_sound.Boutton:Dock(TOP)
        j_sound.Boutton:DockMargin(0, 0, 1, 5)

        j_sound.Boutton.Paint = function(self, w, h)
            surface.SetDrawColor(28, 26, 29, 245)
            surface.DrawRect(0, 0, w, h)

            if self:IsHovered() then
                surface.SetDrawColor(0, 255, 0, 145)
            else
                surface.SetDrawColor(j_sound.config.Couleur)
            end

            surface.DrawOutlinedRect(0, 0, w, h)
        end

        j_sound.Boutton.DoClick = function()
            if v.methode == 1 then
                net.Start("j_sound_emit")
                net.WriteUInt(k, 32)
                net.SendToServer()
            elseif v.methode == 2 then
                net.Start("j_sound_playsound")
                net.WriteUInt(k, 32)
                net.SendToServer()
            end
        end
    end
    if !IsValid(j_sound.Boutton) then
        j_sound.SoundFrame:Remove()
    end
end

if j_sound.config.MethodeOuverture == 2 then
    hook.Add("OnContextMenuOpen", "SoundMenu.Open.ContextMenu", function()
        if IsValid(j_sound.SoundFrame) then return end
        j_sound.Menu()
    end)

    hook.Add("OnContextMenuClose", "SoundMenu.Close.ContextMenu", function()
        if IsValid(j_sound.SoundFrame) && j_sound.SoundFrame:IsVisible() then
            j_sound.SoundFrame:MoveTo(j_sound.Frame_Pos, ScrH() / 2 - j_sound.SoundFrame:GetTall() / 2, .4, 0, -1, function()
                j_sound.SoundFrame:Remove()
            end)
        end
    end)
elseif j_sound.config.MethodeOuverture == 1 then
    hook.Add("OnPlayerChat", "SoundMenu.Open.Chat", function(ply, str)
        if (ply != LocalPlayer()) || !ply:IsValid() then return end

        if string.lower(str) == j_sound.config.ChatCommand then
            j_sound.Menu()

            return true
        end
    end)
    if j_sound.config.F3_Fix == true then
        hook.Add("Think", "F3.EnableScreenClicker", function()
            gui.EnableScreenClicker(input.IsKeyDown(KEY_F3))
        end)
    end
end

net.Receive("j_sound_playsound",function()
    local tableNumber = net.ReadUInt(32)
    surface.PlaySound(j_sound.add[tableNumber].sound_path)
end)

net.Receive("j_sound_open_close",function()
    if IsValid(j_sound.SoundFrame) && j_sound.SoundFrame:IsVisible() then
        j_sound.SoundFrame:MoveTo(j_sound.Frame_Pos, ScrH() / 2 - j_sound.SoundFrame:GetTall() / 2, .4, 0, -1, function()
            j_sound.SoundFrame:Remove()
        end)
    elseif !IsValid(j_sound.SoundFrame) then
        j_sound.Menu()
    end
end)

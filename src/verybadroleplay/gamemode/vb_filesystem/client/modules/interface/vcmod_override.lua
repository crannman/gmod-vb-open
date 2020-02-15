-- Make sure to disable VC HUD AFTER it's initialized
timer.Create("VBTIMER::CheckVCHooks", 5, 0, function()
  if LocalPlayer().HookRemoved then 
    timer.Remove("VBTIMER::CheckVCHooks") 
  else
    VBRP.log("Checking if VC_HUDPaint exists") 
    if hook.GetTable()["HUDPaint"]["VC_HUDPaint"] then
      LocalPlayer().HookRemoved = true
      VBRP.log("Removing VC_HUDPaint Hook...") 
      hook.Remove("HUDPaint", "VC_HUDPaint")
    end
  end
end)

timer.Create("VBTIMER::CheckVCGlobals", 5, 0, function() 

  if LocalPlayer().VCGlobalsRemoved then
    timer.Remove("VBTIMER::CheckVCGlobals")
  else
    VBRP.log("Checking if VCPopup exists")
    if VCPopup then
      LocalPlayer().VCGlobalsRemoved = true
      VBRP.log("Overriding VCPopup global...")
      VCPopup = function() return false end
    end
  end
end)

timer.Create("VBTIMER::OverrideVCFunctions", 5, 0, function()

  if LocalPlayer().VCOverridden then
    timer.Remove("VBTIMER::OverrideVCFunctions")
  else
    VBRP.log("Checking if we can override vcmod functions")
    if hook.GetTable()["CalcView"]["VC_ViewCalc_Shared"] then
      hook.Remove("CalcView", "VC_ViewCalc_Shared")
      // Override here
      VBRP.log("Redefining `View_Outside` local function")
      local function View_Outside(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
        return View
      end

      VBRP.log("Redefining `View_Handle_TP_Hight_Auto_Speed` local function")
      local function View_Handle_TP_Hight_Auto_Speed(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View, Fltr, APos, APVD, HMlt)
        if VC.getSetting("ThirdPerson_Speed") then
          APos = APos + ang:Up() * (15 + HMlt)
          APos = APos - ang:Forward() * (15 + HMlt)
        end
        return APos
      end

      VBRP.log("Redefining `View_Handle_TP_Trailer` local function")
      local function View_Handle_TP_Trailer(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View, Fltr, APos, APVD)
        local trailer = Veh:GetNWEntity("VC_HookedVh")
        if not IsValid(trailer) then
          trailer = nil
        end
        if VC.getSetting("ThirdPerson_Cam_Trl") and trailer then
          if not Veh.VC_TrlVwMult or Veh.VC_TrlVwMult < 1 then
            Veh.VC_TrlVwMult = math.Round(((Veh.VC_TrlVwMult or 0) + 0.01 * VC.FTm()) * 100) / 100
          end
        elseif Veh.VC_TrlVwMult then
          if Veh.VC_TrlVwMult > 0 then
            Veh.VC_TrlVwMult = math.Round((Veh.VC_TrlVwMult - 0.01 * VC.FTm()) * 100) / 100
          else
            Veh.VC_TrlVwMult = nil
          end
        end
        if Veh.VC_TrlVwMult then
          if trailer then
            ply.VC_TrlAPos = trailer:LocalToWorld(trailer:OBBCenter()) + Veh:GetUp() * 60
            ply.VC_TrlAPVD = math.Max(100, trailer:BoundingRadius())
          end
          local VwMul = (math.sin(math.pi * (Veh.VC_TrlVwMult - 0.5)) + 1) / 2
          if ply.VC_TrlAPos then
            APos = LerpVector(VwMul, APos, (APos + ply.VC_TrlAPos) / 2)
          end
          if ply.VC_TrlAPVD then
            APVD = APVD + ply.VC_TrlAPVD * VwMul
          end
          Fltr = {Veh, trailer}
        end
        return {
          APos = APos,
          APVD = APVD,
          Fltr = Fltr
        }
      end

      VBRP.log("Redefining `View_Handle_Mouse_Movement` local function")
      local function View_Handle_Mouse_Movement(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
        local MMvd = false
        if not ply.VC_View_Angle_Simulated or not VC.AngleInBounds(0.0001, ply.VC_View_Angle_Simulated, ply:EyeAngles()) then
          ply.VC_View_Angle_Real = (ply.VC_View_Angle_Real or ply:EyeAngles()) + (ply:EyeAngles() - (ply.VC_View_Angle_Simulated or ply:EyeAngles()))
          ply.VC_View_Angle_Simulated = ply.VC_View_Angle_Real
          MMvd = true
        end
        if MMvd or not CursorVis and (input.IsMouseDown(MOUSE_LEFT) or input.IsMouseDown(MOUSE_RIGHT) or VC.View_LookingBehind) then
          ply.VC_View_LastMouseMovedTime = CurTime()
          ply.VC_LEAACR = math.random(4.5, 6)
        end
        return MMvd
      end

      VBRP.log("Redefining `View_Handle_Auto` local function")
      local function View_Handle_Auto(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
        local LookBehind = VC.View_LookingBehind and not vgui.CursorVisible()
        if LookBehind then
          VC.View_Auto_LastLookBehind = CurTime() + 0.5
        end
        local LookBehindRev = nil
        if VC.View_Auto_LastLookBehind and CurTime() < VC.View_Auto_LastLookBehind then
          LookBehindRev = true
        else
          VC.View_Auto_LastLookBehind = nil
        end
        if LookBehind or LookBehindRev or not CursorVis and (VC.getSetting("ThirdPerson_Auto") and VC.IsThirdPerson and VC.getSetting("ThirdPerson_Ang_Stf") > 0 or VC.getSetting("FirstPerson_Auto") and not VC.IsThirdPerson and VC.getSetting("FirstPerson_Ang_Stf") > 0 and not ply.VC_InGunMode) and not Veh.VC_IsAirboat and CurTime() >= (ply.VC_View_LastMouseMovedTime or (CurTime() + 1)) + (Veh:GetVelocity():Length() >= 50 and 1.5 or ply.VC_LEAACR) then
          local LBP = nil
          if not VC.IsThirdPerson then
            LBP = Veh:WorldToLocal(ply:EyePos()).x > 5 and -105 or -75
          else
            LBP = -90
          end
          local FAng = (VC.IsThirdPerson and VC.getSetting("ThirdPerson_Auto_Back") or not VC.IsThirdPerson and VC.getSetting("FirstPerson_Auto_Back")) and Veh == ent and (LookBehind or LookBehindRev or VCMod2 and (Veh:GetNWInt("VC_Throttle", 0) == 0 or Veh:GetNWInt("VC_Gear", 0) < 0) or input.IsKeyDown(KEY_S)) and (Veh:GetVelocity():Dot(Veh:GetRight()) > 150 or LookBehind) and LBP or 90
          if not VC.AngleInBounds(0.1, ply.VC_View_Angle_Real or ply:EyeAngles(), Angle(VC.IsThirdPerson and VC.getSetting("ThirdPerson_Auto_Pitch", 0), FAng, 0)) then
            local AVel = math.Clamp(Veh:GetVelocity():Length() / (FAng > 0 and (VC.IsThirdPerson and 25000 or 22000) or (VC.IsThirdPerson and 13000 or 10000)), 0, 0.0775)
            if ply.VC_APLBP and ply.VC_APLBP ~= FAng then
              View_Auto_InOutInt = 0
            end
            ply.VC_APLBP = FAng
            if View_Auto_InOutInt < 1 then
              View_Auto_InOutInt = View_Auto_InOutInt + 0.005 + AVel * VC.FTm()
            end
            if View_Auto_InOutInt > 1 then
              View_Auto_InOutInt = 1
            end
            local CAng = LerpAngle(((LookBehind or LookBehindRev) and 0.1 or (0.003 + AVel) * View_Auto_InOutInt) * VC.FTm(), ply.VC_View_Angle_Real, (Veh:GetAngles() - ent:GetAngles()) + Angle(VC.IsThirdPerson and VC.getSetting("ThirdPerson_Auto_Pitch", 0), FAng, 0))
            local PAng = ply:EyeAngles() - (ply.VC_View_Angle_Real - CAng)
            ply:SetEyeAngles(Angle(PAng.p, PAng.y, ply:EyeAngles().r))
            ply.VC_View_Angle_Real = Angle(CAng.p, CAng.y, ply:EyeAngles().r)
            ply.VC_View_Angle_Simulated = ply:EyeAngles()
            ply.VC_View_LastMouseMovedTime = 1
          else
            View_Auto_InOutInt = 0
          end
        else
          View_Auto_InOutInt = 0
        end
        return View
      end

      VBRP.log("Redefining `endViewThirdPerson` local function")
      local function endViewThirdPerson(ply)
        local ang = ply:EyeAngles()
        ply:SetEyeAngles(Angle(ang.p, ang.y, 0))
        ply.VC_CCAng = nil
        ply.VC_View_Angle_Real = nil
        ply.VC_View_Angle_Simulated = nil
        ply.VC_CnstVV = nil
        ply.VC_TPVDC = nil
        ply.VC_TrlAPos = nil
        ply.VC_TrlAPVD = nil
      end

      VBRP.log("Redefining `View_Handle_TP_Hight_Auto` local function")
      local function View_Handle_TP_Hight_Auto(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View, Fltr, APos, APVD)
        local Int = 1
        if VC.getSetting("ThirdPerson_Hight_Auto") then
          local CVel = Veh:GetVelocity():Length()
          CVel = (CVel - 150) * 0.04
          if CVel < 0 then
            CVel = 0
          end
          if CVel > 20 then
            CVel = 20
          end
          ply.VC_ViewTP_UpL = Lerp(0.02 * VC.FTm(), ply.VC_ViewTP_UpL or CVel, CVel)
          Int = ply.VC_ViewTP_UpL
          if not IsNotPod and VSC then
            Int = Int + 100
          end
        end
        return Int
      end

      VBRP.log("Overriding `View_Handle_TP_Dyn` local function")
      local function View_Handle_TP_Dyn(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View, Fltr, APos, APVD)
        if ply.VC_CCAng then
            ply:SetEyeAngles(ply.VC_View_Angle_Real or ply:EyeAngles())
            ply.VC_CCAng = nil
        end
        ply.VC_CnstVV = nil
        APos = LerpVector(math.Clamp(VC.getSetting("ThirdPerson_Vec_Stf") * 0.005 * VC.FTm(), 0, 1), ply.VC_CnstVV or APos, APos)
        if VC.getSetting("ThirdPerson_Vec_Stf") < 100 then
            ply.VC_CnstVV = APos
        else
            ply.VC_CnstVV = nil
        end
        return {
          APos = APos,
          APVD = APVD,
          Fltr = Fltr
        }
      end

      VBRP.log("Overriding `View_ThirdPerson` local function")
      local function View_ThirdPerson(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
        if not IsValid(Veh) then return View end
        View = {}
        local MMvd = View_Handle_Mouse_Movement(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
        View = View_Handle_Auto(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
        local Fltr, APos, APVD = Veh, VC.OBBToWorld(Veh) + ang:Up(), Veh.VC_View_TP_Radius or 250
        local HMlt = View_Handle_TP_Hight_Auto(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View, Fltr, APos, APVD)
        APos = View_Handle_TP_Hight_Auto_Speed(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View, Fltr, APos, APVD, HMlt)
        local Data = View_Handle_TP_Trailer(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View, Fltr, APos, APVD)
        Fltr = Data.Fltr
        APos = Data.APos
        APVD = Data.APVD
        APVD = APVD * (VC.View_TP_CamZoomLevel or 1)
        if ent.VC_IsPrisonerPod and not ent.VC_ExtraSeat then
          APVD = APVD / 2
        end
        local Data = View_Handle_TP_Dyn(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View, Fltr, APos, APVD)
        Fltr = Data.Fltr
        APos = Data.APos
        APVD = Data.APVD
        ply.VC_TPVDC = ply.VC_TPVDC or APVD
        if ply.VC_TPVDC > APVD + 0.05 or ply.VC_TPVDC < APVD - 0.05 then
          ply.VC_TPVDC = Lerp(0.04 * VC.FTm(), ply.VC_TPVDC, APVD)
        end
        local trctbl = {
          start = APos,
          endpos = APos + ang:Forward() * -ply.VC_TPVDC,
          filter = Fltr
        }
        if VC.getServerSetting("TP_Props") then
          trctbl.mask = MASK_NPCWORLDSTATIC
        end
        local TTTr = util.TraceLine(trctbl)
        View.origin = TTTr.HitPos + TTTr.HitNormal * (3 + ply.VC_TPVDC / 600)
        return View
      end

      VBRP.log("Overriding `VC.HandleView` global function")
      function VC.HandleView(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov)
        local View = nil
        local CursorVis = vgui.CursorVisible()
        local IsViewerSelf = VC.CheckViewerIsSelf()
        if VSC then
          if VC.Handle_View_Cinematic and IsViewerSelf and VC.Cinematic_View and (not ent.VC_IDSOVET or CurTime() >= ent.VC_IDSOVET) and not ply.VC_ExitingV then
            View = VC.Handle_View_Cinematic(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov)
          else
            if ply.VC_Cin_CurMode then
              VC.CinModes[ply.VC_Cin_CurMode].End(ply, Veh)
              ply.VC_Cin_CurMode = nil
              ply.VC_Cin_ChangeTime = nil
              ply.VC_Cin_CurTime = nil
            end
            local lastRanMode = VC.View_LastRanMode
            if VC.IsThirdPerson then
              VC.TP_Ran = true
              View = View_ThirdPerson(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
              VC.View_LastRanMode = "TP"
            else
              if VC.TP_Ran then
                endViewThirdPerson(ply)
                VC.TP_Ran = nil
              end
              if IsViewerSelf then
                View = {}
                View.origin = pos
                if VC.View_FirstPerson then
                  View = VC.View_FirstPerson(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
                end
                VC.View_LastRanMode = "FP"
              else
                View = View_Outside(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov, CursorVis, View)
                VC.View_LastRanMode = "Other"
              end
            end
            if lastRanMode ~= VC.View_LastRanMode then
              VC.ViewChanged()
            end
          end
        end
        return View
      end

      VBRP.log("Overriding `VC.VC_ViewCalc_Shared` hook")
      hook.Add("CalcView", "VC_ViewCalc_Shared", function(ply, pos, ang, fov)
        //if not VC.getSetting("Enabled") then return end
        local ent, View = ply:GetVehicle(), nil
        local drawChairs = true
        if IsValid(ent) then
          if VC.LastCar ~= ent and ent.SetThirdPersonMode then
            ent:SetThirdPersonMode(VC.IsInThirdPerson)
          end
          VC.LastCar = ent
          VC.IsInThirdPerson = ent.GetThirdPersonMode and ent:GetThirdPersonMode()
          local Veh = ent.VC_ExtraSeat and ent:GetParent() or ent
          if (drawChairs or ent.VC_IsNotPrisonerPod or ent.VC_ExtraSeat) then
            local IsNotPod = VC.isVCModCompatible(ent)
            local VSC = IsNotPod or Veh:GetNWBool("VC_HasWeapon", false)
            if VC.HandleView then
              local View = VC.HandleView(ply, ent, Veh, IsNotPod, VSC, pos, ang, fov)
              if View and table.Count(View) > 0 then
                VC.DM_Menu_EyePos = View.origin
                return View
              end
            end
          end
        end
      end)
      
      VBRP.log("Vcmod functions and hooks have been successfully overridden.")
      LocalPlayer().VCOverridden = true
    end
  end 
end)



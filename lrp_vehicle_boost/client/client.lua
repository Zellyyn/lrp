local SpeedMultiplier = 3.6
local BoostedVehicle  = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
    if IsPedInAnyVehicle(GetPlayerPed(-1), false) then
      local vehicle   = GetVehiclePedIsIn(PlayerPedId(), false)
      if vehicle ~= BoostedVehicle then
        BoostVehicle()
      end
		end
	end
end)

-- ========================================================================== --
-- Drive Command                                                               --
-- ========================================================================== --
function BoostVehicle ()
  local vehicle   = GetVehiclePedIsIn(PlayerPedId(), false)

  local dAccel    = GetVehicleHandlingFloat(vehicle,"CHandlingData","fDriveInertia")
  local dBoost    = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveForce")
  local dGrip     = GetVehicleHandlingFloat(vehicle,"CHandlingData","fTractionCurveMin")
  local dLatGrip  = GetVehicleHandlingFloat(vehicle,"CHandlingData","fTractionCurveMax")
  local dTraction = GetVehicleHandlingFloat(vehicle,"CHandlingData","fLowSpeedTractionLossMult")
  local dUpShift  = GetVehicleHandlingFloat(vehicle,"CHandlingData","fClutchChangeRateScaleUpShift")
  local dDnShift  = GetVehicleHandlingFloat(vehicle,"CHandlingData","fClutchChangeRateScaleDownShift")
  local dDragCoef = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDragCoeff")
  local dTopSpeed = GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel")

  print(dAccel, dBoost, dGrip, dLatGrip, dTraction, dUpShift, dDnShift, dDragCoef, dTopSpeed)

  local nAccel    = dAccel * 20 -- dAccel * 0.15
  local nBoost    = dBoost + dBoost * 2
  local nGrip     = dGrip
  local nLatGrip  = dLatGrip
  local nTraction = dTraction / 4
  local nUpShift  = dUpShift + 6.5
  local nDnShift  = dDnShift + 6.5
  local nDragCoef = dDragCoef * 1000
  local nTopSpeed = dTopSpeed + dTopSpeed * 0.50 * 3

  print(nAccel, nBoost, nGrip, nLatGrip, nTraction, nUpShift, nDnShift, nDragCoef, nTopSpeed)

  --SetVehicleHandlingFloat(vehicle,"CHandlingData","fDriveInertia", nAccel   )
  --SetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveForce", nBoost   )
  --SetVehicleHandlingFloat(vehicle,"CHandlingData","fTractionCurveMin", nGrip    )
  --SetVehicleHandlingFloat(vehicle,"CHandlingData","fTractionCurveMax", nLatGrip )
  --SetVehicleHandlingFloat(vehicle,"CHandlingData","fLowSpeedTractionLossMult", nTraction)
  --SetVehicleHandlingFloat(vehicle,"CHandlingData","fClutchChangeRateScaleUpShift", nUpShift )
  --SetVehicleHandlingFloat(vehicle,"CHandlingData","fClutchChangeRateScaleDownShift", nDnShift )
  SetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDragCoeff", nDragCoef)
  SetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel", nTopSpeed)

  BoostedVehicle = vehicle

end
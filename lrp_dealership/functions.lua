function GetVehicleData(vehicle)
  local PrimaryColor, SecondaryColor = GetVehicleColours(vehicle)
  local PearlColor, WheelColor = GetVehicleExtraColours(vehicle)
  local TiresR, TiresG, TiresB = GetVehicleTyreSmokeColor(vehicle)
  
  SetVehicleModKit(vehicle, 0)

  local VehicleData = {
    hash        = GetEntityModel(vehicle),
    name        = GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)),
    description = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle))),
    fuel        = GetVehicleFuelLevel(vehicle),
    oil         = GetVehicleOilLevel(vehicle),
    wheelhealth = {
      GetVehicleWheelHealth(vehicle, 0),
      GetVehicleWheelHealth(vehicle, 1),
      GetVehicleWheelHealth(vehicle, 2),
      GetVehicleWheelHealth(vehicle, 3),
    },
    tireburst = {
      [0] = IsVehicleTyreBurst(vehicle, 0, false),
      [1] = IsVehicleTyreBurst(vehicle, 1, false),
      [2] = IsVehicleTyreBurst(vehicle, 2, false),
      [3] = IsVehicleTyreBurst(vehicle, 3, false),
      [4] = IsVehicleTyreBurst(vehicle, 4, false),
      [5] = IsVehicleTyreBurst(vehicle, 5, false),
      [45] = IsVehicleTyreBurst(vehicle, 45, false),
      [47] = IsVehicleTyreBurst(vehicle, 47, false),
    },
    windowintact = {
      [0] = IsVehicleWindowIntact(vehicle, 0),
      [1] = IsVehicleWindowIntact(vehicle, 1),
      [2] = IsVehicleWindowIntact(vehicle, 2),
      [3] = IsVehicleWindowIntact(vehicle, 3),
      [6] = IsVehicleWindowIntact(vehicle, 6),
      [8] = IsVehicleWindowIntact(vehicle, 8)
    },
    doordamaged = {
      [0] = IsVehicleDoorDamaged(vehicle, 0),
      [1] = IsVehicleDoorDamaged(vehicle, 1),
      [2] = IsVehicleDoorDamaged(vehicle, 2),
      [3] = IsVehicleDoorDamaged(vehicle, 3)
    },
    bodyhealth      = GetVehicleBodyHealth(vehicle),
    primarycolor    = PrimaryColor,
    secondarycolor  = SecondaryColor,
    pearlcolor      = PearlColor,
    wheelcolor      = WheelColor,
    dirtlevel       = GetVehicleDirtLevel(vehicle),
    enginehealth    = GetVehicleEngineHealth(vehicle),
    livery          = GetVehicleLivery(vehicle),
    plate           = GetVehicleNumberPlateText(vehicle),
    tankhealth      = GetVehiclePetrolTankHealth(vehicle),
    platetype       = GetVehicleNumberPlateTextIndex(vehicle),
    smoker          = TiresR,
    smokeg          = TiresG,
    smokeb          = TiresB,
    wheeltype       = GetVehicleWheelType(vehicle),
    tint            = GetVehicleWindowTint(vehicle),
    spoilers        = GetVehicleMod(vehicle, 0),
		frontbumper     = GetVehicleMod(vehicle, 1),
		rearbumper      = GetVehicleMod(vehicle, 2),
		sideSkirt       = GetVehicleMod(vehicle, 3),
		exhaust         = GetVehicleMod(vehicle, 4),
		frame           = GetVehicleMod(vehicle, 5),
		grille          = GetVehicleMod(vehicle, 6),
		hood            = GetVehicleMod(vehicle, 7),
		fender          = GetVehicleMod(vehicle, 8),
		rightfender     = GetVehicleMod(vehicle, 9),
		roof            = GetVehicleMod(vehicle, 10),
		engine          = GetVehicleMod(vehicle, 11),
		brakes          = GetVehicleMod(vehicle, 12),
		transmission    = GetVehicleMod(vehicle, 13),
		horns           = GetVehicleMod(vehicle, 14),
		suspension      = GetVehicleMod(vehicle, 15),
		armor           = GetVehicleMod(vehicle, 16),
		turbo           = IsToggleModOn(vehicle, 18),
		xenon           = IsToggleModOn(vehicle, 22),
		frontwheels     = GetVehicleMod(vehicle, 23),
    backwheels      = GetVehicleMod(vehicle, 24),
    neons           = table.pack(GetVehicleNeonLightsColour(vehicle)),
    extras          = {
      [0]           = IsVehicleExtraTurnedOn(vehicle, 0),
      [1]           = IsVehicleExtraTurnedOn(vehicle, 1),
      [2]           = IsVehicleExtraTurnedOn(vehicle, 2),
      [3]           = IsVehicleExtraTurnedOn(vehicle, 3),
      [4]           = IsVehicleExtraTurnedOn(vehicle, 4),
      [5]           = IsVehicleExtraTurnedOn(vehicle, 5),
      [6]           = IsVehicleExtraTurnedOn(vehicle, 6),
      [7]           = IsVehicleExtraTurnedOn(vehicle, 7),
      [8]           = IsVehicleExtraTurnedOn(vehicle, 8),
      [9]           = IsVehicleExtraTurnedOn(vehicle, 9),
      [10]          = IsVehicleExtraTurnedOn(vehicle, 10),
      [11]          = IsVehicleExtraTurnedOn(vehicle, 11),
      [12]          = IsVehicleExtraTurnedOn(vehicle, 12),
      [13]          = IsVehicleExtraTurnedOn(vehicle, 13),
      [14]          = IsVehicleExtraTurnedOn(vehicle, 14)
    }
  }
  return VehicleData
end

function GetUnoccupiedSpot(coords)
  for _, v in pairs(Config.ParkingSpots) do
    local SpotCoords = vector3(v.x, v.y, v.z)
    local SpotDistance = Vdist(coords.x, coords.y, coords.z, SpotCoords.x, SpotCoords.y, SpotCoords.z)
    if not IsVehicleParkedInSpot(SpotCoords) and SpotDistance < 25.0 then
       return v
    end
  end
end

function IsVehicleParkedInSpot(ParkingSpot)
  local ClosestVehicle = GetClosestVehicle(ParkingSpot.x, ParkingSpot.y, ParkingSpot.z, 2.0, 0, 71)
  if ClosestVehicle ~= 0 then
    return true
  else
    return false
  end
end

function RemoveVehicle(vehicle)
  SetEntityAsMissionEntity(vehicle, false, true)
	DeleteVehicle(vehicle)
end


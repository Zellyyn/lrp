function SpawnObjectProperly(prop, coords)
  RequestModel(prop)
  while not HasModelLoaded(prop) do    
    Wait(1)
  end
  local object = CreateObject(prop, coords.x, coords.y, coords.z, true, false, false)
  SetEntityHeading(object, coords.heading)
  PlaceObjectOnGroundProperly(object)
end

function GetVehicleInFront()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 2.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 2, GetPlayerPed(-1), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end

function Print3DText(coords, text)
  local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z + 1)
  if onScreen then
      local px, py, pz = table.unpack(GetGameplayCamCoords())
      local dist = #(vector3(px, py, pz) - vector3(coords.x, coords.y, coords.z))    
      local scale = (1 / dist) * 20
      local fov = (1 / GetGameplayCamFov()) * 100
      local scale = scale * fov   
      SetTextScale(0.35, 0.35)
      SetTextFont(4)
      SetTextProportional(1)
      SetTextColour(250, 250, 250, 255)		-- You can change the text color here
      SetTextDropshadow(1, 1, 1, 1, 255)
      SetTextEdge(2, 0, 0, 0, 150)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      SetDrawOrigin(coords.x, coords.y, coords.z + 1, 0)
      DrawText(0.0, 0.0)
      ClearDrawOrigin()
  end
end

function Round(number, decimals)
	local mult = 10^(decimals or 0)
	return math.floor(number * mult + 0.5) / mult
end

function makeEntityFaceEntity( entity1, entity2 )
  local p1 = GetEntityCoords(entity1, true)
  local p2 = GetEntityCoords(entity2, true)

  local dx = p2.x - p1.x
  local dy = p2.y - p1.y

  local heading = GetHeadingFromVector_2d(dx, dy)
  SetEntityHeading( entity1, heading )
end

function print_r ( t ) 
  local print_r_cache={}
  local function sub_print_r(t,indent)
      if (print_r_cache[tostring(t)]) then
          print(indent.."*"..tostring(t))
      else
          print_r_cache[tostring(t)]=true
          if (type(t)=="table") then
              for pos,val in pairs(t) do
                  if (type(val)=="table") then
                      print(indent.."["..pos.."] => "..tostring(t).." {")
                      sub_print_r(val,indent..string.rep(" ",string.len(pos)+8))
                      print(indent..string.rep(" ",string.len(pos)+6).."}")
                  else
                      print(indent.."["..pos.."] => "..tostring(val))
                  end
              end
          else
              print(indent..tostring(t))
          end
      end
  end
  sub_print_r(t,"  ")
end

function DebugLog (msg)
  if Config.Debug then 
    TriggerServerEvent('lrp:PrintDebugMessage', GetPlayerServerId(GetPlayerIndex()), msg)
  end
end

function TableLength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

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

function RemoveVehicle(vehicle)
  SetEntityAsMissionEntity(vehicle, false, true)
	DeleteVehicle(vehicle)
end


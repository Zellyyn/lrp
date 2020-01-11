
function GetUnoccupiedSpot(coords)
  for _, v in pairs(Config.ParkingSpots) do
    local SpotCoords = vector3(v.x, v.y, v.z)
    local SpotDistance = Vdist(coords.x, coords.y, coords.z, SpotCoords.x, SpotCoords.y, SpotCoords.z)
    if not IsVehicleParkedInSpot(SpotCoords) and SpotDistance < 45.0 then
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

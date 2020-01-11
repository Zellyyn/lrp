print("Starting lrp_locations")
local ObjectTable = {}

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1)
    local PedCoords = GetEntityCoords(PlayerPedId())
    for LocType, LocValue in pairs(Config.Locations) do
      for _, LocHash in ipairs(Config.Locations[LocType].props) do
      --  print(LocType .. " : " .. LocHash)
        ObjectCoords = GetEntityCoords(GetClosestObjectOfType(PedCoords, 50, GetHashKey(LocHash), false, 0, 1))
        if ObjectCoords.x ~= 0 and ObjectCoords.y ~= 0 and ObjectCoords.z ~= 0 then
          msgCoords  = vector3(ObjectCoords.x, ObjectCoords.y, PedCoords.z - 0.75)
          local PedObjDist = Vdist(ObjectCoords.x, ObjectCoords.y, ObjectCoords.z, PedCoords.x, PedCoords.y, PedCoords.z)
          Print3DText(msgCoords, Config.Locations[LocType].msg)
        end 
      end
    end 
  end
end)


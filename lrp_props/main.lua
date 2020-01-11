print("Starting lrp_props")
local PropList = {}

Citizen.CreateThread(function()
  while true do
    LoadProps()
    Citizen.Wait(60000)
    DeleteProps()
    Citizen.Wait(200)
  end
end)

function LoadProps()
  for PropHash, PropData in pairs(Config.PropPlacement) do
    for _, PropSpawn in ipairs(Config.PropPlacement[PropHash].spawns) do

      RequestModel(PropHash)

      while not HasModelLoaded(PropHash) do    
        Wait(1)
      end

      local object = CreateObject(PropHash, PropSpawn.x, PropSpawn.y, PropSpawn.z, true, false, false)
      table.insert(PropList, object)

      SetEntityHeading(object, PropSpawn.heading)
      PlaceObjectOnGroundProperly(object)

      --if not IsObjectNearPoint(PropHash, PropSpawn.x, PropSpawn.y, PropSpawn.z, 2.0) then
      --  SpawnObjectProperly(GetHashKey(PropHash), PropSpawn)
    end
  end
end

function DeleteProps()
  for _, v in ipairs(PropList) do
    DeleteObject(v)
  end
end
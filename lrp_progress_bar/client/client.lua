
RegisterEvent("lrp:progressbar")
AddEventHandler("lrp:progressbar", function(data)
  -- data elements
  -- .msg - message to use
  -- .time - time to wait in milliseconds
  -- .location - (top-left, top-center, top-right, center-left, center-center, center-right, bottom-left, bottom-center, bottom-right)
  player = PlayerPedId()
  local timeSpent = 0
  while timeSpent <= data.time do
    local percentComplete = timeSpent/data.time
    SendNUIMessage{(
      type = 'progressbar',
      location = data.location,
      message  = data.msg
    )}
    timeSpent=timeSpent+1
  end
end)
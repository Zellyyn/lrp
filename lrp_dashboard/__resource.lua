resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
description 'lrp dashboard'

ui_page 'html/index.html'

client_scripts {
  '@lrp_base/functions.lua',
  'config.lua',
  'client/main.lua',
  'client/cruise.lua',
  'client/seatbelt.lua'
} 

files {
  'html/index.html',
  'html/style.css',
  'html/reset.css',
  'html/listener.js',
  'html/dig7.ttf',
  'html/ding.ogg',

  'html/img/fuel.png',
  'html/img/high-beam.png',
  'html/img/low-beam.png',
  'html/img/seatbelt.png',
  'html/img/engine.png'
}

exports {
  'DashboardOff',
  'DashboardOn'
}
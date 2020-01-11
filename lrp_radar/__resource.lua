resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'html/radar.html'

client_scripts {
  '@lrp_base/functions.lua',
  'functions.lua',
  'config.lua',
  'client.lua'
} 

server_scripts {
  '@lrp_base/functions.lua',
  '@mysql-async/lib/MySQL.lua',
  'functions.lua',
  'config.lua',
  'server.lua'
} 

files {
  'html/img/brushed-metal.jpg',
  'html/img/primary.png',
  'html/img/secondary.png',
  'html/img/reset.png',
  'html/img/previous.png',
  'html/img/next.png',
  'html/img/plus.png',
  'html/img/minus.png',
  'html/img/up.png',
  'html/img/down.png',
  'html/font/digital2.ttf',
  'html/font/dig7.ttf',
  'html/radar.css',
  'html/radar.js',
  'html/radar.html'
}

resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

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
  'html/img/find-car.png',
  'html/img/manage-keys.png',
  'html/img/take-out-car.png',
  'html/garages.css',
  'html/garages.js',
  'html/garages.html'
}

ui_page 'html/garages.html'


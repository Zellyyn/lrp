resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'html/customs.html'

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
  'html/img/reset.png',
  'html/img/previous.png',
  'html/img/next.png',
  'html/img/plus.png',
  'html/img/minus.png',
  'html/img/repair.png',
  'html/img/bodyworks.png',
  'html/img/dollar.png',
  'html/img/performance.png',
  'html/img/respray.png',
  'html/customs.css',
  'html/customs.js',
  'html/customs.html'
}

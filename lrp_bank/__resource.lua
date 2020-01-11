resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

ui_page 'html/bank.html'

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
  'html/img/plus.png',
  'html/img/minus.png',
  'html/img/credit.png',
  'html/img/deposit.png',
  'html/img/dollar.png',
  'html/img/withdrawal.png',
  'html/bank.css',
  'html/bank.js',
  'html/bank.html'
}

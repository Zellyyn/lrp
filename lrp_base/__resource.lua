resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'

client_scripts {
  'functions.lua',
  'commands.lua',
  'utilities.lua',
  'config.lua',
  'client.lua'
} 

server_scripts {
  '@mysql-async/lib/MySQL.lua',
  'config.lua',
  'server.lua'
} 


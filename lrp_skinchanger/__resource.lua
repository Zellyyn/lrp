resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
description 'lrp skinchanger'

client_scripts {
  '@lrp_base/functions.lua',
  'config.lua',
  'client.lua'
} 

server_scripts {
  '@lrp_base/functions.lua',
  'config.lua',
  'server.lua'
} 

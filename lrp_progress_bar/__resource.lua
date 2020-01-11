resource_manifest_version '77731fab-63ca-442c-a67b-abc70f28dfa5'
description 'lrp progress bar'

ui_page 'html/index.html'

client_scripts {
  'config.lua',
  'client/client.lua'
} 

files {
  'html/index.html',
  'html/style.css',
  'html/listener.js'
}
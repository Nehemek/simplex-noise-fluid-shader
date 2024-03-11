---------------------------------------------------------------------------
-- CONFIGURATION
---------------------------------------------------------------------------
function love.conf(table)
    table.gammacorrect = true
    table.modules.physics  = false
    table.modules.video = false
    table.modules.audio = false
end
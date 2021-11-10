local event = require("__flib__.event")

local default_controller = require("extra.logic.controllers.default_controller")

event.register(defines.events.on_built_entity, function(e)
    default_controller:on_build_entity(e)
end)

event.register({
    defines.events.on_player_mined_entity,
    defines.events.on_robot_mined_entity,
    defines.events.on_entity_died,
}, function(e)
    default_controller:on_deconstruct_entity(e)
end)

event.register(defines.events.on_runtime_mod_setting_changed, function(e)
    default_controller:on_runtime_mod_setting_changed(e)
end)
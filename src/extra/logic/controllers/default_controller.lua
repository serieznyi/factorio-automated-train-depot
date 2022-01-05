local depot = require("extra.logic.services.depot")
local DepotFrame = require("extra.gui.frame.DepotFrame")

local default_controller = {}

function default_controller:on_runtime_mod_setting_changed()
    -- TODO process different settings type

    automated_train_depot.settings.refresh()
end

---@param eventData EventData
function default_controller:on_build_entity(eventData)
    local entity = eventData.created_entity

    if not entity or not entity.valid then
        return
    end

    if entity.name == automated_train_depot.constants.entity_names.depot_building then
        depot:build(entity)
    end
end

---@param eventData EventData
function default_controller:on_deconstruct_entity(eventData)
    local entity = eventData.entity

    if not entity or not entity.valid then
        return
    end

    if entity.name == automated_train_depot.constants.entity_names.depot_building then
        depot:destroy(entity.unit_number)
    end
end

---@param eventData EventData
function default_controller:on_gui_opened(eventData)
    if
        eventData.gui_type == defines.gui_type.entity
        and eventData.entity.name == automated_train_depot.constants.entity_names.depot_building
    then
        ---@type LuaPlayer
        local player = game.get_player(eventData.player_index)
        ---@type LuaEntity
        local entity = eventData.entity

        --- @type DepotFrame
        local depot_frame = automated_train_depot.registered_depots[entity.unit_number].gui_frame

        if depot_frame == nil then
            automated_train_depot.registered_depots[entity.unit_number].gui_frame = DepotFrame(entity, player)
            depot_frame = automated_train_depot.registered_depots[entity.unit_number].gui_frame
        end

        player.opened = nil
        player.opened = depot_frame.frame
    end
end

return default_controller
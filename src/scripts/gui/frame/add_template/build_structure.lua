local constants = require("scripts.gui.frame.add_template.constants")

local FRAME = constants.FRAME

local label_info_sprite_style = {
    natural_width = 15,
    natural_height = 15,
}

local build_structure = {}

---@param train_template scripts.lib.domain.TrainTemplate
function build_structure.get(train_template)
    local train_template_name = train_template ~= nil and train_template.name or nil
    local new = train_template_name == nil
    local train_template_id = train_template ~= nil and train_template.id or nil

    return {
        type = "frame",
        name = FRAME.NAME,
        tags = { type = mod.defines.gui.mod_frame_marker_name, train_template_id = train_template_id },
        direction = "vertical",
        ref  =  {"window"},
        style_mods = {
            minimal_width = 600,
            minimal_height = 400,
            vertically_stretchable = true,
            horizontally_stretchable = true,
        },
        children = {
            -- Titlebar
            {
                type = "flow",
                style = "flib_titlebar_flow",
                ref = {"titlebar_flow"},
                children = {
                    {
                        type = "label",
                        style = "frame_title",
                        caption = new and {"add-train-template-frame.atd-add-title"} or { "add-train-template-frame.atd-edit-title", train_template_name },
                        ignored_by_interaction = true
                    },
                    {
                        type = "empty-widget",
                        style = "flib_titlebar_drag_handle",
                        ignored_by_interaction = true
                    },
                }
            },
            -- Content
            {
                type = "frame",
                style = "inside_shallow_frame_with_padding",
                style_mods = {
                    horizontally_stretchable = true,
                    vertically_stretchable = true,
                },
                direction = "vertical",
                children = {
                    {
                        type = "table",
                        column_count = 2,
                        children = {
                            {
                                type = "label",
                                caption = { "add-train-template-frame.atd-icon" },
                            },
                            {
                                type = "flow",
                                style_mods = {
                                    bottom_padding = 15,
                                },
                                children = {
                                    {
                                        type = "choose-elem-button",
                                        ref = {"icon_input"},
                                        elem_type = "item",
                                        actions = {
                                            on_elem_changed = { target = FRAME.NAME, action = mod.defines.gui.actions.touch_form }
                                        }
                                    },
                                    {
                                        type = "flow",
                                        direction = "vertical",
                                        tags = {validation_errors_container = true},
                                    }
                                }
                            },
                            {
                                type = "label",
                                caption = { "add-train-template-frame.atd-name" },
                            },
                            {
                                type = "flow",
                                style_mods = {
                                    bottom_padding = 15,
                                },
                                children = {
                                    {
                                        type = "textfield",
                                        ref = {"name_input"},
                                        actions = {
                                            on_text_changed = { target = FRAME.NAME, action = mod.defines.gui.actions.touch_form },
                                            on_confirmed = { target = FRAME.NAME, action = mod.defines.gui.actions.touch_form },
                                        }
                                    },
                                    {
                                        type = "flow",
                                        direction = "vertical",
                                        tags = {validation_errors_container = true},
                                    }
                                }
                            },
                            {
                                type = "label",
                                caption = { "add-train-template-frame.atd-train" },
                            },
                            {
                                type = "flow",
                                style_mods = {
                                    bottom_padding = 15,
                                },
                                children = {
                                    {
                                        type = "frame",
                                        direction = "horizontal",
                                        ref  =  {"train_builder_container"},
                                    },
                                    {
                                        type = "flow",
                                        direction = "vertical",
                                        tags = {validation_errors_container = true},
                                    }
                                }
                            },
                            {
                                type = "flow",
                                direction = "horizontal",
                                style_mods = {
                                    vertically_squashable = true,
                                    horizontally_squashable = true,
                                },
                                children = {
                                    {
                                        type = "label",
                                        caption = { "add-train-template-frame.atd-clean-train-station" },
                                        tooltip = { "add-train-template-frame-description.atd-clean-train-station" },
                                    },
                                    {
                                        type = "sprite",
                                        sprite = "atd_sprite_info",
                                        resize_to_sprite = false,
                                        style_mods = label_info_sprite_style,
                                    },
                                }
                            },
                            {
                                type = "flow",
                                style_mods = {
                                    bottom_padding = 15,
                                },
                                children = {
                                    {
                                        type = "flow",
                                        ref  =  {"clean_train_station_dropdown_wrapper"},
                                    },
                                    {
                                        type = "flow",
                                        direction = "vertical",
                                        tags = {validation_errors_container = true},
                                    }
                                }
                            },
                            {
                                type = "flow",
                                direction = "horizontal",
                                style_mods = {
                                    vertically_squashable = true,
                                    horizontally_squashable = true,
                                },
                                children = {
                                    {
                                        type = "label",
                                        caption = { "add-train-template-frame.atd-destination-train-station" },
                                        tooltip = { "add-train-template-frame-description.atd-destination-train-station" },
                                    },
                                    {
                                        type = "sprite",
                                        sprite = "atd_sprite_info",
                                        resize_to_sprite = false,
                                        style_mods = label_info_sprite_style,
                                    },
                                }
                            },
                            {
                                type = "flow",
                                style_mods = {
                                    bottom_padding = 15,
                                },
                                children = {
                                    {
                                        type = "flow",
                                        ref  =  {"destination_schedule_dropdown_wrapper"},
                                    },
                                    {
                                        type = "flow",
                                        direction = "vertical",
                                        tags = {validation_errors_container = true},
                                    }
                                }
                            },
                        }
                    },
                    {
                        type = "flow",
                        ref = {"validation_errors_container"},
                        direction = "vertical",
                    }
                }
            },
            -- Bottom control bar
            {
                type = "flow",
                style = "dialog_buttons_horizontal_flow",
                ref = {"footerbar_flow"},
                children = {
                    {
                        type = "button",
                        style = "back_button",
                        caption = { "gui.atd-cancel" },
                        actions = {
                            on_click = { target = FRAME.NAME, action = mod.defines.gui.actions.close_frame },
                        },
                    },
                    {
                        type = "empty-widget",
                        style = "flib_dialog_footer_drag_handle",
                        ignored_by_interaction = true
                    },
                    {
                        type = "button",
                        style = "confirm_button",
                        caption = new and {"gui.atd-create"} or {"gui.atd-update"},
                        ref = {"submit_button"},
                        enabled = false,
                        actions = {
                            on_click = { target = FRAME.NAME, action = mod.defines.gui.actions.save_form },
                        },
                    },
                }
            },
        }
    }
end

return build_structure
local constants = require("constants")
local logger = require("scripts.logger")

local events = {}

function events.on_click_new_task_button(event, node)
    if event.element.parent[node.events_params.task_dropdown_frame_id].visible then
        event.element.parent[node.events_params.task_dropdown_frame_id].visible = false
    else
        event.element.parent[node.events_params.task_dropdown_frame_id].visible = true
    end
end

function events.on_click_close_button(event, node)
    node.parent:remove()
    event.element.parent.destroy()
end

function events.on_selection_repeatable_timer(event, node)
    event.element.parent.visible = false
    event.element.selected_index = 0

    -- Setup Persistent Nodes --
    local scroll_pane_node = node.parent.parent
    local scroll_pane_gui = event.element.parent.parent

    local repeatable_time_node = scroll_pane_node:add_child()
    repeatable_time_node.gui = {
        type = "frame",
        direction = "vertical",
        name = repeatable_time_node.id,
        style = constants.style.conditional_frame
    }

    local close_button_node = repeatable_time_node:add_child()
    close_button_node.gui = {
        type = "sprite-button",
        direction = "vertical",
        name = close_button_node.id,
        style = constants.style.close_button_frame,
        sprite = "utility/close_white",
        hovered_sprite = "utility/close_black",
        clicked_sprite = "utility/close_black"
    }
    close_button_node.events_id.on_click = "on_click_close_button"

    -- Setup Node Events --
    close_button_node:recursive_setup_events()

    -- Setup Factorio GUI --
    local repeatable_time_gui = scroll_pane_gui.add(repeatable_time_node.gui)
    repeatable_time_gui.add(close_button_node.gui)
end

function events.on_selection_single_timer(event, node)
    event.element.parent.visible = false
    event.element.selected_index = 0
end


return events
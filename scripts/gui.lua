local constants = require("constants")
local game_node = require("game_node")
local logger = require("scripts.logger")


local opened_signal_node = nil
local opened_signal_frame = nil


local function on_gui_opened(event)
    logger.print("on_gui_opened")

    if not event.entity then
        return
    end

    local player = game.players[event.player_index]
    if player.selected then        
        if player.selected.name == constants.entity.name then
            global.opened_entity[event.player_index] = event.entity.unit_number
            player.opened = game_node:build_gui_nodes(player.gui.screen, global.entities[event.entity.unit_number].node)
            player.opened.force_auto_center()

            -- Open the Signal frame
            if not opened_signal_node then
                opened_signal_node = game_node:create_signal_gui(event.entity.unit_number)
            end

            opened_signal_frame = game_node:build_gui_nodes(player.gui.screen, opened_signal_node)            
            opened_signal_frame.force_auto_center()

        elseif player.selected.name == constants.entity.input.name or player.selected.name == constants.entity.output.name then
            player.opened = nil
        end
    end
end

local function on_gui_closed(event)
    logger.print("on_gui_closed")

    if opened_signal_frame then
        opened_signal_frame.destroy()
        opened_signal_frame = nil
    end

    if event.element then
        local player = game.players[event.player_index]
        if player.opened then
            player.opened = nil
        end
    
        if global.opened_entity then
            global.opened_entity[event.player_index] = nil
        end

        event.element.destroy()
        event.element = nil
    end
end

local function on_gui_click(event)
    logger.print("on_gui_click name: "..event.element.name)

    local name = event.element.name
    local unit_number = global.opened_entity[event.player_index]

    if global.entities[unit_number] then
        local node = global.entities[unit_number].node:recursive_find(name)
        if node and node.events.on_click then
            node.events.on_click(event, node)
        end
    end
end

local function on_gui_elem_changed(event)
    if event.element.elem_value then
        logger.print("on_gui_elem_changed name: "..event.element.name..", type: "..event.element.elem_value.type.." name: "..event.element.elem_value.name)
    end

    local name = event.element.name
    local unit_number = global.opened_entity[event.player_index]

    if global.entities[unit_number] then
        local node = global.entities[unit_number].node:recursive_find(name)
        if node and node.events.on_gui_elem_changed then
            node.events.on_gui_elem_changed(event, node)
        end
    end
end

local function on_gui_text_changed(event)
    logger.print("on_gui_text_changed name: "..event.element.name)

    local name = event.element.name
    local unit_number = global.opened_entity[event.player_index]

    if global.entities[unit_number] then
        local node = global.entities[unit_number].node:recursive_find(name)
        if node and node.events.on_gui_text_changed then
            node.events.on_gui_text_changed(event, node)
        end
    end
end

local function on_gui_selection_state_changed(event)
    logger.print("on_gui_selection_state_changed name: "..event.element.name)

    local name = event.element.name
    local unit_number = global.opened_entity[event.player_index]
    local selected_index = event.element.selected_index

    if global.entities[unit_number] then
        local node = global.entities[unit_number].node:recursive_find(name)
        if node and node.events.on_selection_state_changed then
            node.events.on_selection_state_changed[selected_index](event, node)
        end
    end
end

script.on_event(defines.events.on_gui_opened, on_gui_opened)
script.on_event(defines.events.on_gui_closed, on_gui_closed)
script.on_event(defines.events.on_gui_click, on_gui_click)
script.on_event(defines.events.on_gui_elem_changed, on_gui_elem_changed)
script.on_event(defines.events.on_gui_text_changed, on_gui_text_changed)
script.on_event(defines.events.on_gui_selection_state_changed, on_gui_selection_state_changed)

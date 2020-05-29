local constants = require("constants")

local function add_styles(styles)
    local default_styles = data.raw["gui-style"].default
    for name, style in pairs(styles) do
        default_styles[name] = style
    end
end


add_styles({
    [constants.style.hidden_frame] =
    {
        type = "frame_style",
        font = "default-semibold",      
        font_color = {r=1, g=1, b=1},

        top_padding  = 0,
        right_padding = 0,
        bottom_padding = 0,
        left_padding = 0,

        title_top_padding = 0,
        title_left_padding = 0,
        title_bottom_padding = 0,
        title_right_padding = 0,

        flow_style = {
          type = "flow_style",
          horizontal_spacing = 0,
          vertical_spacing = 0
        },
        horizontal_flow_style =
        {
          type = "horizontal_flow_style",
          horizontal_spacing = 0
        },      
        vertical_flow_style =
        {
          type = "vertical_flow_style",
          vertical_spacing = 0
        },
        graphical_set =
        {
            type = "composition",
            filename = constants.blank_image_4x4,
            priority = "extra-high-no-scale",
            load_in_minimal_mode = true,
            corner_size = {1, 1},
            position = {0, 0}
        }
    },
    [constants.style.default_frame] =
    {
      type = "frame_style",
      title_style =
      {
        type = "label_style",
        parent = "frame_title",
      },
      -- padding of the content area of the frame
      top_padding  = 4,
      right_padding = 8,
      bottom_padding = 4,
      left_padding = 8,
      graphical_set =
      {
        base = {position = {0, 0}, corner_size = 8},
        shadow = default_shadow
      },
      flow_style = { type = "flow_style" },
      horizontal_flow_style = { type = "horizontal_flow_style" },
      vertical_flow_style = { type = "vertical_flow_style"  },
      header_flow_style = { type = "horizontal_flow_style", vertical_align = "center", bottom_padding = 4},
      header_filler_style =
      {
        type = "empty_widget_style",
        parent = "draggable_space_header",
        height = 24
      },
      use_header_filler = true,
      drag_by_title = true,
      border = {}
    },
    -- Main Frame --
    [constants.style.main_frame] =
    {
        type = "frame_style",
        parent = "dialog_frame",
        horizontally_stretchable = "on",
        vertically_stretchable = "on",
        auto_center = true,

        top_padding  = 0,
        right_padding = 0,
        bottom_padding = 0,
        left_padding = 0,

        minimal_width = 700,
        maximal_width = 700,
        minimal_height = 650,
        maximal_height = 650,
        width = 700,
        height = 650
    },
    [constants.style.options_frame] =
    {
        type = "frame_style",
        parent = "menu_frame",
        vertical_align = "top",
        horizontal_align = "left",

        top_padding  = 10,
        right_padding = 10,
        bottom_padding = 10,
        left_padding = 10,

        width = 300,
        height = 610,
        maximal_height = 610,
    },
    [constants.style.condition_button] =
    {
      type = "button_style",
      parent = "button_with_shadow",
      horizontal_align = "left",
      height = 36,
      width = 288
    },
})
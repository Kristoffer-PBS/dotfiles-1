local wibox = require("wibox")
local lain = require("lain")
local markup = lain.util.markup
local colorize = require"main.helpers".colorize

local HOME = os.getenv("HOME")

-- local volume_off = HOME .. "/.config/awesome/statusbar/modules/volume/volume_off.svg"
local volume_mute = HOME .. "/.config/awesome/statusbar/modules/volume/volume_mute.svg"
local volume_down = HOME .. "/.config/awesome/statusbar/modules/volume/volume_down.svg"
local volume_up = HOME .. "/.config/awesome/statusbar/modules/volume/volume_up.svg"

local M = {}

-- Volume
M.icon = wibox.widget.imagebox(colorize(volume_down, theme.widget_main_color))

M.widget = lain.widget.pulse({
  settings = function()
    if volume_now.muted ~= "yes" then
      if not volume_now.right and tonumber(volume_now.right) <= 20 then
        M.icon:set_image(colorize(volume_mute, theme.widget_main_color))
      elseif not volume_now.right and tonumber(volume_now.right) <= 60 then
        M.icon:set_image(colorize(volume_down, theme.widget_main_color))
      else
        M.icon:set_image(colorize(volume_up, theme.widget_main_color))
      end
      widget:set_markup(markup(theme.foreground, volume_now.right .. "%"))
    else
      widget:set_markup(markup(theme.foreground, "Muted"))
    end
  end
}).widget -- call the actual lain widget

return M

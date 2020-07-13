local awful = require("awful")
awful.util = require("awful.util")

theme_path = awful.util.getdir("config") .. "/themes/mine/"

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --
-- default variables

theme = {}

dofile(theme_path .. "elements.lua")
dofile(theme_path .. "titlebar.lua")
dofile(theme_path .. "layouts.lua")

--theme.wallpaper          = theme_path .. "background.jpg"
--theme.wallpaper          = theme_path .. "../default/backgrounds/the_creation_of_fractals_by_rychveldir_ddzogci.png"
--theme.wallpaper          = theme_path .. "../default/backgrounds/fractal_art_12__dual_4k__by_kasperja_ddb3siy.png"
--theme.wallpaper          = theme_path .. "../default/backgrounds/nightfall_lake_3440x1440_by_elkaez_d8orrzb.jpg"
--theme.wallpaper          = theme_path .. "../default/backgrounds/green_background.jpg"

theme.wallpaper          = theme_path .. "../default/backgrounds/fractal_art_18__dual_4k__by_kasperja_ddvmsni.png"
theme.awesome_icon       = theme_path .. "launcher/logo20_kali_white.png"
theme.awesome_subicon    = theme_path .. "launcher/logo20_kali_white.png"

return theme



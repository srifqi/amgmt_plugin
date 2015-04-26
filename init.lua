-- Plugin for Another Map Generator mod for Minetest [amgmt_plugin] by srifqi
-- License: CC0 1.0 Universal
-- Dependencies: amgmt, default

print("[amgmt_plugin] (Plugin for Another Map Generator for Minetest)")

-- parameter
local ACTIVATED_PLUGIN = {}
local DEBUG = true

if not minetest.get_modpath("amgmt") then
	minetest.log("error","[amgmt_plugin] You need amgmt mod to run this plugin")
	return false, "You need amgmt mod to run this plugin"
end
if not amgmt.biome.clear then
	minetest.log("error","[amgmt_plugin] You need to update your amgmt mod to at minimum 0.5")
	return false, "You need to update your amgmt to at minimum 0.5"
end

-- Minetest library - misc_helpers.lua
function file_exists(filename)local f=io.open(filename, "r");if f==nil then return false else f:close() return true	end end
-- read and check file
if file_exists(minetest.get_worldpath()..DIR_DELIM.."amgmt_plugin.txt") == true then
	local list = io.open(minetest.get_worldpath()..DIR_DELIM.."amgmt_plugin.txt", "r")
	for plugin in list:lines() do
		ACTIVATED_PLUGIN[#ACTIVATED_PLUGIN] = plugin
	end
	list:close()
else
	local list = io.open(minetest.get_worldpath()..DIR_DELIM.."amgmt_plugin.txt", "w")
	for i = 1 , #ACTIVATED_PLUGIN do
		list:write(ACTIVATED_PLUGIN[i].."\n")
	end
	list:close()
end

for i = 1, #ACTIVATED_PLUGIN do
	local plugin = ACTIVATED_PLUGIN[i]
	dofile(minetest.get_modpath("amgmt_plugin")..DIR_DELIM..plugin..DIR_DELIM.."init.lua")
	if DEBUG == true then
		print("[amgmt_plugin] "..plugin.." loaded")
	end
end
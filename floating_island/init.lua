-- Floating Island [floating_island] by srifqi
-- License: CC0 1.0 Universal

local gci = minetest.get_content_id
local badd = amgmt.biome.add
-- get content id
local c_air = gci("air")
local c_stone = gci("default:stone")
local c_dirt = gci("default:dirt")
local c_dirt_grass = gci("default:dirt_with_grass")
local c_sand = gci("default:sand")
local c_sandstone = gci("default:sandstone")

-- clear biome
amgmt.biome.clear()

-- add biome
badd({
	name = "Plains",
	mint = 0,
	maxt = 1,
	minh = 0,
	maxh = 50,
	spawn_here = true,
	trees = {{"grass14",30}, {"grass35",5},{"flowers",15},{"normal",50}},
	get_block = function(temp, humi, base, wl, y)
		if base < 0 or y < -base then
			return c_air
		elseif y < base - 3 then
			return c_stone
		elseif y < base then
			return c_dirt
		elseif y == base then
			return c_dirt_grass
		else
			return c_air
		end
	end
})
badd({
	name = "Jungle",
	mint = 0,
	maxt = 1,
	minh = 50,
	maxh = 100,
	spawn_here = true,
	trees = {{"jungle",16},{"jungle_grass",5},{"flowers",20}},
	get_block = function(temp, humi, base, wl, y)
		if base < 0 or y < -base then
			return c_air
		elseif y < base - 3 then
			return c_stone
		elseif y < base then
			return c_dirt
		elseif y == base then
			return c_dirt_grass
		else
			return c_air
		end
	end
})
badd({
	name = "Desert",
	mint = 1,
	maxt = 2,
	minh = 0,
	maxh = 100,
	spawn_here = true,
	trees = {{"cactus",30}},
	get_block = function(temp, humi, base, wl, y)
		if base < 0 or y < -base then
			return c_air
		elseif y < base - 3 then
			return c_stone
		elseif y < base then
			return c_sandstone
		elseif y == base then
			if base < 2 then
				return c_sandstone
			else
				return c_sand
			end
		else
			return c_air
		end
	end
})
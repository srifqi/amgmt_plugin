-- Love The Desert [love_desert] by srifqi
-- License: CC0 1.0 Universal

local gci = minetest.get_content_id
local badd = amgmt.biome.add
-- get content id
local c_air = gci("air")
local c_ignore = gci("ignore")
local c_water = gci("default:water_source")
local c_stone = gci("default:stone")
local c_desertstone = gci("default:desert_stone")
local c_sand = gci("default:sand")
local c_sandstone = gci("default:sandstone")
local c_sandstonebrick = gci("default:sandstonebrick")

-- clear biome
amgmt.biome.clear()

-- add biome - only desert though
badd({
	name = "Desert",
	mint = 0,
	maxt = 2,
	spawn_here = true,
	trees = {{"cactus",50},{"dry_shrub",50},{"desert_well",512},{"sandstone_boulder",256}},
	get_block = function(temp, humi, base, wl, y)
		if y > base and y > wl then
			return c_air
		elseif y > base and y <= wl then
			if base < wl then
				return c_water
			elseif base >= wl then
				return c_air
			end
		elseif y < base - 32 then
			return c_stone
		elseif y < base - 3 then
			return c_desertstone
		elseif y < base - 2 then
			return c_sandstone
		elseif y <= base then
			return c_sand
		else
			return c_sand
		end
	end
})

-- add tree (aka decoration)
local regtr = amgmt.tree.register
regtr({
	name = "desert_well",
	chance = 512,
	minh = 5,
	maxh = 85,
	grows_on = "default:sand",
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y, pos.z
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			-- place brick nearby
			data[area:index(x-1,y,z)] = c_sandstonebrick
			data[area:index(x+1,y,z)] = c_sandstonebrick
			data[area:index(x,y,z-1)] = c_sandstonebrick
			data[area:index(x,y,z+1)] = c_sandstonebrick
			data[area:index(x,y-1,z)] = c_sandstonebrick
			-- place a water source
			data[vi] = c_water
		end
		
		--amgmt.debug("desert well spawned at:"..x..","..y..","..z)
	end
})
regtr({
	name = "sandstone_boulder",
	chance = 256,
	minh = 10,
	maxh = 80,
	grows_on = "default:sand",
	grow = function(pos, data, area, seed, minp, maxp, pr)
		local x, y, z = pos.x, pos.y+1, pos.z -- y is moved higher to make boulder-like
		local vi = area:index(x, y, z)
		if data[vi] == c_air or data[vi] == c_ignore then
			-- place brick nearby
			data[area:index(x-1,y,z)] = c_sandstone
			data[area:index(x+1,y,z)] = c_sandstone
			data[area:index(x,y,z-1)] = c_sandstone
			data[area:index(x,y,z+1)] = c_sandstone
			data[area:index(x,y-1,z)] = c_sandstone
			data[area:index(x,y+1,z)] = c_sandstone
			-- place a water source at center
			data[vi] = c_water
		end
		
		--amgmt.debug("sandstone boulder spawned at:"..x..","..y..","..z)
	end
})
meta.name = "Chad Shops"
meta.description = [[Customizable 1-2 shop for speedrunning]]
meta.version = "1.0.0"
meta.author = "Flexlolo"

local Ordered_Options = require "ordered_options"

local ITEM_SETS = {
	SET_01 = { display_name = "Any%", items = {ENT_TYPE.ITEM_PURCHASABLE_JETPACK, ENT_TYPE.ITEM_TELEPORTER, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_COMPASS} },
	SET_02 = { display_name = "Any% NoTP", items = {ENT_TYPE.ITEM_PURCHASABLE_JETPACK, ENT_TYPE.ITEM_MATTOCK, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_COMPASS} },
	SET_03 = { display_name = "Any% NoTP NG", items = {ENT_TYPE.ITEM_PURCHASABLE_JETPACK, ENT_TYPE.ITEM_MATTOCK, ENT_TYPE.ITEM_PICKUP_SPECTACLES, ENT_TYPE.ITEM_PICKUP_COMPASS} },
	SET_04 = { display_name = "CO%", items = {ENT_TYPE.ITEM_PURCHASABLE_JETPACK, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_BOMBBOX} },
	SET_05 = { display_name = "Duat%", items = {ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK, ENT_TYPE.ITEM_TELEPORTER, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_BOMBBOX} },
}

local ITEM_SETS_ORDER = {
	"SET_01",
	"SET_02",
	"SET_03",
	"SET_04",
	"SET_05"
}

local DEFAULT_OPTION_VALUES = {
	item_set = "SET_01",
}

local ordered_options

-- Merges two tables. If both tables contain the same key, then the value from table2 is used. A nil table is handled as though it were an empty table.
local function merge_tables(table1, table2)
	local merged_table = {}
	if table1 then
		for k, v in pairs(table1) do
			merged_table[k] = v
		end
	end
	if table2 then
		for k, v in pairs(table2) do
			merged_table[k] = v
		end
	end
	return merged_table
end

local function has(arr, item)
	for i, v in pairs(arr) do
		if v == item then
			return true
		end
	end
	return false
end

local function join(a, b)
    local result = {table.unpack(a)}
    table.move(b, 1, #b, #result + 1, result)
    return result
end

local shop_rooms_left = {
	ROOM_TEMPLATE.SHOP_LEFT,
	ROOM_TEMPLATE.SHOP_ENTRANCE_UP_LEFT,
	ROOM_TEMPLATE.SHOP_ENTRANCE_DOWN_LEFT,
}

local shop_rooms_right = {
	ROOM_TEMPLATE.SHOP,
	ROOM_TEMPLATE.SHOP_ENTRANCE_UP,
	ROOM_TEMPLATE.SHOP_ENTRANCE_DOWN,
}

local shop_rooms = join(shop_rooms_left, shop_rooms_right)

local shop_items = {
	ENT_TYPE.ITEM_PICKUP_ROPEPILE, 
	ENT_TYPE.ITEM_PICKUP_BOMBBAG, 
	ENT_TYPE.ITEM_PICKUP_BOMBBOX, 
	ENT_TYPE.ITEM_PICKUP_PARACHUTE, 
	ENT_TYPE.ITEM_PICKUP_SPECTACLES, 
	ENT_TYPE.ITEM_PICKUP_SKELETON_KEY, 
	ENT_TYPE.ITEM_PICKUP_COMPASS, 
	ENT_TYPE.ITEM_PICKUP_SPRINGSHOES, 
	ENT_TYPE.ITEM_PICKUP_SPIKESHOES, 
	ENT_TYPE.ITEM_PICKUP_PASTE, 
	ENT_TYPE.ITEM_PICKUP_PITCHERSMITT, 
	ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, 
	ENT_TYPE.ITEM_WEBGUN, 
	ENT_TYPE.ITEM_MACHETE, 
	ENT_TYPE.ITEM_BOOMERANG, 
	ENT_TYPE.ITEM_CAMERA, 
	ENT_TYPE.ITEM_MATTOCK, 
	ENT_TYPE.ITEM_TELEPORTER, 
	ENT_TYPE.ITEM_FREEZERAY, 
	ENT_TYPE.ITEM_METAL_SHIELD, 
	ENT_TYPE.ITEM_PURCHASABLE_CAPE, 
	ENT_TYPE.ITEM_PURCHASABLE_HOVERPACK, 
	ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK, 
	ENT_TYPE.ITEM_PURCHASABLE_POWERPACK, 
	ENT_TYPE.ITEM_PURCHASABLE_JETPACK, 
	ENT_TYPE.ITEM_PRESENT, 
	ENT_TYPE.ITEM_PICKUP_HEDJET, 
	ENT_TYPE.ITEM_PICKUP_ROYALJELLY, 
	ENT_TYPE.ITEM_ROCK, 
	ENT_TYPE.ITEM_SKULL, 
	ENT_TYPE.ITEM_POT, 
	ENT_TYPE.ITEM_WOODEN_ARROW, 
	ENT_TYPE.ITEM_PICKUP_COOKEDTURKEY,

	ENT_TYPE.ITEM_SHOTGUN, 
	ENT_TYPE.ITEM_PLASMACANNON, 
	ENT_TYPE.ITEM_FREEZERAY, 
	ENT_TYPE.ITEM_WEBGUN, 
	ENT_TYPE.ITEM_CROSSBOW,
}

set_pre_entity_spawn(function(type, x, y, l, overlay)
	local rx, ry = get_room_index(x, y)
	local roomtype = get_room_template(rx, ry, l)
	if state.theme == THEME.DWELLING and state.level == 2 then
		if has(shop_rooms, roomtype) then
			local items = ITEM_SETS[ordered_options:get_value("item_set")].items
			local eid = items[math.floor(x) % 4 + 1]
			return spawn_entity_nonreplaceable(eid, x, y, l, 0, 0)
		end
	end
	return spawn_entity_nonreplaceable(type, x, y, l, 0, 0)
end, SPAWN_TYPE.LEVEL_GEN, MASK.ITEM, shop_items)


set_callback(function(ctx)
	if state.screen ~= SCREEN.LEVEL then return end
	if state.theme == THEME.DWELLING and state.level == 2 then
		for x = 0, state.width - 1 do
			for y = 0, state.height - 1 do
				local room = get_room_template(x, y, 0)
				local is_left = has(shop_rooms_left, room)
				local is_right = has(shop_rooms_right, room)

				if is_left or is_right then
					-- hardcoded offsets x_x
					rx, ry = get_room_pos(x, y)
					ry = ry - 3.0

					if is_right then
						rx = rx + 8.0
					else
						rx = rx + 1.0
					end

					spawn_entity_nonreplaceable(ENT_TYPE.DECORATION_SHOPSIGN, rx, ry, LAYER.FRONT, 0.0, 0.0)
					spawn_entity_nonreplaceable(ENT_TYPE.DECORATION_BASECAMPSIGN, rx, ry, LAYER.FRONT, 0.0, 0.0)
				end
			end
		end
	end
end, ON.LOADING)

set_pre_tile_code_callback(function(x, y, layer, room_template)
	if state.theme == THEME.DWELLING and state.level == 2 then
		spawn_grid_entity(ENT_TYPE.FLOOR_GENERIC, x, y, layer)
		return true
	end
end, "shop_sign")

local function register_options(initial_values)
	ordered_options = Ordered_Options:new(merge_tables(DEFAULT_OPTION_VALUES, initial_values))

	ordered_options:register_option_combo("item_set",
		"Select shop item set",
		"",
		ITEM_SETS, ITEM_SETS_ORDER)
end

set_callback(function(ctx)
	local load_json = ctx:load()
	local load_table
	if not load_json or load_json == "" then
		load_table = {}
	else
		local success, result = pcall(function() return json.decode(load_json) or {} end)
		if success then
			load_table = result
		else
			print(F"Warning: Failed to read saved data: {result}")
			load_table = {}
		end
	end

	register_options(load_table.options)

end, ON.LOAD)

set_callback(function(ctx)
	-- Note: This callback is not called when exiting the game straight out of a level, and it isn't currently possible to save outside this callback without enabling unsafe mode.
	local save_json = json.encode({
		version = meta.version,
		options = ordered_options:to_table()
	})
	ctx:save(save_json)
end, ON.SAVE)
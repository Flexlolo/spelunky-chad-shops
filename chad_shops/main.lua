meta.name = "Chad Shops"
meta.description = [[Customizable 1-2 shop for speedrunning]]
meta.version = "1.1.1"
meta.author = "Flexlolo"

local Ordered_Options = require "ordered_options"
local ordered_options

local ITEM_SETS = {}
local ITEM_SETS_ORDER = {}

local PRESENT_ITEMS = {}
local PRESENT_ITEMS_ORDER = {}

-- really?
local function get_table_size(table)
  local count = 0
  for _ in pairs(table) do count = count + 1 end
  return count
end

local function add_item_set(name, items)
	table.insert(ITEM_SETS, {display_name=name, items=items})
	table.insert(ITEM_SETS_ORDER, get_table_size(ITEM_SETS))
end

local function add_present_item(name, item)
	table.insert(PRESENT_ITEMS, {display_name=name, item=item})
	table.insert(PRESENT_ITEMS_ORDER, get_table_size(PRESENT_ITEMS))
end

add_item_set("JP TP BB Compass", {ENT_TYPE.ITEM_PURCHASABLE_JETPACK, ENT_TYPE.ITEM_TELEPORTER, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_COMPASS})
add_item_set("JP MTK BB Compass", {ENT_TYPE.ITEM_PURCHASABLE_JETPACK, ENT_TYPE.ITEM_MATTOCK, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_COMPASS})
add_item_set("JP MTK Specs Compass", {ENT_TYPE.ITEM_PURCHASABLE_JETPACK, ENT_TYPE.ITEM_MATTOCK, ENT_TYPE.ITEM_PICKUP_SPECTACLES, ENT_TYPE.ITEM_PICKUP_COMPASS})
add_item_set("JP BB BB BB", {ENT_TYPE.ITEM_PURCHASABLE_JETPACK, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_BOMBBOX})
add_item_set("TPP TP BB Compass", {ENT_TYPE.ITEM_PURCHASABLE_TELEPORTER_BACKPACK, ENT_TYPE.ITEM_TELEPORTER, ENT_TYPE.ITEM_PICKUP_BOMBBOX, ENT_TYPE.ITEM_PICKUP_BOMBBOX})
add_item_set("CG Springs Spikes Mitt", {ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, ENT_TYPE.ITEM_PICKUP_SPRINGSHOES, ENT_TYPE.ITEM_PICKUP_SPIKESHOES, ENT_TYPE.ITEM_PICKUP_PITCHERSMITT})
add_item_set("CG Springs Spikes Specs", {ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES, ENT_TYPE.ITEM_PICKUP_SPRINGSHOES, ENT_TYPE.ITEM_PICKUP_SPIKESHOES, ENT_TYPE.ITEM_PICKUP_SPECTACLES})
add_item_set("Cape Spikes Specs Ropes", {ENT_TYPE.ITEM_PURCHASABLE_CAPE, ENT_TYPE.ITEM_PICKUP_SPIKESHOES, ENT_TYPE.ITEM_PICKUP_SPECTACLES, ENT_TYPE.ITEM_PICKUP_ROPEPILE})

add_present_item("Rope Pile", ENT_TYPE.ITEM_PICKUP_ROPEPILE)
add_present_item("Bomb Bag", ENT_TYPE.ITEM_PICKUP_BOMBBAG)
add_present_item("Bomb Box", ENT_TYPE.ITEM_PICKUP_BOMBBOX)
add_present_item("Parachute", ENT_TYPE.ITEM_PICKUP_PARACHUTE)
add_present_item("Spectacles", ENT_TYPE.ITEM_PICKUP_SPECTACLES)
add_present_item("Climbing Gloves", ENT_TYPE.ITEM_PICKUP_CLIMBINGGLOVES)
add_present_item("Pitcher's Mitt", ENT_TYPE.ITEM_PICKUP_PITCHERSMITT)
add_present_item("Spring Shoes", ENT_TYPE.ITEM_PICKUP_SPRINGSHOES)
add_present_item("Spike Shoes", ENT_TYPE.ITEM_PICKUP_SPIKESHOES)
add_present_item("Paste", ENT_TYPE.ITEM_PICKUP_PASTE)
add_present_item("Compass", ENT_TYPE.ITEM_PICKUP_COMPASS)
add_present_item("Machete", ENT_TYPE.ITEM_MACHETE)
add_present_item("Boomerang", ENT_TYPE.ITEM_BOOMERANG)
add_present_item("Mattock", ENT_TYPE.ITEM_MATTOCK)
add_present_item("Camera", ENT_TYPE.ITEM_CAMERA)
add_present_item("Teleporter", ENT_TYPE.ITEM_TELEPORTER)
add_present_item("Crossbow", ENT_TYPE.ITEM_CROSSBOW)
add_present_item("Freeze Ray", ENT_TYPE.ITEM_FREEZERAY)
add_present_item("Shotgun", ENT_TYPE.ITEM_SHOTGUN)
add_present_item("Cape", ENT_TYPE.ITEM_CAPE)
add_present_item("Jetpack", ENT_TYPE.ITEM_JETPACK)
add_present_item("Powerpack", ENT_TYPE.ITEM_POWERPACK)
add_present_item("Royal Jelly", ENT_TYPE.ITEM_PICKUP_ROYALJELLY)
add_present_item("Plasma Cannon", ENT_TYPE.ITEM_PLASMACANNON)

local DEFAULT_OPTION_VALUES = {
	item_set = 1,
	present = false,
	present_item = 1
}

local SHOP_ITEM_LIST = {
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

	ENT_TYPE.ITEM_SHOTGUN, 
	ENT_TYPE.ITEM_PLASMACANNON, 
	ENT_TYPE.ITEM_FREEZERAY, 
	ENT_TYPE.ITEM_WEBGUN, 
	ENT_TYPE.ITEM_CROSSBOW,
}

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

set_pre_entity_spawn(function(type, x, y, layer, overlay)
	local rx, ry = get_room_index(x, y)
	local roomtype = get_room_template(rx, ry, layer)
	if state.theme == THEME.DWELLING and state.level == 2 and layer == LAYER.FRONT then
		if has(shop_rooms, roomtype) then
			local index = math.floor(x) % 4 + 1
			local eid
			if ordered_options:get_value("present") and index == 4 then
				eid = spawn_entity_nonreplaceable(ENT_TYPE.ITEM_PRESENT, x, y, layer, 0, 0)
				local entity = get_entity(eid)
				entity.inside = PRESENT_ITEMS[ordered_options:get_value("present_item")].item
			else
				local items = ITEM_SETS[ordered_options:get_value("item_set")].items
				eid = spawn_entity_nonreplaceable(items[index], x, y, layer, 0, 0)
			end

			return eid
		end
	end
end, SPAWN_TYPE.LEVEL_GEN, MASK.ITEM, SHOP_ITEM_LIST)

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
						rx = rx + 9.0
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

local function register_options(initial_values)
	ordered_options = Ordered_Options:new(merge_tables(DEFAULT_OPTION_VALUES, initial_values))

	ordered_options:register_option_combo("item_set",
		"Select shop item set",
		"",
		ITEM_SETS, ITEM_SETS_ORDER)

	ordered_options:register_option_bool("present",
        "Replace last shop item with present", "")

	ordered_options:register_option_combo("present_item",
		"Set present content",
		"",
		PRESENT_ITEMS, PRESENT_ITEMS_ORDER)
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
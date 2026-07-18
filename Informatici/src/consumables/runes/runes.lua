SMODS.Atlas{
	key = 'runes',
	path = 'runes.png',
	px = 71,
	py = 95
}

SMODS.ConsumableType{
    key = 'Rune',
    loc_txt = {
 		name = 'Runa',
 		collection = 'Rune'
 	},
	collection_rows = { 4, 5 },
    primary_colour = HEX('301d33'),
    secondary_colour = HEX('4b2d50'),
    shop_rate = 0
}

assert(SMODS.load_file("src/consumables/runes/fehu.lua"))()
assert(SMODS.load_file("src/consumables/runes/ansuz.lua"))()
assert(SMODS.load_file("src/consumables/runes/yera.lua"))()
assert(SMODS.load_file("src/consumables/runes/elhaz.lua"))()
assert(SMODS.load_file("src/consumables/runes/hagalaz.lua"))()
assert(SMODS.load_file("src/consumables/runes/dagaz.lua"))()
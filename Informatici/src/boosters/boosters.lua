SMODS.Atlas{
	key = 'boosters',
	path = 'boosters.png',
	px = 71,
	py = 95
}
assert(SMODS.load_file("src/boosters/runeBooster1.lua"))()
assert(SMODS.load_file("src/boosters/runeBooster2.lua"))()
assert(SMODS.load_file("src/boosters/runeBoosterJumbo.lua"))()
assert(SMODS.load_file("src/boosters/runeBoosterMega.lua"))()
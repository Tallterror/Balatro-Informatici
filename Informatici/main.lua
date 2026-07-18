informatica = {}
informatica.values = {}
informatica.values.runeSpawn = 0
informatica.colours = {}
informatica.colours.rune = HEX('6512B2')
informatica.colours.runebooster = HEX('A545D2')

SMODS.optional_features.cardareas.discard = true
SMODS.optional_features.post_trigger = true
SMODS.optional_features.hand_drawn = true
SMODS.optional_features.modify_ante = true

assert(SMODS.load_file("src/challenges.lua"))()
assert(SMODS.load_file("src/jolly/jolly.lua"))()
assert(SMODS.load_file("src/blinds/blinds.lua"))()
assert(SMODS.load_file("src/consumables/consumables.lua"))()
assert(SMODS.load_file("src/vouchers/vouchers.lua"))()
assert(SMODS.load_file("src/boosters/boosters.lua"))()
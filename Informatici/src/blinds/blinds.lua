SMODS.Atlas{
    key = 'blinds',
	path = 'blinds.png',
    atlas_table = 'ANIMATION_ATLAS',
    frames = 21,
	px = 34,
	py = 34
}
assert(SMODS.load_file("src/blinds/analisi.lua"))()
assert(SMODS.load_file("src/blinds/lps.lua"))()
assert(SMODS.load_file("src/blinds/lambda.lua"))()
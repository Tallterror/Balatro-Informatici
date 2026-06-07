--Joker di Alessandro
SMODS.Joker{
	discovered = true,
	key = 'erkjo',
	atlas = 'jokers',
	pos = {x = 3, y = 1},
	rarity = 3,
	cost = 0,
	loc_txt = {
		name = 'erkJo',
		text = {
			'rimuove tutti i jolli',
			'dal negozio e li rimpiazza',
			'con jolli glitch'
		}
	},
	config = { extra = {}},
	calculate = function(self, card, context)
		if not G.GAME then return end
        if not context.modify_shop_card then return end
        if not context.card then return end

		local shop_card = context.card
        if shop_card.config.center.set ~= "Joker" then return end
		if not (shop_card.config and shop_card.config.center) then return end
		local new_card = SMODS.create_card({
            set = "Joker",
			key = "j_in_jollyGlitch",
        })
		if new_card and new_card.config and new_card.config.center then
        	shop_card:set_ability(new_card.config.center.key)
        end
		SMODS.destroy_cards(new_card, true, true, true)
	end
}
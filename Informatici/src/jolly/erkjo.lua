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
	config = { extra = {repetition = 1}},
	calculate = function(self, card, context)
		if not G.GAME then return end
        if not context.modify_shop_card then return end
        if not context.card then return end

		local shop_card = context.card
        if shop_card.config.center.set ~= "Joker" then return end
		if not (shop_card.config and shop_card.config.center) then return end
        shop_card:set_ability("j_in_jollyGlitch")

		local repetition = card.ability.extra.repetition
		repeat
			shop_card.cost = pseudorandom('errorCost2', 1, 99)
			repetition = repetition - 1
		until repetition <= 0 or shop_card.cost <= 30
		if shop_card.cost > 30 then
			card.ability.extra.repetition = card.ability.extra.repetition + 1
		else
			shop_card.cost = shop_card.cost / math.sqrt(card.ability.extra.repetition)
			card.ability.extra.repetition = 1
		end
	end
}
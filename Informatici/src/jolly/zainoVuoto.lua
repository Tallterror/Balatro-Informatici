SMODS.Joker{
	key = 'zaino',
	unlocked = true,
	discovered = true,
	rarity = 2,
	atlas = 'jokers',
	pos = {x = 5, y = 1},
	config = {extra = {chips = 0,mult = 0,xmult = 1, addchips = 15, addmult = 3, addxmult = 0.1}},
	
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
  				card.ability.extra.chips,
				card.ability.extra.mult,
				card.ability.extra.xmult,
				card.ability.extra.addchips,
				card.ability.extra.addmult,
				card.ability.extra.addxmult,
			}
		}
	end,
	loc_txt = {
		name = 'Zaino vuoto',
		text = {
			'All uscita del negozio aggiunge al joker',
			'{C:chips}+#4#{} Chips per ogni {C:tarot}tarocco{} posseduto',
			'{C:mult}+#5#{} Molt per ogni {C:planet}pianeta{} posseduto',
			'{X:mult,C:white}X#6#{} Molt per ogni {C:spectral}carta spettrale{} posseduta',
			'{C:inactive}Attualmente {C:chips}+#1#{C:inactive} Chips,',
			'{C:mult}+#2#{C:inactive} Molt e {X:mult,C:white}X#3#{C:inactive} Molt'
		}
	},
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				chips = card.ability.extra.chips,
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.xmult
			}
		end
		if context.ending_shop then
			for _, carta in pairs(G.consumeables.cards) do
				G.E_MANAGER:add_event(Event({
					delay = 0.2,
					func = function()
						card:juice_up(0.3, 0.5)
						if carta.ability.set == 'Planet' then
							card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.addmult
						elseif carta.ability.set == 'Spectral' then
							card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.addxmult
						else
							card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.addchips
						end
						return {message = 'potenziamento'}
					end
				}))
			end
		end							
	end
}
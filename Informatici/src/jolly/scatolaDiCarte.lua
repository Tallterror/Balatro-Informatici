--Pinder Kingui
SMODS.Joker{
	key = 'scatola',
	unlocked = true,
	discovered = true;
	config = {extra = {mult = 0, add = 1, chance = 7, cards = {}}},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
			card.ability.extra.mult,
			card.ability.extra.add,
			G.GAME.probabilities.normal,
			card.ability.extra.chance
			}
		}
	end,
	loc_txt = {
		name = 'Scatola di carte',
		text = {
			'{C:green}#3# possibilità su #4#{} di',
			'pescare una carta girata',
			'{C:mult}+#2#{} molt per ogni {C:attention}carta',
            '{C:attention}da gioco {}giocata e scoperta',
            '{C:inactive}Attualmente {C:mult}+#1#{C:inactive} molt'
		}
	},
	atlas = 'jokers',
	pos = {x = 7, y = 0},
	rarity = 1,
	cost = 4,
	calculate = function(self, card, context)
		if context.joker_main then
			return {
				mult = card.ability.extra.mult
			}
		end

		if context.press_play then
			card.ability.extra.cards = {}
			for _,v in pairs(G.hand.highlighted) do
				if v.facing == 'back' then
					table.insert(card.ability.extra.cards, v)
				end
			end
		end
	
		if context.individual and context.cardarea == G.play then
			for i=1, #card.ability.extra.cards do
				if context.other_card == card.ability.extra.cards[i] then
					card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.add
				end
			end
		end
		
		if context.stay_flipped and context.to_area == G.hand and
		SMODS.pseudorandom_probability(card, 'scatola', G.GAME.probabilities.normal, card.ability.extra.chance) then
            return {
                stay_flipped = true
            }
		end
	end,

	    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
		return {
            text = {
				{ text = "+" , colour = G.C.RED},
                { ref_table = "card.ability.extra", ref_value = "mult", colour = G.C.RED},
            },
		}
	end
}
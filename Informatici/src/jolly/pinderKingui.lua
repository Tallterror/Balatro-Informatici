--Pinder Kingui
SMODS.Joker{
	key = 'pinder',
	unlocked = true,
	discovered = true;
	config = {xmult = 1.5, mult = 20, less = 5},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
			card.ability.xmult,
			card.ability.mult,
			card.ability.less	
			}
		}
	end,
	loc_txt = {
		name = 'Pinder Kingui',
		text = {
			'{X:mult,C:white}X#1#{} molt e {C:mult}+#2#{} molt',
			'per la prima mano giocata,',
			'{C:mult}-#3#{} molt per ogni round'
		}
	},
	atlas = 'jokers',
	pos = {x = 1, y = 0},
	rarity = 1,
	cost = 4,
	calculate = function(self, card, context)
		 if context.first_hand_drawn and not context.blueprint then
			local eval = function() return G.GAME.current_round.hands_played == 0 and not G.RESET_JIGGLES end
			juice_card_until(card, eval, true)
		end
		if context.joker_main and G.GAME.current_round.hands_played == 0 then
			return {
				mult = card.ability.mult,
				xmult = card.ability.xmult,
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.mult = card.ability.mult - card.ability.less
			if card.ability.mult <= 0 then
				SMODS.destroy_cards(card)
				return {message = 'Gulp!',}
			else
				return {message = '-5 molt',}
			end
		end
	end,

	    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
		return {
            text = {
				{ text = "+" , colour = G.C.RED},
                { ref_table = "card.ability", ref_value = "mult", colour = G.C.RED},
            },
			reminder_text = {
				{
					border_nodes = {
						{ text = "X", colour = G.C.WHITE},
						{ ref_table = "card.ability", ref_value = "xmult", retrigger_type = "exp", colour = G.C.WHITE }
					}
				}
			}
		}
	end
}
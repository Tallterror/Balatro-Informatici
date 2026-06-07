SMODS.Joker{
	key = 'gruppodistudio',
	unlocked = true,
	discovered = true,
	atlas = 'jokers',
	pos = {x = 5, y = 0},
	config = {chips = 15},

	loc_vars = function(self, info_queue, card)
		return {
			vars = {
  				card.ability.chips,
				card.ability.chips * (G.jokers and #G.jokers.cards or 0),
			}
		}
	end,
	loc_txt = {
		name = 'Gruppo di studio',
		text = {
			'{C:chips}+#1#{} chips per ogni',
			'jolli posseduto.',
			'{C:inactive}Attualmente {C:chips}+#2# {C:inactive}chips'
		}
	},
	calculate = function(self, card, context)
		if context.joker_main then
			return { chips = card.ability.chips * #G.jokers.cards }
		end
	end,

	joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
		return {
			text = {
				{
					border_nodes = {
						{ text = "+"},
                		{ ref_table = "card.ability", ref_value = "chips", colour = G.C.CHIPS },
            		}
				}
			}
		}
	end
}
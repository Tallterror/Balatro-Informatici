--Joker di Roberto
SMODS.Joker{
	key = 'cavallo',
	unlocked = true,
	blueprint = true;
	blue = true;
	config = { xMult = 1 ,addmult = 0.3, final = {xMult = 1}, joker_display_values = {xMult = 1}},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.addmult,
				card.ability.xMult,
			}
		}
	end,

	loc_txt = {
		name = 'Voldemort con la testa da cavallo',
		text = {
			'Aggiunge {X:mult,C:white}X#1#{} molt per',
			'9 scartato.',
			'Assegna il suo {X:mult,C:white}Xmolt{} per',
			'9 giocato.',
			'{C:inactive}si resetta alla fine del round{}',
			'{C:inactive}attualmente {X:mult,C:white}X#2#{} molt'
		}
	},
	atlas = 'jokers',
	pos = {x = 4, y = 0},
	soul_pos = {x = 4, y = 1},
	rarity = 4,
	cost = 10,

    calculate = function(self, card, context)

		if context.discard and not context.blueprint then
			if context.other_card:get_id() and context.other_card:get_id() == 9 then
				G.E_MANAGER:add_event(Event({
					delay = 0.2,
					func = function()
						card.ability.xMult = card.ability.xMult + card.ability.addmult
						return {message = 'X' .. card.ability.addmult}
					end,
				}))
			end
		end
		
 		if context.individual and context.cardarea == G.play and not context.end_of_round and context.other_card:get_id() and context.other_card:get_id() == 9 then
			return {
                xmult = card.ability.xMult,
			}
        end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.xMult = card.ability.final.xMult
		end
    end,


	joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
        return {
            text = {
        		{
            		border_nodes = {
                		{ text = "X" },
                		{ ref_table = "card.joker_display_values", ref_value = "xMult", retrigger_type = "exp" }
            		}
        		}
    		},
    		reminder_text = {
        		{ text = "(" },
        		{ text = "9", colour = G.C.ORANGE },
        		{ text = "," },
        		{ text = "Cavallo", colour = G.C.ORANGE },
        		{ text = ")" },
    		},
    		calc_function = function(card)
        		local count = 0
        		local text, _, scoring_hand = JokerDisplay.evaluate_hand()
        		if text ~= 'Unknown' then
            		for _, scoring_card in pairs(scoring_hand) do
                		if scoring_card:get_id() and scoring_card:get_id() == 9  then
                    		count = count +
                        	JokerDisplay.calculate_card_triggers(scoring_card, scoring_hand)
                		end
            		end
        		end
        		card.joker_display_values.xMult = card.ability.xMult ^ count
    		end
        }
	end
}
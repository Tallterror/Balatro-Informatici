--Joker di Carmine
SMODS.Joker{
	key = 'affamato',
	unlocked = true,
	discovered = true;
	loc_txt = {
		name = 'Jolly Affamato',
		text = {
			'Se il primo scarto del round',
			'ha solo 1 figura {C:attention}una figura{}, crea un',
			'{C:tarot}tarocco{} casuale',
		}
	},
	atlas = 'jokers',
	pos = {x = 0, y = 0},
	rarity = 2,
	cost = 6,

	calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.discard and not context.blueprint and
            G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            		if (context.other_card:is_face()) then
                	G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	return {
                    	extra = {
                    		message = 'Vieni a fumare',
                        	message_card = card,
                        	func = function()
                            	G.E_MANAGER:add_event(Event({
                                	func = (function()
                                    	SMODS.add_card {
                                        	set = 'Tarot',
                                        	key_append = 'affamato'
                                    		}
                                    	G.GAME.consumeable_buffer = 0
                                    	return true
                                	end)
                            	}))
                        	end
                    	},
                	}
            	end
			end
        end
    end
}
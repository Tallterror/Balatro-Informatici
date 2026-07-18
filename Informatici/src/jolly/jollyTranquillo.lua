--Joker Tranquillo
SMODS.Joker{
	key = 'tranquillo',
	unlocked = true,
	discovered = true,
	blueprint_compat = false,
	config = { extra = {hands = {}}},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.active,
				card.ability.extra.final,
			}
		}
	end,
	
	loc_txt = {
		name = 'Jolly Tranquillo',
		text = {
			'Crea il {C:planet}pianeta{} dell ultima',
			'mano giocata se questa non è',
			'ancora stata giocata nell',
			'ante attuale'
		}
	},
	atlas = 'jokers',
	pos = {x = 1, y = 1},
	rarity = 1,
	cost = 4,
	calculate = function(self, card, context)
		if context.blueprint then return end

		if context.ante_change and context.ante_end then
			card.ability.extra.hands = {}
			return  {
				message = 'Resettato'
			}
		end

		if context.before then
			local active = true
			for i = 1, #card.ability.extra.hands do
                if card.ability.extra.hands[i] == context.scoring_name and SMODS.is_poker_hand_visible(context.scoring_name) then
                    active = false
					break
                end
            end
			if active then
				table.insert(card.ability.extra.hands,context.scoring_name)
				if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
                	G.GAME.consumeable_buffer = G.GAME.consumeable_buffer + 1
                	return {
                    	extra = {
                    		message = 'Vieni a fumare',
                        	message_card = card,
							func = function()
                        		local _planet = nil
                        		for _, planet_center in pairs(G.P_CENTER_POOLS.Planet) do
                            		if planet_center.config.hand_type == G.GAME.last_hand_played then
                                		_planet = planet_center.key
                            		end
                        		end
                        		if _planet then
                            		SMODS.add_card({ key = _planet })
                        		end
                        		G.GAME.consumeable_buffer = 0
                    		end
                    	},
                	}
            	end
			end
		end
	end
}
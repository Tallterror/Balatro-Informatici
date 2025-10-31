SMODS.optional_features.cardareas.discard = true
SMODS.optional_features.post_trigger = true


SMODS.Atlas{
	key = 'jokers',
	path = 'jokers.png',
	px = 71,
	py = 95
}

--Joker di Carmine
SMODS.Joker{
	key = 'affamato',
	unlocked = true,
	loc_txt = {
		name = 'Jolly Affamato',
		text = {
			'Se la mano scartata',
			'ha solo {C:attention}1 figura{}, crea un',
			'{C:tarot}tarocco{} casuale'
		}
	},
	atlas = 'jokers',
	pos = {x = 0, y = 0},
	rarity = 2,
	cost = 6,

	calculate = function(self, card, context)
		if not context.discard or not context.cardarea == G.play then return end
		if context.other_card:is_face() then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.E_MANAGER:add_event(Event({
                        		func = (function()
                            			SMODS.add_card {
                                			set = 'Tarot',
                                			key_append = 'joker_affamato' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                            				}
                            			G.GAME.consumeable_buffer = 0
                            			return true
                        		end)
                    		}))
				return {
                        		message = 'Vieni a fumà!',
                   	 	}
			end
		end
	end
}
--Joker di Ilaria
SMODS.Joker{
	key = 'quadis',
	unlocked = true,
	config = { extra = {oddL = 2, oddD = 4, active = true } },
	loc_vars = function(self, info_queue, card)
		info_queue[#info_queue + 1] = G.P_CENTERS['c_lovers']
		info_queue[#info_queue + 1] = G.P_CENTERS['c_death']
		return{
			vars = {
  			(G.GAME.probabilities.normal or 1),
  			card.ability.extra.oddL,
			card.ability.extra.oddD,
			card.ability.extra.active
			}
		}
	end,
	loc_txt = {
		name = 'Quaderno da disegno',
		text = {
			'Se la mano giocata è',
			'una {C:attention}coppia{} di {C:attention}figure{},',
			'{C:green}#1# probabilità su #2#{} di creare',
			'una copia di {C:tarot,T:lovers}Gli amanti{},',
			'{C:green}#1# probabilità su #3#{} di creare',
			'una copia di {C:tarot,T:death}La morte{}',
			'{C:inactive}(Serve spazio){}'
		}
	},
	atlas = 'jokers',
	pos = {x = 0, y = 1},
	rarity = 2,
	cost = 6,

	calculate = function(self, card, context)
		if not context.before or not next(context.poker_hands['Pair']) then return end
		if context.individual and context.cardarea == G.play and not context.end_of_round then
			if not context.other_card:is_face() then
				card.ability.extra.active = false
				return {message = 'nope!',}
			end
		end
		if not context.final_scoring_step then return end
		--if not context.cardarea == G.play then card.ability.extra.active = true return {message = 'nope!',} end
		if not active then card.ability.extra.active = true return {message = 'nope attivo!',} end
		if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
			active = false
            		if SMODS.pseudorandom_probability(card, 'quadis', G.GAME.probabilities.normal, card.ability.extra.oddL) then
				card.ability.extra.active = true
				G.E_MANAGER:add_event(Event({
                        		func = (function()
						SMODS.add_card {
							set = 'Tarot',
							key = 'c_lovers',
                                			key_append = 'quadis'
							}
                            			return true
                        		end)
                    		}))
				G.GAME.consumeable_buffer = 0
			end
		end
		if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
            		if SMODS.pseudorandom_probability(card, 'quadis', G.GAME.probabilities.normal, card.ability.extra.oddD) then
				card.ability.extra.active = true
				G.E_MANAGER:add_event(Event({
                        		func = (function()
                            			SMODS.add_card {
							set = 'Tarot',
							key = 'c_death',
                                			key_append = 'quadis'
                            				}
						return true
                        		end)
                    		}))
				G.GAME.consumeable_buffer = 0
			end
		end
		if card.ability.extra.active then
			return {message = 'Finito!'}
		else
			card.ability.extra.active = true
			return {message = 'nope!',}
			end
		
	end
}
--Pinder Kingui
SMODS.Joker{
	key = 'Pinder',
	unlocked = true,

	config = { extra = {xmult = 1.5, mult = 25, less = 5}},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
			card.ability.extra.xmult,
			card.ability.extra.mult,
			card.ability.extra.less	
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
				mult = card.ability.extra.mult,
				xmult = card.ability.extra.xmult,
			}
		end
		if context.end_of_round and context.cardarea == G.jokers then
			card.ability.extra.mult = card.ability.extra.mult - card.ability.extra.less
			if card.ability.extra.mult <= 0 then
				SMODS.destroy_cards(card)
				return {message = 'Gulp!',}
			else
				return {message = '-5 molt',}
			end
		end
	end
}

--Joker Tranquillo
SMODS.Joker{
	key = 'Tranquillo',
	unlocked = true,
	loc_txt = {
		name = 'Jolly Tranquillo',
		text = {
			'Crea il {C:planet}pianeta{} dell ultima',
			'mano giocata se questa non è',
			'ancora stata giocata'
		}
	},
	atlas = 'jokers',
	pos = {x = 1, y = 1},
	rarity = 1,
	cost = 4,
	calculate = function(self, card, context)
		if context.before then
			local play_more_than = (G.GAME.hands[context.scoring_name].played or 0)
			for handname, values in pairs(G.GAME.hands) do
                		if handname == context.scoring_name and values.played < play_more_than and SMODS.is_poker_hand_visible(handname) then
                    			return
                		end
            		end
		end
		if context.post_joker then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.E_MANAGER:add_event(Event({
					delay = 0.0,
					func = function()
						if G.GAME.last_hand_played then
							local _planet = nil
							for k, v in pairs(G.P_CENTER_POOLS.Planet) do
								if v.config.hand_type == G.GAME.last_hand_played then
									_planet = v.key
								end
							end
							if _planet then
								SMODS.add_card({ key = _planet })
							end
							G.GAME.consumeable_buffer = 0
						end
						return true
					end
				}))
			end
		end
	end
}
--Joker di Guglielmo
SMODS.Joker{
	key = 'Guglielmo',
	unlocked = true,

	config = { extra = {xmult = 1.2}},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
			card.ability.extra.xmult,
			}
		}
	end,

	loc_txt = {
		name = 'Guglielmo',
		text = {
			'{X:mult,C:white}X#1#{} molt per ogni',
			'attivazione di un jolly'
		}
	},
	atlas = 'jokers',
	pos = {x = 2, y = 0},
	soul_pos = {x = 2, y = 1},
	rarity = 4,
	cost = 10,

    	calculate = function(self, card, context)
 		if context.post_trigger then
			--G.E_MANAGER:add_event(Event({
				--delay = 0.0,
				--func = function()
					return {
                				xmult = card.ability.extra.xmult,
					}
				--end
			--}))
        	end
    	end
}
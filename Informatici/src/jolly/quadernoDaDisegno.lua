--Joker di Ilaria
SMODS.Joker{
	key = 'quadis',
	unlocked = true,
	discovered = true;
	config = { extra = {oddL = 2, oddD = 4} },
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
		if not context.before then 
			return
		end
		if not next(context.poker_hands['Pair']) then return end
		if not context.scoring_hand then return end
		for i = 1, #context.scoring_hand do
			if not context.scoring_hand[i]:is_face() then
				return
			end
		end
		if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
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
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer -1
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
				G.GAME.consumeable_buffer = G.GAME.consumeable_buffer -1
			end
		end
	end
}
--Joker Tranquillo
SMODS.Joker{
	key = 'tranquillo',
	unlocked = true,
	discovered = true;
	config = { extra = {active = true, final = nil}},
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
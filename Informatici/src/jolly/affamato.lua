--Joker di Carmine
SMODS.Joker{
	key = 'affamato',
	unlocked = true,
	discovered = true;
	config = {active = true},
	loc_txt = {
		name = 'Jolly Affamato',
		text = {
			'Se la mano scartata',
			'è solo {C:attention}una figura{}, crea un',
			'{C:tarot}tarocco{} casuale',
		}
	},
	atlas = 'jokers',
	pos = {x = 0, y = 0},
	rarity = 2,
	cost = 6,

	calculate = function(self, card, context)
		if context.after and not card.ability.active then
			card.ability.active = true
		end
		if #SMODS.last_hand.scoring_hand > 1 then
			card.ability.active = false
		end
		if not context.discard or not context.cardarea == G.play or not card.ability.active then return end
		if context.other_card:is_face() and #SMODS.last_hand.scoring_hand <= 1 then
			if #G.consumeables.cards + G.GAME.consumeable_buffer < G.consumeables.config.card_limit then
				G.E_MANAGER:add_event(Event({
                    func = (function()
                        SMODS.add_card {
                            set = 'Tarot',
                            key_append = 'joker_affamato' -- Optional, useful for manipulating the random seed and checking the source of the creation in `in_pool`.
                        }
                        return true
                    end)
                }))
				return { message = 'Vieni a fumà!', }
			end
		end
	end
}
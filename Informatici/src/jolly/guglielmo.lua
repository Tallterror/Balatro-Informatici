--Joker di Guglielmo
SMODS.Joker{
	key = 'guglielmo',
	unlocked = true,
	discovered = true;
	config = { extra = {xmult = 1.5}},
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
 		if context.post_trigger and not context.end_of_round then
			return {
                xmult = card.ability.extra.xmult,
			}
        end
    end
}
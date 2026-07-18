--Joker di Salemme
SMODS.Joker{
	key = 'gnomo',
	unlocked = true,
	discovered = true;
	config = { extra = {xmult = 1, xmult_gain = 1}},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.xmult_gain
			}
		}
	end,

	loc_txt = {
		name = 'Gnomo armato di ascia',
		text = {
			'Questo Jolly guadagna {C:white,X:mult}X#2#{} Molt',
			'ogni volta che una {C:attention}carta',
			'{C:attention}di pietra{} viene giocata',
			'{s:0.8}La carta viene distrutta',
			'{C:inactive}(Attualmente {C:white,X:mult}X#1#{C:inactive} Molt)'
		}
	},
	atlas = 'jokers',
	pos = {x = 0, y = 2},
	soul_pos = {x = 0, y = 3},
	rarity = 4,
	cost = 10,

    calculate = function(self, card, context)
		if context.before and not context.blueprint then
		    for _,other_card in pairs(G.play.cards) do
				if SMODS.has_enhancement(other_card, 'm_stone') then
					card.ability.extra.xmult = card.ability.extra.xmult + card.ability.extra.xmult_gain
				end
			end
		end
		if context.destroy_card and context.destroying_card and context.cardarea == G.play and not context.blueprint then
			if SMODS.has_enhancement(context.destroy_card, 'm_stone') then
				return {remove =true}
			end
		end
		if context.joker_main then
			return {xmult = card.ability.extra.xmult}
		end
    end,

	joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition		
		return {
			text = {
				{
					border_nodes = {
						{text = 'X'},
						{ ref_table = "card.ability.extra", ref_value = "xmult" }
					}
				}
			}
		}
	end
}
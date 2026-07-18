--Joker di Gianrico

local function reset_malato_card()
    G.GAME.current_round.malato = { rank = 'Ace', suit = 'Spades'}
    local valid_cards = {}
    for _, playing_card in ipairs(G.playing_cards) do
        if not SMODS.has_no_suit(playing_card) and not SMODS.has_no_rank(playing_card) then
            valid_cards[#valid_cards + 1] = playing_card
        end
    end
    local card = pseudorandom_element(valid_cards, 'ammalato' .. G.GAME.round_resets.ante)
    if card then
        G.GAME.current_round.malato.rank = card.base.value
        G.GAME.current_round.malato.suit = card.base.suit
        G.GAME.current_round.malato.id = card.base.id
    end
end

function SMODS.current_mod.reset_game_globals(run_start)
    reset_malato_card()
end

SMODS.Joker{
	key = 'malato',
	unlocked = true,
	discovered = true;
	config = { extra = {xmult = 1, xmult_gain = 0.5}},
	loc_vars = function(self, info_queue, card)
		local debuff_card =  G.GAME.current_round.malato or { rank = 'Ace', suit = 'Spades' }
		return {
			vars = {
				card.ability.extra.xmult,
				card.ability.extra.xmult_gain,
				localize(debuff_card.rank, 'ranks'),
				localize(debuff_card.suit, 'suits_plural'),
				colours = { G.C.SUITS[debuff_card.suit]}
			}
		}
	end,

	loc_txt = {
		name = 'Malato',
		text = {
			'Ogni {C:attention}#3#',
			'di {V:1}#4#{} è penalizzato',
			'Questo Jolly guadagna {C:white,X:mult}X#2#{} Molt',
			'se la mano giocata ha solo',
			'{C:attention}1 carta penalizzata',
			'{s:0.8}La carta è diversa in ogni round',
			'{C:inactive}(Attualmente {C:white,X:mult}X#1#{C:inactive} Molt)'
		}
	},
	atlas = 'jokers',
	pos = {x = 1, y = 2},
	soul_pos = {x = 1, y = 3},
	rarity = 4,

    calculate = function(self, card, context)
		if context.joker_main then
			return {xmult = card.ability.extra.xmult}
		end

		if context.debuff_card and SMODS.is_playing_card(context.debuff_card) and
        	context.debuff_card:get_id() == G.GAME.current_round.malato.id and context.debuff_card:is_suit(G.GAME.current_round.malato.suit) then
        	return {
               	debuff = true
            }
		end
		if context.before and #context.full_hand == 1 and context.full_hand[1].debuff and not context.blueprint then
			card.ability.extra.xmult = card.ability.extra.xmult  + card.ability.extra.xmult_gain
			return {message = 'Miglioramento!'}
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
			},
			reminder_text = {
				{ text = '('},
        		{ ref_table = "G.GAME.current_round.malato", ref_value = "rank", color = G.C.SUITS['G.GAME.current_round.malato.suit']},
				{ text = ' di ', color = 'card.joker_display_values.color'},
				{ ref_table = "G.GAME.current_round.malato", ref_value = "suit", color = G.C.SUITS['G.GAME.current_round.malato.suit']},
				{ text = ')'}
    		}
		}
	end
}
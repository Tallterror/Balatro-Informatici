--Joker di TaSupreme
SMODS.Joker{
	key = 'biliardino',
	unlocked = true,
	discovered = true;
	config = { extra = {chance = 0, spentMoney = 0, reminder = 0, final = { neededMoney = 2, addChance = 1, odd = 100}}},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.extra.chance * G.GAME.probabilities.normal,
				card.ability.extra.final.odd,
				card.ability.extra.final.addChance,
				card.ability.extra.final.neededMoney,
			}
		}
	end,

	loc_txt = {
		name = 'Biliardino',
		text = {
			'{C:green}#1# probabilità su #2#{} di',
			'aggiungere un edizione a',
			'una carda giocata,',
			'la possibilità aumenta di {C:attention}#3#{}',
			'per ogni {C:gold}$#4#{} spesi,',
			'{C:inactive}si resetta a ogni ante{}',
		}
	},
	atlas = 'jokers',
	pos = {x = 3, y = 0},
	rarity = 3,
	cost = 6,
    calculate = function(self, card, context)

		if context.setting_ability then
			card.ability.extra.reminder = card.ability.extra.final.neededMoney
			card.ability.extra.spentMoney = 0
			card.ability.extra.chance = 0
		end

		if context.modify_ante and context.ante_end then
			card.ability.extra.chance = 0
			card.ability.extra.spentMoney = 0
		end

 		if context.before then
			for _, carta in ipairs(context.scoring_hand) do
				if SMODS.pseudorandom_probability(card, 'biliardino', card.ability.extra.chance * G.GAME.probabilities.normal, card.ability.extra.final.odd) then
					if not carta.edition and not carta.debuff then
						G.E_MANAGER:add_event(Event({
							delay = 0.1,
							func = function()
                				local edition = poll_edition('biliardino', nil, true, true,
                    			{ 'e_polychrome', 'e_holo', 'e_foil' })
                				carta:set_edition(edition, true) 
                				carta:juice_up(0.3, 0.5)
								return true
							end,
						}))
					end
				end
			end
		end
		if context.money_altered  and context.amount < 0 then
			G.E_MANAGER:add_event(Event({
				delay = 0.1,
				func = function()
					local money = context.amount * -1
					card.ability.extra.spentMoney = card.ability.extra.spentMoney + context.amount
					if money < card.ability.extra.reminder then
						card.ability.extra.reminder = card.ability.extra.reminder - money
						return false
					end
					card.ability.extra.chance = card.ability.extra.chance + 1
					money = money - card.ability.reminder
					card.ability.extra.reminder = card.ability.extra.final.neededMoney - (money % card.ability.extra.final.neededMoney)
					card.ability.extra.chance = card.ability.extra.chance + card.ability.extra.final.addChance * round_number((money / card.ability.extra.final.neededMoney),0)
					card:juice_up(0.3, 0.5)
					return true
				end,
			}))
			
		end
    end,

	joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
		return {
			text = {
                { ref_table = "card.ability.extra", ref_value = "chance", color = G.C.green },
				{ text = "/" },
				{ ref_table = "card.ability.extra.final", ref_value = "odd", color = G.C.GREEN },
			},
			reminder_text = {
        		{ text = "(" },
				{ text = "$", colour = G.C.GOLD },
        		{ ref_table = "card.ability.extra", ref_value = "spentMoney", color = G.C.GOLD },
        		{ text = ")" },
    		}
		}
	end
}
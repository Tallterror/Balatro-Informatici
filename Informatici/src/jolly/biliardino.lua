--Joker di TaSupreme
SMODS.Joker{
	key = 'biliardino',
	unlocked = true,
	discovered = true;
	config = { chance = 0, spentMoney = 0, reminder = 0, final = { neededMoney = 2, addChance = 1, odd = 100}},
	loc_vars = function(self, info_queue, card)
		return {
			vars = {
				card.ability.chance * G.GAME.probabilities.normal,
				card.ability.final.odd,
				card.ability.final.addChance,
				card.ability.final.neededMoney,
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
			card.ability.reminder = card.ability.final.neededMoney
			card.ability.spentMoney = 0
			card.ability.chance = 0
		end

		if context.modify_ante and context.ante_end then
			card.ability.chance = 0
			card.ability.spentMoney = 0
		end

 		if context.before then
			for _, carta in ipairs(context.scoring_hand) do
				if SMODS.pseudorandom_probability(card, 'biliardino', card.ability.chance * G.GAME.probabilities.normal, card.ability.final.odd) then
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
					card.ability.spentMoney = card.ability.spentMoney + context.amount
					if money < card.ability.reminder then
						card.ability.reminder = card.ability.reminder - money
						return false
					end
					card.ability.chance = card.ability.chance + 1
					money = money - card.ability.reminder
					card.ability.reminder = card.ability.final.neededMoney - (money % card.ability.final.neededMoney)
					card.ability.chance = card.ability.chance + card.ability.final.addChance * round_number((money / card.ability.final.neededMoney),0)
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
                { ref_table = "card.ability", ref_value = "chance", color = G.C.green },
				{ text = "/" },
				{ ref_table = "card.ability.final", ref_value = "odd", color = G.C.GREEN },
			},
			reminder_text = {
        		{ text = "(" },
				{ text = "$", colour = G.C.GOLD },
        		{ ref_table = "card.ability", ref_value = "spentMoney", color = G.C.GOLD },
        		{ text = ")" },
    		}
		}
	end
}
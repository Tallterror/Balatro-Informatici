informatica.jollyGlitch = {}
informatica.jollyGlitch.functions = {}
informatica.areas = {}
SMODS.current_mod.custom_card_areas = function(game)
	game.glitchArea = CardArea(
    	-1,
        -1,
       	-1,
        -1,
    	{
        card_limit = 9999999,
        highlight_limit = 1
    	}
	)
	informatica.areas.glitchArea = game.glitchArea
end
informatica.jollyGlitch.functions.enhancement = function(card,carta,ability)
	if card == nil or carta == nil then return end
	local enhancement = SMODS.poll_enhancement('errorenhancement', nil, true, true)
    carta:set_edition(seal, true) 
    carta:juice_up(0.3, 0.5)
end
informatica.jollyGlitch.functions.seal = function(card,carta,ability)
	if card == nil or carta == nil then return end
	local seal = SMODS.poll_edition('errorseal', nil, true, true)
    carta:set_edition(seal, true) 
    carta:juice_up(0.3, 0.5)
end
informatica.jollyGlitch.functions.edition = function(card,carta,ability) 
	if card == nil or carta == nil then return end
	local edition = SMODS.poll_edition('erroredition', nil, true, true)
    carta:set_edition(edition, true) 
    carta:juice_up(0.3, 0.5)
end
informatica.jollyGlitch.functions.delete = function(card,carta,ability)
	if carta == nil then return end
	SMODS.destroy_cards(carta, ability.value)
end
informatica.jollyGlitch.functions.debuff = function(card,carta,ability) 
	if card == nil or carta == nil then return end
	SMODS.debuff_card(carta, ability.value, "error")
end
informatica.jollyGlitch.functions.draw = function(card,carta,ability)
	if card == nil then return end
	SMODS.draw_cards(ability.value)
end
informatica.jollyGlitch.functions.levelup = function(card,carta,ability)
	if card == nil then return end
	SMODS.upgrade_poker_hands(G.GAME.last_hand_played,ability.value)
end

informatica.jollyGlitch.functions.setFunction = function(card)
	if not (pseudorandom('errorFunction1', 1, 3) == 3) then return nil end
	if pseudorandom('errorFunction2', 1, 3) == 3 then
		return "enhancement"
	end
	if pseudorandom('errorFunction3', 1, 3) == 3 then
		if pseudorandom('errorFunction3', 1, 2) == 2 then
			card.ability.var.chance = true
		else
			card.ability.var.chance = false
		end
		return "delete"
	end
	if pseudorandom('errorFunction4', 1, 3) == 3 then
		return "draw"
	end
	if pseudorandom('errorFunction5', 1, 3) == 3 then
		return "seal"
	end
	if pseudorandom('errorFunction6', 1, 3) == 3 then
		card.ability.var.chance = pseudorandom('errorhandup',0,5)
		card.ability.var.value = pseudorandom('errorhandup',-1,1)
		return "levelup"
	end
	if pseudorandom('errorFunction7', 1, 3) == 3 then
		if pseudorandom('errorFunction7', 1, 2) == 2 then
			card.ability.var.chance = true
		else
			card.ability.var.chance = false
		end
		return "debuff"
	end
	if pseudorandom('errorFunction8', 1, 3) == 3 then
		return "edition"
	end
	return nil
end

informatica.jollyGlitch.contexts = {
	"joker_main",
	"before",
	"initial_scoring_step",
	"main_scoring",
	"individual",
	"individual",
	"individual",
	"repetition",
	"pre_joker",
	"post_joker",
	"after",
	"destroy_card",
	"remove_playing_cards",
	"debuffed_hand",
	"end_of_round",
	"setting_blind",
	"playing_card_end_of_round",
	"drawing_cards",
	"hand_drawn",
	"pre_discard",
	"discard",
	"press_play",
	"modify_scoring_hand",
	"debuff_hand",
	"debuff_card",
	"stay_flipped",
	"blind_disabled",
	"blind_defeated",
	"ante_change",
	"starting_shop",
	"ending_shop",
	"open_booster",
	"skipping_booster",
	"buying_card",
	"selling_self",
	"using_consumeable",
	"reroll_shop",
	"skip_blind",
	"card_added"
}
informatica.jollyGlitch.functions.setRandomContext = function()
	return informatica.jollyGlitch.contexts[pseudorandom('errorSetContext', 1, #informatica.jollyGlitch.contexts)]
end
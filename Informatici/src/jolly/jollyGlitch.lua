assert(SMODS.load_file("src/jolly/jollyGlitchAbilities.lua"))()
SMODS.Joker{
	key = "jollyGlitch",
	no_collection = true,
	pools = {["Joker"] = false},
	config = {
		sprite = {minx = 1.00, maxx = 9.00, miny = 1.00, maxy = 15.00},
		jokersFuncs = {},
		name = 'Error',
		text = 'I am error',
		context = nil,
		func = nil,
		var = {value = nil, chance = 0}
	},
	loc_txt = {
		name = '#1#',
		text = {'#2#'}
	},
	loc_var = function(self, info_queue, card)
		return {
			vars = {
				card.ability.name,
				card.ability.text
			}
		}
	end,

	rarity = 1,
	cost = 0,
	atlas = 'vanilla',
	pos = {x = 1, y = 1},

	set_ability = function(self, card, initial, delay_sprites)
		card.children.center:set_sprite_pos({x = pseudorandom('error1', card.ability.sprite.minx, card.ability.sprite.maxx), y = pseudorandom('error2', card.ability.sprite.miny, card.ability.sprite.maxy)})
		if pseudorandom('errorCost1', 0, 99) > 30 then
			card.cost = pseudorandom('errorCost2', 1, 99)
		else
			card.cost =	pseudorandom('errorCost1', 1, 30)
		end
		--card.rarity = pseudorandom('errorrarity', 1, 4)
		card.ability.func = informatica.jollyGlitch.functions.setFunction(card)
		card.ability.context = informatica.jollyGlitch.functions.setRandomContext()

		local i = 1
		repeat
			local joker = SMODS.add_card{
            	set = "Joker",
				area = informatica.areas.glitchArea,
				allow_duplicates = true,
				no_edition = true,
        	}
			print(joker.ability)
			if joker.calculate then
				card.ability.jokersFuncs[i] = joker.calculate
			end
			SMODS.destroy_cards(joker, true, true, true)
			i = i+1
		until not (pseudorandom('errorCostTry', 1, 3) == 3)
	end,
	
	calculate = function(self, card, context)
		if card.ability.func and context[card.ability.context] then
			if pseudorandom('chanceFunc', 0, card.ability.var.chance) == 0 then
				informatica.jollyGlitch.functions[card.ability.func](self,card,card.ability.var)
			end
		end

		if #card.ability.jokersFuncs <= 0 then return end
		for _,joker_func in pairs(card.ability.jokersFuncs) do
			local joker_ret = joker_func(self, card, context)
    		if joker_ret then
        		return other_joker_ret
    		end
		end
	end
}
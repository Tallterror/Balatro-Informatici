SMODS.Joker{
    discovered = true,
	key = 'nintendods',
	atlas = 'jokers',
	pos = {x = 6, y = 0},
	rarity = 1,
	cost = 4,
    config = {chips = 70, mult = 10, option = 0, display = 0},
    loc_vars = function(self, info_queue, card)
		return {
			vars = {
                card.ability.chips,
                card.ability.mult,
			}
		}
	end,

	loc_txt = {
		name = 'Nintendo DS',
		text = {
			'ogni altra mano alterna',
			'{C:chips}+#1#{} chips',
			'e {C:mult}+#2#{} molt'
		}
	},

    calculate = function(self, card, context)
        if context.joker_main then
            if card.ability.option == 0 then
                return {chips = card.ability.chips}
            end
            return {mult = card.ability.mult}
        end

        if context.post_joker then
            G.E_MANAGER:add_event(Event{
                trigger = "after",
				delay = 1,
				func = function()
                    card.ability.option = 1 - card.ability.option
                    if card.ability.option == 0 then
                        card.children.center:set_sprite_pos({x = 6,y = 0})
                    else
                        card.children.center:set_sprite_pos({x = 6,y = 1})
                    end
                    return true
				end
			})
        end
    end,

    joker_display_def = function(JokerDisplay)
        ---@type JDJokerDefinition
		return {
            text = {
                {text = "+"},
                {ref_table = "card.ability", ref_value = "display"}
            },

            style_function = function(card, text, reminder_text, extra)
                if text and text.children[1] then
                    if card.ability.option == 0 then
                        card.ability.display = card.ability.chips
                        text.children[1].config.colour = G.C.CHIPS
                        text.children[2].config.colour = G.C.CHIPS
                    else
                        card.ability.display = card.ability.mult
                        text.children[1].config.colour = G.C.MULT
                        text.children[2].config.colour = G.C.MULT
                    end
                end
                return false
            end
		}
	end
}
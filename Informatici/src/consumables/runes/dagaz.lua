SMODS.Consumable{
    key = 'dagaz',
    set = 'Rune',
    atlas = 'runes',
    pos = {x=0 , y=1},
    unlocked = true,
    discovered = true,
    cost = 4,

    loc_txt = {
        name = 'Dagaz',
        text = {
            'Seleziona {C:attention}#1# carta da gioco{} o {C:attention}#1# {C:joker,E:2}jolly',
            'Rimuove tutti i potenziamenti,',
            'edizioni, sigilli e adesivi',
            'Reimposta tutti valori'
        }
    },
    config = {max_highlighted = 1},
    loc_vars = function(self, info_queue, card)
        return {vars ={card.ability.max_highlighted}}
    end,
    use = function(self, card, area, copier)
        local carta
        local copy
        if G.jokers and #G.jokers.highlighted > 0 then 
            carta = G.jokers.highlighted[1]
        else
            carta = G.hand.highlighted[1]
        end
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                carta:flip()
                play_sound('card1')
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                if G.jokers and #G.jokers.highlighted > 0 then 
                    carta:set_ability(carta.config.center.key)
                else
                    carta:set_ability("c_base")
                end
                carta:set_edition(nil, true, true, true)
                if carta.ability.eternal then carta.ability.eternal = nil end
                if carta.ability.rental then carta.ability.rental = nil end
                if carta.ability.perishable then carta.ability.perishable = nil end
                play_sound('tarot1')
                carta:juice_up(0.3, 0.5)
                return true
            end
        }))
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                carta:flip()
                play_sound('card1')
                return true
            end
        }))
    end,
    can_use = function(self, card)
        if G.hand and #G.hand.highlighted > 0 and #G.hand.highlighted <= card.ability.max_highlighted then
            if (G.jokers and #G.jokers.highlighted == 0) or not G.jokers then return true end
        elseif G.jokers and #G.jokers.highlighted > 0 and #G.jokers.highlighted <= card.ability.max_highlighted then
            if (G.hand and #G.hand.highlighted == 0) or not G.hand then return true end 
        end
        return false
    end
}
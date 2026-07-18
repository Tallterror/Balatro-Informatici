SMODS.Consumable{
    key = 'elhaz',
    set = 'Rune',
    atlas = 'runes',
    pos = {x=2 , y=0},
    unlocked = true,
    discovered = true,
    cost = 5,

    loc_txt = {
        name = 'Elhaz',
        text = {
            'Seleziona un {C:joker,E:2}jolly{} o una {C:attention}carta da gioco',
            "Aggiunge l'adesivo {C:attention}eterno"
        }
    },
    config = {max_highlighted = 1},
    use = function(self, card, area, copier)
        local carta
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
                carta:add_sticker('eternal',true)
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
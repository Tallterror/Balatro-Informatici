SMODS.Consumable{
    key = 'ansuz',
    set = 'Rune',
    atlas = 'runes',
    pos = {x=1 , y=0},
    unlocked = true,
    discovered = true,
    cost = 5,

    loc_txt = {
        name = 'Ansuz',
        text = {
            'aggiunge {C:money}$#1#{} al valore di',
            'vendità dei {E:2}jolly{} posseduti'
        }
    },

    config = {extra = {sellValue = 8}},
    loc_vars = function(self, info_queue, card)
        return {vars = {card.ability.extra.sellValue}}
    end,
    use = function(self, card, area, copier)
        delay(0.5)
        for _,joker in pairs(G.jokers.cards) do
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = function()
                    if not joker.set_cost then return true end
                    joker.sell_cost = joker.sell_cost + card.ability.extra.sellValue
                    joker:set_cost_value()
                    play_sound('tarot1')
                    joker:juice_up(0.3, 0.5)
                    card:juice_up(0.3, 0.5)
                    return true
                end
            }))
        end
        delay(0.5)
    end,
    can_use = function(self, card)
        if G.jokers and #G.jokers.cards > 0 then
            return true
        end
        return false
    end
}
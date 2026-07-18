SMODS.Consumable{
    key = 'yera',
    set = 'Rune',
    atlas = 'runes',
    pos = {x=4 , y=0},
    unlocked = true,
    discovered = true,
    cost = 4,

    loc_txt = {
        name = 'Yera',
        text = {
            'Duplica i primi {C:attention}#1#{} patti',
            'Se non si possiedono',
            'patti, crea un',
            'patto doppio'
        }
    },
    config = {extra = 5},
    loc_vars = function(self, info_queue, card)
        return {vars ={card.ability.extra}}
    end,
    use = function(self, card, area, copier)
        if G.GAME.tags and #G.GAME.tags > 0 then
        for i,tag in ipairs(G.GAME.tags) do
            if i>card.ability.extra then return end
            G.E_MANAGER:add_event(Event({
                trigger = 'after',
                delay = 0.4,
                func = (function()
                    add_tag({ key = tag.key })
                    play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
                    card:juice_up(0.3, 0.5)
                    tag:juice_up(0.3, 0.5)
                    return true
                end)
            }))
        end
        else
            play_sound('holo1', 1.2 + math.random() * 0.1, 0.4)
            add_tag({ key = 'tag_double' })
        end
    end,

    can_use = function(self, card)
        return true
    end,

    in_pool = function(self, args)
        return true
    end
}
SMODS.Consumable{
    key = 'hagalaz',
    set = 'Rune',
    atlas = 'runes',
    pos = {x=3 , y=0},
    unlocked = true,
    discovered = true,
    cost = 4,

    loc_txt = {
        name = 'Hagalaz',
        text = {
            '{C:red,E:2}Distruggi{} tutte le',
            'carte in mano'
        }
    },
    use = function(self, card, area, copier)
        G.E_MANAGER:add_event(Event({
            trigger = 'after',
            delay = 0.4,
            func = function()
                play_sound('tarot1')
                card:juice_up(0.3, 0.5)
                return true
            end
        }))
        for _,carta in pairs(G.hand.cards) do
            SMODS.destroy_cards(carta)
        end
        
    end,
    can_use = function(self, card)
        return G.hand and #G.hand.cards > 0
    end
}
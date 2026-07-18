SMODS.Consumable{
    key = 'fehu',
    set = 'Rune',
    atlas = 'runes',
    pos = {x=0 , y=0},
    unlocked = true,
    discovered = true,
    cost = 4,

    loc_txt = {
        name = 'Fehu',
        text = {
            'Da {C:gold}$1{} per ogni:',
            '{E:2}Joker{} posseduto;',
            '{C:tarot}Consumabile{} posseduto;',
            '{C:gold}10 carte{} nel mazzo;',
            '{C:enhanced}5 edizioni{}, {C:enhanced}sigilli',
            '{}o {C:enhanced}potenziamenti{} posseduti.',
            '{C:inactive}(attualmente {C:money}$#1#{})'
        }
    },

    config = {extra = {money = 0}},

    loc_vars = function(self, info_queue, card)
        local money = 0
        if G.jokers then
            money = money + #G.jokers.cards
        end
        if G.consumable then
            money = money + #G.consumable.cards
        end
        local totExtras = 0
        local totCards = 0
        if G.hand then
            totCards = #G.hand.cards
            for _,carta in pairs(G.hand.cards) do
                if next(SMODS.get_enhancements(carta)) then
                    totExtras = totExtras + 1
                end
                if carta.edition then
                    totExtras = totExtras + 1
                end
                if carta.seal then
                    totExtras = totExtras + 1
                end
            end
        end
        if G.deck then
           totCards = totCards + #G.deck.cards
           for _,carta in pairs(G.deck.cards) do
                if next(SMODS.get_enhancements(carta)) then
                    totExtras = totExtras + 1
                end
                if carta.edition then
                    totExtras = totExtras + 1
                end
                if carta.seal then
                    totExtras = totExtras + 1
                end
            end
        end
        money = money + math.floor(totCards / 10)
        money = money + math.floor(totExtras / 5)
        card.ability.extra.money = money

        return { vars = {card.ability.extra.money} }
    end,

    use = function(self, card, area, copier)
        delay(0.5)
        ease_dollars(card.ability.extra.money)
    end,
    can_use = function(self, card)
        return true
    end
}
SMODS.Joker:take_ownership('j_trading',{
    calculate = function(self, card, context)
        if context.first_hand_drawn then
            local eval = function() return G.GAME.current_round.discards_used == 0 and not G.RESET_JIGGLES end
            juice_card_until(card, eval, true)
        end
        if context.discard and not context.blueprint and G.GAME.current_round.discards_used <= 0 and #context.full_hand == 1 then
            if context.full_hand[1].ability.eternal then 
                return {
                    remove = false,
                    delay = 0.45
                }
            else
                return{
                    dollars = card.ability.extra,
                    remove = true,
                    delay = 0.45
                }
            end
        end
    end
})
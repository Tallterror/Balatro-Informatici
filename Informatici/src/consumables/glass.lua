SMODS.Enhancement:take_ownership('m_glass',{
calculate = function(self, card, context)
    if context.destroy_card and context.cardarea == G.play and context.destroy_card == card and not card.ability.eternal and
        SMODS.pseudorandom_probability(card, 'vremade_glass', 1, card.ability.extra) then
        card.glass_trigger = true -- SMODS addition
        return { remove = true }
    end
end
})
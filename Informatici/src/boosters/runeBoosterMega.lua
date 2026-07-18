SMODS.Booster{
    key = 'rune_mega',
    group_key = 'runePack',
    cost = 8,
    weight = 0.4,
    draw_hand = true,
    config = { extra = 4, choose = 2 },
    discovered = true,
    atlas = 'boosters',
    pos = { x = 3, y = 0 },
    loc_txt = {
        name = 'Busta runica mega',
        group_name = 'Busta runica',
        text = {'Scegli {C:attention}#2#{} tra massimo',
        '{C:attention}#1#{} carte {V:1}Runa{} da',
        'usare immediatamente'
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {
            card.ability.extra,
            card.ability.choose,
            colours = {informatica.colours.rune}
        }}
    end,

    create_card = function(self, card, i)
        return {set = "Rune", area = G.pack_cards, skip_materialize = true, soulable = true, key_append = "runePack",}
    end,
    ease_background_colour = function(self)
        ease_background_colour_blind(informatica.colours.runebooster)
    end
}
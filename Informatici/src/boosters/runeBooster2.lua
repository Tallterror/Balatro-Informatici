SMODS.Booster{
    key = 'rune_normal_2',
    group_key = 'runePack',
    cost = 4,
    weight = 0.5,
    draw_hand = true,
    config = { extra = 2, choose = 1 },
    discovered = true,
    atlas = 'boosters',
    pos = { x = 1, y = 0 },
    loc_txt = {
        name = 'Busta runica',
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
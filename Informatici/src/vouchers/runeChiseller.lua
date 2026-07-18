SMODS.Voucher{
    key = 'runeChiseller',
    loc_txt = {
        name = 'Bulinatore di Rune',
        text = {
            'Le carte {V:1}Runa{} possono',
            'apparire in qualsiasi',
            '{C:attention}busta arcana'
        }
    },
    loc_vars = function(self, info_queue, card)
        return {vars = {colours = {informatica.colours.rune}}}
    end,
    unlocked = true,
    discovered = true,
    requires = { 'runeMerchant' },
    atlas = 'vouchers',
    pos = { x = 0, y = 1 },

    calculate = function(self, card, context)
        if context.create_booster_card and context.booster.config.center.kind == "Arcana" then
            if pseudorandom('runeChiseller') > 0.8 then
                return {
                    booster_create_flags = {
                        set = "Rune",
                        area = G.pack_cards,
                        skip_materialize = true,
                        key_append = "runeChiseller2"
                    }
                }
            end
        end
    end,
}
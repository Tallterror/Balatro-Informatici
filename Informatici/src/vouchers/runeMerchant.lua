SMODS.Voucher{
    key = 'runeMechant',
    loc_txt = {
        name = 'Mercante di Rune',
        text = {
            'Le carte {V:1}Runa{} possono',
            'apparire nel negozio'
        }
    },
    atlas = 'vouchers',
    pos = { x = 0, y = 0 },
    unlocked = true,
    discovered = true,
    loc_vars = function(self, info_queue, card)
        return {vars = {colours = {informatica.colours.rune}}}
    end,
    redeem = function(self, card)
        G.GAME.rune_rate = 2
    end
}
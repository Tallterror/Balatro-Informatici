SMODS.Blind{
    key = "lambda",
    loc_txt = {
        name = "Funzione",
        text={
            'Chip e molt sono invertiti'
        }
    },
    atlas = 'blinds',
    pos = {x = 0, y = 2},
    boss_colour = HEX('F05060'),
    discovered = true,
    boss = {min = 2, max = 16},
    calculate = function(self, blind, context)
        if context.before and not blind.disabled then
            return {swap = true}
        end
    end
}
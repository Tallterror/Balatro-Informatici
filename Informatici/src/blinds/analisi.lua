SMODS.Blind{
    key = "analisi",
    loc_txt = {
        name = "Analisi",
        text={
            'Ogni mano giocata aggiungi',
            '25% alle chips richieste.'
        }
    },
    boss_colour = HEX('333333'),
    discovered = true,
    mult = 2,
    boss = {min = 4, max = 16},
    calculate = function(self, blind, context)
        if context.after and context.cardarea == 'Jokers' then
            return {
                xblindsize = 1.25
            }
        end
    end
}
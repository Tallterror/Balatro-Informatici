SMODS.Blind{
    key = "lps",
    loc_txt = {
        name = "Compilatore",
        text={
            'Gioca solo #1#'
        }
    },
    atlas = 'blinds',
    pos = {x = 0, y = 1},
    loc_vars = function(self, info_queue, card)
        return {vars = { localize(G.GAME.current_round.most_played_poker_hand, 'poker_hands') or localize('High card', 'poker_hands')}}
    end,
    collection_loc_vars = function(self)
        return { vars = { localize('ph_most_played') } }
    end,
    boss_colour = HEX('A0A0A0'),
    discovered = true,
    boss = {min = 2, max = 16},
    calculate = function(self, blind, context)
        if blind.disabled then return end
        if context.debuff_hand and 
        not (context.scoring_name == G.GAME.current_round.most_played_poker_hand) then
            return {
                debuff = true
            }
        end
    end
}
SMODS.Atlas{
	key = 'revtar',
	path = 'reversetarots.png',
	px = 71,
	py = 95
}
--reverse matto
SMODS.Consumable{
    key = 'revfool',
    set = 'tarots',
    pos = {x = 0,y = 0},
    loc_txt = {
        name = {
            'Matto?'
        },
        text = {
            'Riporta il numero di mani e',
            'scarti al massimo e imposta,',
            'i punti del round a 0'
        }
    },

    cost = 5,
    discovered = true,
    selected_card = 'consumeables',
    use = function(self, card, area, copier)

    end,
    can_use = function(self, card)
        return G.STATE == 1
    end
}
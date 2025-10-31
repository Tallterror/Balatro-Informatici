SMODS.Challenge {
    	key = 'dnd_1',
    	loc_txt = {
		name = 'dungeons & dragons'	
    	},
    	rules = {
        	custom = {
            		{ id = 'no_shop_jokers' },
	    		{ id = 'no_reward_specific', value = 'Small' },
            		{ id = 'no_reward_specific', value = 'Big' },
        	}
   	},
	jokers = {
        	{ id = 'j_quadis', eternal = true },
    	},
    	vouchers = {
        	{ id = 'v_magic_trick' },
        	{ id = 'v_illusion' },
    	},
    	restrictions = {
    		banned_cards = {
            		{ id = 'p_buffoon_normal_1', ids = {
                		'p_buffoon_normal_1', 'p_buffoon_normal_2', 'p_buffoon_jumbo_1', 'p_buffoon_mega_1',
            		}
            	},
	},
        banned_tags = {
            	{ id = 'tag_uncommon' },
            	{ id = 'tag_rare' },
            	{ id = 'tag_negative' },
            	{ id = 'tag_foil' },
            	{ id = 'tag_holographic' },
            	{ id = 'tag_polychrome' },
            	{ id = 'tag_buffoon' },
            	{ id = 'tag_top_up' },
        },
        banned_other = {
            	{ id = 'bl_final_heart', type = 'blind' },
           	{ id = 'bl_final_leaf',  type = 'blind' },
            	{ id = 'bl_final_acorn', type = 'blind' },
        }
    }
}
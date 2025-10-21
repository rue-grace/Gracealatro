SMODS.Joker{ --Slugfish
    key = "slugfish",
    config = {
        extra = {
            hand_change = 1,
            emult = 4,
            dollars = 5
        }
    },
    loc_txt = {
        ['name'] = 'Slugfish',
        ['text'] = {
            [1] = '{X:legendary,C:white}^4{} Mult, takes up 2 {C:attention}joker slots{} and',
            [2] = '{C:attention}-5${} when effect is triggered'
        },
        ['unlock'] = {
            [1] = 'Unlocked by default.'
        }
    },
    pos = {
        x = 0,
        y = 0
    },
    display_size = {
        w = 71 * 1, 
        h = 95 * 1
    },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_slugfish.png',
    pools = { ["sim_mycustom_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            return {
                e_mult = card.ability.extra.emult,
                extra = {
                dollars = -card.ability.extra.dollars,
                colour = G.C.MONEY
            }
        }
    end
end,

    add_to_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = math.max(1, G.GAME.round_resets.hands - card.ability.extra.hand_change)
    end,

    remove_from_deck = function(self, card, from_debuff)
        G.GAME.round_resets.hands = G.GAME.round_resets.hands + card.ability.extra.hand_change
    end
}
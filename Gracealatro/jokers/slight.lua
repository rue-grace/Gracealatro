SMODS.Joker{ --Slight
    key = "slight",
    config = {
        extra = {
            multvar = 2,
            probabilityvar = 5,
            chipsvar = 10,
            odds = "card.ability.extra.probabilityvar",
            odds2 = 2,
            start_dissolve = 0,
            n = 0
        }
    },
    loc_txt = {
        ['name'] = 'Slight',
        ['text'] = {
            [1] = 'For every card played, {C:blue}+10{} Chips, {C:green}1/#2#{} chance to',
            [2] = 'destroy itself.',
            [3] = '{C:inactive}(Currently{} {C:blue}+#3#{} {C:inactive}Chips){}'
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
    atlas = 'j_slight.png',
    pools = { ["sim_mycustom_jokers"] = true },

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sim_slight')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_sim_slight')
        return {vars = {card.ability.extra.multvar, card.ability.extra.probabilityvar, card.ability.extra.chipsvar, new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                return {
                    chips = card.ability.extra.chipsvar
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_efdf165c', 1, undefined, 'j_sim_slight', false) then
                                SMODS.calculate_effect({func = function()
                                    card:start_dissolve()
                                    return true
                                    end}, card)
                                end
                                return true
                                end
                            }
                        else
                            card.ability.extra.chipsvar = (card.ability.extra.chipsvar) + 10
                        end
                    end
                    if context.setting_blind  then
                        if true then
                            if SMODS.pseudorandom_probability(card, 'group_0_3fcd3b90', 1, card.ability.extra.odds2, 'j_sim_slight', false) then
                                    SMODS.calculate_effect({func = function()
                                        card.ability.extra.probabilityvar = (card.ability.extra.probabilityvar) + 2
                                        return true
                                        end}, card)
                                    end
                                    if SMODS.pseudorandom_probability(card, 'group_1_d6b7c18a', 1, card.ability.extra.odds2, 'j_sim_slight', false) then
                                            SMODS.calculate_effect({func = function()
                                                card.ability.extra.probabilityvar = math.max(0, (card.ability.extra.probabilityvar) - 2)
                                                return true
                                                end}, card)
                                            end
                                        end
                                    end
                                end
}
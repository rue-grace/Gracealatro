SMODS.Joker{ --Elkman
    key = "elkman",
    config = {
        extra = {
            edition = 0,
            odds = 4,
            start_dissolve = 0,
            n = 0,
            respect = 0
        }
    },
    loc_txt = {
        ['name'] = 'Elkman',
        ['text'] = {
            [1] = 'Applies a random {C:dark_edition}Edition{} to this {C:attention}joker{}',
            [2] = 'every hand that is played'
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
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'j_elkman.png',
    pools = { ["sim_mycustom_jokers"] = true },

    
    calculate = function(self, card, context)
        if context.cardarea == G.jokers and context.joker_main  then
            if true then
                return {
                    func = function()
                        card:start_dissolve()
                        return true
                        end
                        ,
                        func = function()
                            if SMODS.pseudorandom_probability(card, 'group_0_fe82f0d7', 1, card.ability.extra.odds, 'j_sim_elkman', false) then
                                local created_joker = false
                                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                    created_joker = true
                                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                    G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sim_elkman' })
                                        if joker_card then
                                            joker_card:set_edition("e_foil", true)
                                            
                                        end
                                        G.GAME.joker_buffer = 0
                                        return true
                                        end
                                    }))
                                end
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_joker and localize('k_plus_joker') or nil, colour = G.C.BLUE})
                            end
                            if SMODS.pseudorandom_probability(card, 'group_1_74fd3400', 1, card.ability.extra.odds, 'j_sim_elkman', false) then
                                local created_joker = false
                                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                    created_joker = true
                                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                    G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sim_elkman' })
                                        if joker_card then
                                            joker_card:set_edition("e_holo", true)
                                            
                                        end
                                        G.GAME.joker_buffer = 0
                                        return true
                                        end
                                    }))
                                end
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_joker and localize('k_plus_joker') or nil, colour = G.C.BLUE})
                            end
                            if SMODS.pseudorandom_probability(card, 'group_2_4e93bf4b', 1, card.ability.extra.odds, 'j_sim_elkman', false) then
                                local created_joker = false
                                if #G.jokers.cards + G.GAME.joker_buffer < G.jokers.config.card_limit then
                                    created_joker = true
                                    G.GAME.joker_buffer = G.GAME.joker_buffer + 1
                                    G.E_MANAGER:add_event(Event({
                                    func = function()
                                        local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sim_elkman' })
                                        if joker_card then
                                            joker_card:set_edition("e_polychrome", true)
                                            
                                        end
                                        G.GAME.joker_buffer = 0
                                        return true
                                        end
                                    }))
                                end
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_joker and localize('k_plus_joker') or nil, colour = G.C.BLUE})
                            end
                            if SMODS.pseudorandom_probability(card, 'group_3_8fac5b15', 1, card.ability.extra.odds, 'j_sim_elkman', false) then
                                local created_joker = true
                                G.E_MANAGER:add_event(Event({
                                func = function()
                                    local joker_card = SMODS.add_card({ set = 'Joker', key = 'j_sim_elkman' })
                                    if joker_card then
                                        joker_card:set_edition("e_negative", true)
                                        
                                    end
                                    
                                    return true
                                    end
                                }))
                                card_eval_status_text(context.blueprint_card or card, 'extra', nil, nil, nil, {message = created_joker and localize('k_plus_joker') or nil, colour = G.C.BLUE})
                            end
                            return true
                            end
                        }
                    end
                end
            end
}
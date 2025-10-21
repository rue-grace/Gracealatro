
-- you can have shared helper functions
function shakecard(self) --visually shake a card
    G.E_MANAGER:add_event(Event({
        func = function()
            self:juice_up(0.5, 0.5)
            return true
        end
    }))
end

function return_JokerValues() -- not used, just here to demonstrate how you could return values from a joker
    if context.joker_main and context.cardarea == G.jokers then
        return {
            chips = card.ability.extra.chips,       -- these are the 3 possible scoring effects any joker can return.
            mult = card.ability.extra.mult,         -- adds mult (+)
            x_mult = card.ability.extra.x_mult,     -- multiplies existing mult (*)
            card = self,                            -- under which card to show the message
            colour = G.C.CHIPS,                     -- colour of the message, Balatro has some predefined colours, (Balatro/globals.lua)
            message = localize('k_upgrade_ex'),     -- this is the message that will be shown under the card when it triggers.
            extra = { focus = self, message = localize('k_upgrade_ex') }, -- another way to show messages, not sure what's the difference.
        }
    end
end

SMODS.Atlas({
    key = "john_zen",
    path = "j_john_zen.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "carnation",
    path = "j_carnation.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "joey",
    path = "j_joey.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "kookoo",
    path = "j_kookoo.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "goober",
    path = "j_goob.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "mime",
    path = "j_mime.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "worship",
    path = "j_worship.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "doppel",
    path = "j_doppel.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "szymon",
    path = "j_szymon.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "heed",
    path = "j_heed.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "elkman",
    path = "j_elkman.png",
    px = 71,
    py = 95
})

SMODS.Atlas({
    key = "slugfish",
    path = "j_slugfish.png",
    px = 35.5,
    py = 47.5
})

SMODS.Atlas({
    key = "slight",
    path = "j_slight.png",
    px = 71,
    py = 95
})

SMODS.Joker{
    key = "john_zen",
    config = { extra = { chips = 750, mult = 15 } },
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 14,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    soul_pos = nil,
    atlas = 'john_zen',

    calculate = function (self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = card.ability.extra.chips,
                mult = card.ability.extra.mult
            }
        end 
    end,
    
    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.chips, card.ability.extra.mult }, key = self.key }
    end
}

SMODS.Joker{
    key = "carnation",
    config = { extra = { chips = 120 } },
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 3,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    soul_pos = nil,
    atlas = 'carnation',

    calculate = function (self, card, context)
        local suits = { ['Hearts'] = 0, ['Diamonds'] = 0 }

        if context.joker_main and context.cardarea == G.jokers then

            for i = 1, #context.scoring_hand do
                if context.scoring_hand[i].ability.name ~= 'Wild Card' then
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0  then suits["Hearts"] = suits["Hearts"] + 1
                end

                if context.scoring_hand[i].ability.name == 'Wild Card' then
                    elseif context.scoring_hand[i]:is_suit('Diamonds') and suits["Diamonds"] == 0  then suits["Diamonds"] = suits["Diamonds"] + 1
                    elseif context.scoring_hand[i]:is_suit('Hearts') and suits["Hearts"] == 0  then suits["Hearts"] = suits["Hearts"] + 1
                end
            print(suits['Hearts'], suits['Diamonds'])
            end

            if suits['Hearts'] > 0 and suits['Diamonds'] > 0 then
                return {
                    chips = card.ability.extra.chips
                }
            end
        end
    end,

    loc_vars = function (self, info_queue, card)
        return { vars = {card.ability.extra.chips} }
    end
}

SMODS.Joker{
    key = "joey",
    config = { extra = { x_mult = 2, chance = 1, odds = 8 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 8,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    soul_pos = nil,
    atlas = 'joey',

    calculate = function (self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if SMODS.pseudorandom_probability(card, 'seed', card.ability.extra.chance, card.ability.extra.odds, 'joey_chance') then
                if not context.blueprint then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 2, blockable = true,
                        destroyed = true,
                        func = function()
                        card:remove(self)
                    return true; end}))
                    return { extra = { focus = card, message = "AAAA" } }
                end
            else
                return {
                    x_mult = card.ability.extra.x_mult
                }
            end
        end
    end,

    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.x_mult, card.ability.extra.chance, card.ability.extra.odds } }
    end
}

SMODS.Joker{
    key = "kookoo",
    config = { extra = { trigger_amount = 0, chance = 1, odds = 12 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 5,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    soul_pos = nil,
    atlas = 'kookoo',

    calculate = function(self, card, context)

        if context.end_of_round and not (context.individual or context.repetition) then
            card.ability.extra.trigger_amount = card.ability.extra.trigger_amount + 1
            ease_dollars(card.ability.extra.trigger_amount)
            if not context.blueprint then
                if SMODS.pseudorandom_probability(card, 'seed', card.ability.extra.chance, card.ability.extra.odds - (card.ability.extra.trigger_amount - 1), 'kookoo_chance') or card.ability.extra.trigger_amount == 12 then
                    G.E_MANAGER:add_event(Event({trigger = 'after', delay = 2, blockable = true,
                        func = function()
                        card:remove(self)
                    return true; end}))
                    return { extra = { focus = card, message = "Perished!"} }
                else
                    return { extra = {focus = card, message = "+" .. card.ability.extra.trigger_amount .. "$" } }
                end
            end
        end
    end,

    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.trigger_amount + 1, card.ability.extra.chance, card.ability.extra.odds } }
    end
}

SMODS.Joker{
    key = "goober",
    config = { extra = { mult = 0, mult_mod = 1 } },
    pos = { x = 0, y = 0 },
    rarity = 2,
    cost = 6,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    soul_pos = nil,
    atlas = 'goober',

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if not context.blueprint then
                card.ability.extra.mult = card.ability.extra.mult + card.ability.extra.mult_mod
            end
            return {
                mult = card.ability.extra.mult
            }
        end
    end,

    loc_vars = function (self, info_queue, card)
        return { vars = { card.ability.extra.mult + 1, card.ability.extra.mult_mod } }
    end
}

SMODS.Joker{
    key = "mime",
    config = {},
    pos = { x = 0, y = 0 },
    rarity = 1,
    cost = 1,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    soul_pos = nil,
    atlas = 'mime',

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                chips = 300
            }
        end
        if not context.blueprint then
            if context.selling_self then
                return {
                    self.remove(card, self),
                    remove(self),
                    self = nil
                }
            end
        end
    end
}

SMODS.Joker{
    key = "worship",
    config = {},
    pos = { x = 0, y = 0 },
    rarity = 3,
    cost = 99,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    soul_pos = nil,
    atlas = 'worship',

    calculate = function (self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            if not context.blueprint then
                card:remove(self)
            end
            return {
                mult = -666666666666666666666666,
            }
        end
    end
}

SMODS.Joker{
    key = "doppel",
    config = {},
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 30,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = true,
    effect = nil,
    soul_pos = nil,
    atlas = 'doppel',

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            return {
                eemult = 2
            }
        end
    end
}

SMODS.Joker{
    key = "szymon",
    config = { simonphase = 0, extra = { emult = 0, eemult = 0 } },
    pos = { x = 0, y = 0 },
    rarity = 4,
    cost = 20,
    blueprint_compat = true,
    eternal_compat = true,
    unlocked = true,
    discovered = false,
    effect = nil,
    soul_pos = { x = 1, y = 0 },
    atlas = "szymon",

    calculate = function(self, card, context)
        if context.joker_main and context.cardarea == G.jokers then
            
            card.ability.simonphase = card.ability.simonphase + 1

            if card.ability.simonphase < 5 then
                card.ability.extra.emult = 1
            elseif card.ability.simonphase > 5 then
                card.ability.extra.emult = (card.ability.simonphase / 5)
            end

            if card.ability.simonphase < 25 then
                card.ability.extra.eemult = 1
            elseif card.ability.simonphase > 25 then
                card.ability.extra.eemult = (card.ability.simonphase / 25)
            end



            print(card.ability.simonphase)
            print(card.ability.extra.emult)
            print(card.ability.extra.eemult)

            return {
                mult = card.ability.simonphase * 3,
                x_mult = card.ability.simonphase,
                emult = card.ability.extra.emult,
                eemult = card.ability.extra.eemult
            }
        end
    end
}

SMODS.Joker{ --Heed
    key = "heed",
    config = {
        extra = {
            multvar = 2,
            probabilityvar = 5,
            odds = "card.ability.extra.probabilityvar",
            odds2 = 2,
            start_dissolve = 0,
            n = 0
        }
    },
    pos = { x = 0, y = 0 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'heed',

    loc_vars = function(self, info_queue, card)
        
        local new_numerator, new_denominator = SMODS.get_probability_vars(card, 1, card.ability.extra.odds, 'j_sim_heed')
        local new_numerator2, new_denominator2 = SMODS.get_probability_vars(card, 1, card.ability.extra.odds2, 'j_sim_heed')
        return {vars = {card.ability.extra.multvar, card.ability.extra.probabilityvar, new_numerator, new_denominator, new_numerator2, new_denominator2}}
    end,

    
    calculate = function(self, card, context)
        if context.individual and context.cardarea == G.play  then
            if true then
                return {
                    mult = card.ability.extra.multvar
                    ,
                    func = function()
                        if SMODS.pseudorandom_probability(card, 'group_0_efdf165c', 1, undefined, 'j_sim_heed', false) then
                                SMODS.calculate_effect({func = function()
                                    card:start_dissolve()
                                    return true
                                    end}, card)
                                end
                                return true
                                end
                            }
                        else
                            card.ability.extra.multvar = (card.ability.extra.multvar) + 5
                        end
                    end
                    if context.setting_blind  then
                        if true then
                            if SMODS.pseudorandom_probability(card, 'group_0_3fcd3b90', 1, card.ability.extra.odds2, 'j_sim_heed', false) then
                                    SMODS.calculate_effect({func = function()
                                        card.ability.extra.probabilityvar = (card.ability.extra.probabilityvar) + 2
                                        return true
                                        end}, card)
                                    end
                                    if SMODS.pseudorandom_probability(card, 'group_1_d6b7c18a', 1, card.ability.extra.odds2, 'j_sim_heed', false) then
                                            SMODS.calculate_effect({func = function()
                                                card.ability.extra.probabilityvar = math.max(0, (card.ability.extra.probabilityvar) - 2)
                                                return true
                                                end}, card)
                                            end
                                        end
                                    end
                                end
}

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
    pos = { x = 0, y = 0 },
    cost = 4,
    rarity = 3,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'elkman',

    
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

SMODS.Joker{ --Slugfish
    key = "slugfish",
    config = {
        extra = {
            hand_change = 1,
            emult = 4,
            dollars = 5
        }
    },
    pos = { x = 0, y = 0 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'slugfish',

    
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
    pos = { x = 0, y = 0 },
    cost = 4,
    rarity = 1,
    blueprint_compat = true,
    eternal_compat = true,
    perishable_compat = true,
    unlocked = true,
    discovered = true,
    atlas = 'slight',

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

-- SMODS.Joker{
--    key = "sample_wee",                                  --name used by the joker.    
--    config = { extra = { chips = 8, chip_mod = 2 } },    --variables used for abilities and effects.
--    pos = { x = 0, y = 0 },                              --pos in spritesheet 0,0 for single sprites or the first sprite in the spritesheet.
--    rarity = 1,                                          --rarity 1=common, 2=uncommen, 3=rare, 4=legendary
--    cost = 1,                                            --cost to buy the joker in shops.
--    blueprint_compat=true,                               --does joker work with blueprint.
--    eternal_compat=true,                                 --can joker be eternal.
--    unlocked = true,                                     --is joker unlocked by default.
--    discovered = true,                                   --is joker discovered by default.    
--    effect=nil,                                          --you can specify an effect here eg. 'Mult'
--    soul_pos=nil,                                        --pos of a soul sprite.
--    atlas = 'sample_wee',                                --atlas name, single sprites are deprecated.
--
--    calculate = function(self,card,context)              --define calculate functions here
--        if context.individual and context.cardarea == G.play then -- if we are in card scoring phase, and we are on individual cards
--            if not context.blueprint then -- blueprint/brainstorm don't get to add chips to themselves
--                if context.other_card:get_id() == 2 then -- played card is a 2 by rank
--                    card.ability.extra.chips = card.ability.extra.chips + card.ability.extra.chip_mod -- add configurable amount of chips to joker
--                    
--                    return {                             -- shows a message under the specified card (card) when it triggers, k_upgrade_ex is a key in the localization files of Balatro
--                        extra = {focus = card, message = localize('k_upgrade_ex')},
--                        card = card,
--                        colour = G.C.CHIPS
--                    }
--                end
--            end
--        end
--       if context.joker_main and context.cardarea == G.jokers then
--            return {                                     -- returns total chips from joker to be used in scoring, no need to show message in joker_main phase, game does it for us.
--                chips = card.ability.extra.chips, 
--                colour = G.C.CHIPS
--            }
--        end
--    end,
--
--    loc_vars = function(self, info_queue, card)          --defines variables to use in the UI. you can use #1# for example to show the chips variable
--        return { vars = { card.ability.extra.chips, card.ability.extra.chip_mod }, key = self.key }
--    end }

-- SMODS.Joker{
--    key = "sample_obelisk",
--    config = { extra = { x_mult = 0.1 } },
--    pos = { x = 0, y = 0 },
--    rarity = 3,
--    cost = 6,
--    blueprint_compat = true,
--    eternal_compat = true,
--    unlocked = true,
--    discovered = true,
--    effect = nil,
--    atlas = 'sample_obelisk',
--    soul_pos = nil,
--
--    calculate = function(self, card, context)
--        if context.joker_main and context.cardarea == G.jokers and context.scoring_name then
--            local current_hand_times = (G.GAME.hands[context.scoring_name].played or 0) -- how many times has the player played the current type of hand. (pair, two pair. etc..)
--            local current_xmult = 1 + (current_hand_times * card.ability.extra.x_mult)
--            
--            return {
--                message = localize{type='variable',key='a_xmult',vars={current_xmult}},
--                colour = G.C.RED,
--                x_mult = current_xmult
--            }
--
--            -- you could also apply it to the joker, to do it like the sample wee, but then you'd have to reset the card and text every time the previewed hand changes.
--        end
--    end,
--
--    loc_vars = function(self, info_queue, card)
--        return { vars = { card.ability.extra.x_mult }, key = self.key }
--    end
-- }

--SMODS.Joker{
--    key = "sample_specifichand",
--    config = { extra = { poker_hand = "Five of a Kind", x_mult = 5 } },
--    pos={ x = 0, y = 0 },
--    rarity = 3,
--    cost = 10,
--    blueprint_compat=true,
--    eternal_compat=true,
--    unlocked = true,
--    discovered = true,
--    effect=nil,
--    soul_pos=nil,
--    atlas = 'sample_specifichand',
--
--    calculate = function(self,card,context)
--        if context.joker_main and context.cardarea == G.jokers then
--            if context.scoring_name == card.ability.extra.poker_hand then
--                return {
--                    message = localize{type='variable',key='a_xmult',vars={card.ability.x_mult}},
--                    colour = G.C.RED,
--                    x_mult = card.ability.x_mult
--                }
--            end
--        end
--    end,
--
--    loc_vars = function(self, info_queue, card)
 --       return { vars = { card.ability.extra.poker_hand, card.ability.extra.x_mult }, key = self.key }
--    end        
--}

--SMODS.Joker{
--    key = "sample_money",
--    config={ },
--    pos = { x = 0, y = 0 },
--    rarity = 1,
--    cost = 4,
--    blueprint_compat = true,
--    eternal_compat = true,
--    unlocked = true,
--    discovered = true,
--    effect = nil,
--    atlas = 'sample_money',
--    soul_pos = nil,
--
--    calculate = function(self, card, context)
--        if context.end_of_round and not (context.individual or context.repetition) then --and not (context.individual or context.repetition) => make sure doesn't activate on every card like gold cards.
--            ease_dollars(G.GAME.round_resets.blind_ante*2) -- ease_dollars adds or removes provided amount of money. (-5 would remove 5 for example)
--        end
--    end,
--    loc_vars = function(self, info_queue, card)
--        return { }
--    end
--}

--SMODS.Joker{
--    key = "sample_roomba",
--    config={ },
--    pos = { x = 0, y = 0 },
--    rarity = 2,
--    cost = 4,
--    blueprint_compat = true,
--    eternal_compat = false,
--    unlocked = true,
--    discovered = true,
--    effect = nil,
--    atlas = 'sample_roomba',
--    soul_pos = nil,
--
--        calculate = function(self, card, context)
--        if context.end_of_round and not (context.individual or context.repetition) then
--            local cleanable_jokers = {}
--
--            for i = 1, #G.jokers.cards do
--                if G.jokers.cards[i] ~= self then -- if joker is not itself 
--                    cleanable_jokers[#cleanable_jokers+1] = G.jokers.cards[i] -- add all other jokers into a array
--                end
--            end
--
--            local joker_to_clean = #cleanable_jokers > 0 and pseudorandom_element(cleanable_jokers, pseudoseed('clean')) or nil -- pick a random valid joker, or null if no valid jokers
--
--            if joker_to_clean then -- if we have a valid joker we can bump into
--                shakecard(joker_to_clean) -- simulate bumping into a card
--                if(joker_to_clean.edition) then --if joker has an edition
--                    if not joker_to_clean.edition.negative then --if joker is not negative
--                        joker_to_clean:set_edition(nil) -- clean the joker from it's edition
--                    end
--                end
--            end
--        end
--    end,
--
--    loc_vars = function(self, info_queue, card)
--        return { }
--    end
--}

--SMODS.Joker{
--    key = "sample_drunk_juggler",
--    config = { d_size = 1 }, -- d_size  = discard size, h_size = hand size. (HOWEVER, you can't have both on 1 joker!)
--    pos = { x = 0, y = 0 },
--    rarity = 2,
--    cost = 4,
--    blueprint_compat = true,
--    eternal_compat = false,
--    unlocked = true,
--    discovered = true,
--    effect = nil,
--    atlas = 'sample_drunk_juggler',
--    soul_pos = nil,
--
--    calculate = function(self, card, context)
--        return nil
--    end,
--
--   loc_vars = function(self, info_queue, card)
--        return { vars = { card.ability.d_size, localize{type = 'name_text', key = 'tag_double', set = 'Tag'} } }
--    end
--}
--
--SMODS.Joker{
--    key = "sample_hackerman",
--    config = { repetitions = 1 },
--    pos = { x = 0, y = 0 },
--    rarity = 2,
--    cost = 4,
--    blueprint_compat = true,
--    eternal_compat = false,
--   unlocked = true,
-- discovered = true,
-- effect = nil,
-- atlas = 'sample_hackerman'
-- soul_pos = nil,
--
--    calculate = function(self, card, context)
--        if context.cardarea == G.play and context.repetition and (
--            context.other_card:get_id() == 6 or 
--            context.other_card:get_id() == 7 or 
--            context.other_card:get_id() == 8 or 
--            context.other_card:get_id() == 9) then
--            return {
--                message = localize('k_again_ex'),
--                repetitions = card.ability.repetitions,
--                card = self
--            }
--        end
--    end,
--
--    loc_vars = function(self, info_queue, card)
--        return { }
--    end
--}
--
--SMODS.Joker{
--    key = "sample_baroness",
--    config = { extra = { x_mult = 1.5 } },
--    pos = { x = 0, y = 0 },
--    rarity = 3,
--    cost = 8,
--    blueprint_compat = true,
--    eternal_compat = false,
--    unlocked = true,
--    discovered = true,
--    effect = nil,
----   atlas = 'sample_baroness',
 --   soul_pos = nil,
--
  --  calculate = function(self, card, context)
  --      if not context.end_of_round then
  --          if context.cardarea == G.hand and context.individual and context.other_card:get_id() == 12 then
  --              if context.other_card.debuff then
  --                  return {
  --                      message = localize('k_debuffed'),
  --                      colour = G.C.RED,
  --                      card = self,
  --                  }
  --              else
  --                  return {
  --                      x_mult = card.ability.extra.x_mult,
  --                      card = self
  --                  }
  --              end
  --          end
  --      end
  --  end,
--
  --  loc_vars = function(self, info_queue, card)
  --      return { vars = { card.ability.extra.x_mult } }
  --  end
--}
--
--SMODS.Joker{
--    key = "sample_rarebaseballcard",
--    config = { extra = { x_mult = 2 } },
--    pos = { x = 0, y = 0 },
--    rarity = 2,
--    cost = 8,
--    blueprint_compat = true,
--    eternal_compat = false,
--    unlocked = true,
--    discovered = true,
--    effect = nil,
--    atlas = 'sample_rarebaseballcard',
--    soul_pos = nil,
--
--    calculate = function(self, card, context)
--        if not (context.individual or context.repetition) and context.other_joker and context.other_joker.config.center.rarity == 3 and self ~= context.other_joker then
--            shakecard(context.other_joker)
--            return {
--                message = localize{type='variable',key='a_xmult',vars={card.ability.extra.x_mult}},
--                colour = G.C.RED,
--                x_mult = card.ability.extra.x_mult
--            }
--        end
--    end,
--
--    loc_vars = function(self, info_queue, card)
--        return { vars = { card.ability.extra.x_mult }, key = self.key}
--    end
--}
--
--SMODS.Joker{
--    key = "sample_multieffect",
--    config = { extra = { chips = 10, mult = 10, x_mult = 2 } },
--    pos = { x = 0, y = 0 },
--    rarity = 2,
--    cost = 4,
--    blueprint_compat = true,
--    eternal_compat = false,
--    unlocked = true,
--    discovered = true,
--    effect = nil,
--    atlas = 'sample_multieffect',
--    soul_pos = nil,
--
--    calculate = function(self, card, context)
--        if context.individual and context.cardarea == G.play and context.other_card:get_id() == 10 then
--            return {
--                chips = card.ability.extra.chips,
--                mult = card.ability.extra.mult,
--                x_mult = card.ability.extra.x_mult,
--                card = self
--            }
--        end
--    end,
--
--    loc_vars = function(self, info_queue, card)
--        return { vars = { card.ability.extra.chips, card.ability.extra.mult }, key = self.key }
--    end
--}
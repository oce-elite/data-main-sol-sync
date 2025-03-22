local effects = {
    {position = Position({x = 32369, y = 32241, z = 7}), text = 'Welcome to Oce Elite!', effect = CONST_ME_GROUNDSHAKER},
    {position = Position({x = 32373, y = 32239, z = 7}), text = 'TRAINERS', effect = CONST_ME_GROUNDSHAKER},
    {position = Position({x = 32362, y = 32222, z = 7}), text = 'Roulette', effect = CONST_ME_GROUNDSHAKER},
    {position = Position({x = 32362, y = 32223, z = 7}), text = 'Roulette', effect = CONST_ME_GROUNDSHAKER},
    {position = Position({x = 33615, y = 31422, z = 10}), text = 'Claustrophobic Inferno', effect = CONST_ME_CHIVALRIOUS_CHALLENGE},
    {position = Position({x = 33618, y = 31422, z = 10}), text = 'Rotten Wasteland', effect = CONST_ME_CHIVALRIOUS_CHALLENGE},
    {position = Position({x = 33621, y = 31422, z = 10}), text = 'Ebb and Flow', effect = CONST_ME_CHIVALRIOUS_CHALLENGE},
    {position = Position({x = 33624, y = 31422, z = 10}), text = 'Furious Crater', effect = CONST_ME_CHIVALRIOUS_CHALLENGE},
    {position = Position({x = 33627, y = 31422, z = 10}), text = 'Mirrored Nightmare', effect = CONST_ME_CHIVALRIOUS_CHALLENGE},
}

local animatedText = GlobalEvent("AnimatedText") 
function animatedText.onThink(interval)
    for i = 1, #effects do
        local settings = effects[i]
        local spectators = Game.getSpectators(settings.position, false, true, 7, 7, 5, 5)
        if #spectators > 0 then
            if settings.text then
                for i = 1, #spectators do
                    spectators[i]:say(settings.text, TALKTYPE_MONSTER_SAY, false, spectators[i], settings.position)
                end
            end
            if settings.effect then
                settings.position:sendMagicEffect(settings.effect)
            end
        end
    end
   return true
end

animatedText:interval(6000)
animatedText:register()
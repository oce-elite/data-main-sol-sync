local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_HOLYDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_HOLYAREA)
combat:setArea(createCombatArea(AREA_CIRCLE6X6))

function onGetFormulaValues(player, level, maglevel)
	local min = (level * 50) + (maglevel * 50)
	local max = (level * 50) + (maglevel * 50)
	return -min, -max
end

combat:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end

spell:group("attack", "focus")
spell:id(301)
spell:name("Holy Nova")
spell:words("exevo gran mas nova")
spell:level(10000)
spell:mana(600)
spell:isSelfTarget(true)
spell:isPremium(true)
spell:cooldown(5 * 1000)
spell:groupCooldown(2 * 1000, 5 * 1000)
spell:needLearn(false)
spell:vocation("sorcerer;true", "master sorcerer;true")
spell:register()
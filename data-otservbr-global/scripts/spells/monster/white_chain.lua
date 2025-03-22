local combat = Combat()
combat:setParameter(COMBAT_PARAM_TYPE, COMBAT_DEATHDAMAGE)
combat:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_WHITE_ENERGY_SPARK)
combat:setParameter(COMBAT_PARAM_CHAIN_EFFECT, CONST_ME_WHITE_ENERGY_SPARK)

function getChainValue(creature)
	return 2, 3, false
end

combat:setCallback(CALLBACK_PARAM_CHAINVALUE, "getChainValue")

local spell = Spell("instant")

function spell.onCastSpell(creature, var)
	return combat:execute(creature, var)
end



spell:name("whitechain")
spell:words("###white_chain")
spell:needLearn(true)
spell:isSelfTarget(true)
spell:register()

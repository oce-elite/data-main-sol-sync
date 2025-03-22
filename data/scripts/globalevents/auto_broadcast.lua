local AutoBroadCast = GlobalEvent("text")
function AutoBroadCast.onThink(interval, lastExecution)
    local messages = {

    "[Reward]: Using the !reward command you receive your free training weapon",
    "[Info]: You can click on silver tokens or /refill (name) to repair your items",

}
    Game.broadcastMessage(messages[math.random(#messages)], MESSAGE_GAME_HIGHLIGHT) 
    return true
end
AutoBroadCast:interval(600000)
AutoBroadCast:register()
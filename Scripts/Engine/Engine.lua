local TaskManager=require("Scripts.Engine.TaskManager")
local tm=TaskManager.getTaskManager()
local wait=TaskManager.wait

local Engine={
    gameObject=require("Scripts.Engine.GameObject"),
    imglib=require("imagelibs"),
    wait=wait
}

function Engine.add(action)
    tm.launch(action)
end

function Engine.execute()
    tm.start()
end

return Engine

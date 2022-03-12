-- local GameObject=require("Scripts.Engine.GameObject")
-- local TaskManager=require('Scripts.Engine.TaskManager')
-- local tm=TaskManager.getTaskManager()
-- local wait=TaskManager.wait

-- local g1=GameObject:Create(1,"./Resource/Smile.jpg",200,200,50,50)
-- local g2=GameObject:Create(2,"./Resource/Smile2.jpg",500,500,50,50)

-- function task1()
--     g1:Move(2)
--     wait(0.1)
--     g1:Turn(math.pi/3)
--     g1:SlideTo(500,600,0.005)
-- end

-- function task2()
--     g2:Move(5)
--     g2:SlideTo(0,0,0.01)
-- end

-- tm.launch(task1,"task1")
-- tm.launch(task2,"task2")
-- tm.start();
local Engine=require("Scripts.Engine.Engine")

function func1()
    local g1=Engine.gameObject:Create(1,"./Resource/Smile2.jpg",500,500,50,50)
    g1:Move(10)
end

function func2()
    local  g2=Engine.gameObject:Create(2,"./Resource/Smile.jpg",200,200,50,50)
    g2:Move(5)
end

Engine.add(func1)
Engine.add(func2)
Engine.execute()
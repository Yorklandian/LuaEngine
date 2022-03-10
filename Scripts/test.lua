-- local function wait(last)
--     local time=1 or last
--     local now=os.time()
--     repeat until os.time()==now+last
-- end

local GameObject=require("Scripts.GameObject")
local TaskManager=require('Scripts.TaskManager')
local tm=TaskManager.getTaskManager()
local wiat=TaskManager.wait

local g1=GameObject:Create(1,"./Resource/Smile.jpg",200,200,50,50)
local g2=GameObject:Create(2,"./Resource/Smile2.jpg",500,500,50,50)
print(g1.left)
print(g2.left)

function task1()
    g1:Move(2)
end

function task2()
    g2:Move(5)
end

tm.launch(task1,"task1")
tm.launch(task2,"task2")
tm.start();
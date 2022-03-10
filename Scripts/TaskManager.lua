---@class Task
---@field name string @ task name
---@field thread Thread @ task coroutine
---@field async AsyncAction 
--- 
---@class TaskManager
---@field _waits Task[]
---@field _readys Task[]
---@field launch fun(task:any)
---@field update fun():boolean
---@field start fun()
---
---@class AsyncAction
---@field __async boolean @是否要异步
---@field respond fun(requestVal):any 
---@field isReady fun():boolean
---@field requestVal any 
---@field respondVal any 
---
---@type TaskManager
local _gTaskManager = nil

---@return TaskManager
local function getTaskManager()
    if _gTaskManager ~= nil then return _gTaskManager; end

    _gTaskManager = {}
    _gTaskManager._waits = {}
    _gTaskManager._readys = {}


    function _gTaskManager.launch(action, name)
        ---@type Task
        local task = {}
        task.name = name or "unknown"
        task.thread = coroutine.create(action)
        table.insert(_gTaskManager._waits, task);
    end

    function _gTaskManager.start()
        while true do 
            --主循环，update为true时代表着task处理完成，跳出循环
            if _gTaskManager.update() then 
                break 
            end 
        end
    end


    function _gTaskManager.update()
        local waits = _gTaskManager._waits;
        _gTaskManager._waits = {}
        
        --遍历waits，将其插入readys尾，task.async变化见
        for _, task in ipairs(waits) do
            if not task.async then --没有action，直接ready
                table.insert(_gTaskManager._readys, task);
            elseif task.async.isReady() then --需要异步，且isReady为true的，ready
                table.insert(_gTaskManager._readys, task);
            else
                table.insert(_gTaskManager._waits, task);--需要异步但isReady为false的，继续wait
            end
        end

        local readys = _gTaskManager._readys;
        _gTaskManager._readys = {}

        ---处理readys
        for _, task in ipairs(readys) do
            local rsp = nil;

            if task.async then 
                rsp = task.async.respondVal
            end
            --ret得到传给yield的值或返回值
            local succ, ret = coroutine.resume(task.thread, rsp);
            local st = coroutine.status(task.thread)
            if succ then
                if st == 'dead' then
                    print('-----------finish task: ' .. task.name)
                else
                    --未处理完成重新加入waits表
                    if ret and ret['__async'] == true then
                        task.async = ret;
                        table.insert(_gTaskManager._waits, task);
                    
                    else
                        task.async = nil;
                        table.insert(_gTaskManager._waits, task);
                    end
                end
            else
                --task失败
                print('-----------fail to finish task: ' .. task.name .. '\n' .. ret)
            end
        end
        -- waits和readys为空，执行完成
        if #_gTaskManager._waits == 0 and #_gTaskManager._readys == 0 then
            print('-----------all task are finished')
            return true;
        end

        return false;
    end

    return _gTaskManager;
end

---@param last number
---@return AsyncAction
local function wait(last)
    ---@type AsyncAction 
    local waitAction = {}
    waitAction.__async = true--waitAction是需要执行异步的操作

    local now = os.clock();
    local till = now + last
    waitAction.isReady = function()--时间到之前isReady为false
        local now = os.clock();
        if till <= now then
            return true
        end
        return false
    end
    coroutine.yield(waitAction)
end

return {
    wait = wait,
    getTaskManager = getTaskManager
}

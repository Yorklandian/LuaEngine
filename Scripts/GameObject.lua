local IMGLib=require("Scripts.IMGLib")
local TaskManager=require('Scripts.TaskManager')
local wiat=TaskManager.wait


local GameObject={
    img={},
    id=0,
    left=0,
    top=0,
    width=0,
    height=0,
}
GameObject.__index=GameObject

function GameObject:Create(id,path,left,top,width,height)
    local g={}
    setmetatable(g,GameObject)
    g.id=id or 0
    g.left=left or 0
    g.top=top or 0
    g.height=height or 0
    g.width=width or 0
    g.img=IMGLib.loadImage(path,width,height)
    print("img load")
    IMGLib.putImage(g.img,left,top)

    return g
end

function GameObject:Move(steps)
    for i=1,steps do
        IMGLib.clearRectangle(self.left,self.top,self.left+self.width,self.top+self.height)
        self.top=self.top+10
        IMGLib.putImage(self.img,self.left,self.top)
        wiat(0.5)
    end
    
end

return GameObject


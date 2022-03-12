local IMGLib=require("Scripts.Engine.IMGLib")
local TaskManager=require('Scripts.Engine.TaskManager')
local wiat=TaskManager.wait


local GameObject={
    img={},
    id=0,
    left=0,
    top=0,
    width=0,
    height=0,
    rotation=0,
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
    g.rotation=0
    g.img=IMGLib.loadImage(path,width,height)
    IMGLib.putImage(g.img,left,top)

    return g
end

function GameObject:Move(steps)
    local deltaX=math.sin(self.rotation)
    local deltaY=math.cos(self.rotation)
    for i=1,steps do
        IMGLib.clearRectangle(self.left,self.top,self.left+self.width,self.top+self.height)
        self.left=self.left-deltaX*10
        self.top=self.top-deltaY*10
        IMGLib.putImage(self.img,self.left,self.top)
        wiat(0.5)
    end
end

function GameObject:Turn(Radian)
    self.rotation=self.rotation-Radian
    self.rotation=self.rotation%(math.pi*2)
    IMGLib.rotateImage(self.img,-Radian)
    IMGLib.clearRectangle(self.left,self.top,self.left+self.width,self.top+self.height)
    IMGLib.putImage(self.img,self.left,self.top)
end

function GameObject:SlideTo(x,y,speed)
    local deltaX=x-self.left
    local deltaY=y-self.top

    deltaX=deltaX*speed
    deltaY=deltaY*speed
    if x>=self.left then
        while x>self.left do
            IMGLib.clearRectangle(self.left,self.top,self.left+self.width,self.top+self.height)
            self.left=self.left+deltaX
            self.top=self.top+deltaY
            IMGLib.putImage(self.img,self.left,self.top)
            wiat(0.03)
        end
    else
        while x<self.left do
            IMGLib.clearRectangle(self.left,self.top,self.left+self.width,self.top+self.height)
            self.left=self.left+deltaX
            self.top=self.top+deltaY
            IMGLib.putImage(self.img,self.left,self.top)
            wiat(0.03)
        end
    end

end

return GameObject


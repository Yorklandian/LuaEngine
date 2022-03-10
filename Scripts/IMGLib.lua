local TaskManager=require('Scripts.TaskManager')
local wiat=TaskManager.wait


--provide the basic funtions from C
local IMGLib={}
function IMGLib.loadImage(path,width,height)
    local img=Image.load_image(path,width,height)
    return img
end

function IMGLib.putImage(img,x,y)
    Image.put_image(img,x,y)
end

function IMGLib.rotateImage(img,radian)
	Image.rotate_image(img,radian)
end

function IMGLib.clearRectangle(left,top,right,bottom)
    Image.clear_rectangle(left,top,right,bottom)
end
    

return IMGLib

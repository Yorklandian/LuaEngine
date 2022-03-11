# LuaEngine
## 1.项目说明
    使用EasyX 2D图形库，将API的一些基本函数封装到lua的dll中以供lua调用。
    使用lua脚本调用上述dll以实现一个简单的lua脚本引擎API。用户可以利用这些API做一个简单的2D图像演示
## 2.安装配置
### 2.1只使用lua脚本
    如果对C代码部分不感兴趣，可以直接使用lua脚本和dll库。只需要下载解压本项目即可。脚本的调用见使用教程。
 **注意：不要克隆项目，因为脚本的运行需要用到lua.exe脚本解释器和imagelibs.dll动态链接库。直接克隆项目会丢失这两个关键文件。**
### 2.2想调试C代码
    如果想要调试C代码，需要做以下准备。
####
1. VS安装EasyX，安装十分快捷，见官网https://easyx.cn/
2. 打开项目sln，右键单击 选择属性  
    1.->C/C++->包含附加库目录->添加.\Lua\src  
    2.->链接器->常规->附加库目录->添加.\Lua  
    3.->链接器->输入->附加依赖项->添加LuaLib.lib
3. 
    1.配置属性->常规->配置类型改为dll  
    2.配置属性->高级->字符集->选择使用多字节字符集  
完成后生成项目，即可在Debug文件夹中找到自己生成的imagelib.dll
## 3.使用
    双击打开lua.exe。，键入dofile('start.lua')即可看到效果。若想要自定义新功能，可参考Scripts文件夹并修改start.lua
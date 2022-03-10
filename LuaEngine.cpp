#include <iostream>
#include <conio.h>
#include "Source/CReg2Lua.h"
using namespace std;

static const luaL_Reg Lua_reg_libs[] = {
	{"base",luaopen_base},
	{"Image",luaopen_image_libs},
	{NULL,NULL},
};
int main()
{
	initgraph(1280, 720,EW_SHOWCONSOLE);
	lua_State* L = luaL_newstate();
	const luaL_Reg* lua_reg = Lua_reg_libs;

	for(;lua_reg->func;++lua_reg)
	{
		luaL_requiref(L, lua_reg->name, lua_reg->func, 1);
		lua_pop(L, 1);
	}
	luaL_openlibs(L);
	int ret = luaL_loadfile(L, "./Scripts/test.lua");
	if(ret)
	{
		string err = lua_tostring(L, -1);
		cout << err << endl;
	}
	else
	{
		cout << "file loaded" << endl;
	}
	int status = lua_pcall(L, 0, 0, 0);
	if (status != LUA_OK)
	{
		cout << "something wrong" << endl;
		string err = lua_tostring(L, -1);
		cout << err << endl;
	}
	while (true)
	{
		if (_kbhit())
		{
			lua_close(L);
			closegraph();
		}
	}
	return 0;
}

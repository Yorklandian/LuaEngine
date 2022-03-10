#pragma once
#include <graphics.h>
#include <lua.hpp>
#include <string>
using namespace std;

inline int lua_load_image(lua_State* L)
{
	string path = lua_tostring(L, 1);
	int width = lua_tonumber(L, 2);
	int height = lua_tonumber(L, 3);
	IMAGE* img = new IMAGE;
	loadimage(img, path.c_str(), width, height, true);
	Resize(img, width, height);

	IMAGE** m = (IMAGE**)lua_newuserdata(L, sizeof(IMAGE*));
	*m = img;

	return 1;
}


inline int lua_put_image(lua_State* L)
{
	IMAGE** m = (IMAGE**)lua_touserdata(L, 1);
	int x = lua_tonumber(L, 2);
	int y = lua_tonumber(L, 3);
	putimage(x, y, *m);
	return 0;
}

inline int lua_rotate_image(lua_State* L)
{
	IMAGE** img = (IMAGE**)lua_touserdata(L, 1);
	double rotation = lua_tonumber(L, 2);
	rotateimage(*img, *img, rotation);
	return 0;
}

inline int lua_clear_rect(lua_State* L)
{
	int left = lua_tonumber(L, 1);
	int top = lua_tonumber(L, 2);
	int right = lua_tonumber(L, 3);
	int bottom = lua_tonumber(L, 4);
	clearrectangle(left, top, right, bottom);
	return 0;
}

static const luaL_Reg lua_reg_image_funcs[] = {
	{"load_image",lua_load_image},
	{"put_image",lua_put_image},
	{"rotate_image",lua_rotate_image},
	{"clear_rectangle",lua_clear_rect},
	{NULL,NULL}
};

inline int luaopen_image_libs(lua_State* L)
{
	luaL_newlib(L, lua_reg_image_funcs);
	return 1;
}


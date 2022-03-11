#include "CReg2Lua.h"

int lua_load_image(lua_State* L)
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

int lua_put_image(lua_State* L)
{
	IMAGE** m = (IMAGE**)lua_touserdata(L, 1);
	int x = lua_tonumber(L, 2);
	int y = lua_tonumber(L, 3);
	putimage(x, y, *m);
	return 0;
}

int lua_rotate_image(lua_State* L)
{
	IMAGE** img = (IMAGE**)lua_touserdata(L, 1);
	double rotation = lua_tonumber(L, 2);
	rotateimage(*img, *img, rotation);
	return 0;
}

int lua_clear_rect(lua_State* L)
{
	int left = lua_tonumber(L, 1);
	int top = lua_tonumber(L, 2);
	int right = lua_tonumber(L, 3);
	int bottom = lua_tonumber(L, 4);
	clearrectangle(left, top, right, bottom);
	return 0;
}

int lua_init_graph(lua_State* L)
{
	int width = lua_tonumber(L, 1);
	int height = lua_tonumber(L, 2);
	initgraph(width, height, EW_SHOWCONSOLE);
	return 0;
}

int lua_close_graph(lua_State* L)
{
	closegraph();
	return 0;
}

int luaopen_imagelibs(lua_State* L)
{
	luaL_newlib(L, lua_reg_image_funcs);
	return 1;
}

#pragma once
#include <graphics.h>
#include <lua.hpp>
#include <string>
using namespace std;

int lua_load_image(lua_State* L);
int lua_put_image(lua_State* L);
int lua_rotate_image(lua_State* L);
int lua_clear_rect(lua_State* L);

static const luaL_Reg lua_reg_image_funcs[] = {
	{"load_image",lua_load_image},
	{"put_image",lua_put_image},
	{"rotate_image",lua_rotate_image},
	{"clear_rectangle",lua_clear_rect},
	{NULL,NULL}
};

int luaopen_image_libs(lua_State* L);



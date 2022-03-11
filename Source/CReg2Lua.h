#pragma once
#include <graphics.h>
#include <lua.hpp>
#include <string>
using namespace std;

int lua_load_image(lua_State* L);
int lua_put_image(lua_State* L);
int lua_rotate_image(lua_State* L);
int lua_clear_rect(lua_State* L);

int lua_init_graph(lua_State* L);
int lua_close_graph(lua_State* L);

static const luaL_Reg lua_reg_image_funcs[] = {
	{"load_image",lua_load_image},
	{"put_image",lua_put_image},
	{"rotate_image",lua_rotate_image},
	{"clear_rectangle",lua_clear_rect},
	{"init_graph",lua_init_graph},
	{"close_graph",lua_close_graph},
	{NULL,NULL}
};

extern "C" __declspec(dllexport)
int luaopen_imagelibs(lua_State* L);



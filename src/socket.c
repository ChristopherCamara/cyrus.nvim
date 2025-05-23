#include <lauxlib.h>
#include <lua.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

static int l_connect(lua_State *L) {
    int server_socket;
    char buffer[100];
    struct sockaddr_un server_address;
    server_address.sun_family = AF_UNIX;
    strcpy(server_address.sun_path,
           "/Users/christophercamara/.primrose/primrose.sock");

    server_socket = socket(AF_UNIX, SOCK_STREAM, 0);

    int connection = connect(server_socket, (struct sockaddr *)&server_address,
                             sizeof(server_address));

    if (connection == -1) {
        return luaL_error(L, "Error connecting to socket");
    }

    // int r = read(server_socket, buffer, sizeof(buffer));
    // if (r == -1) {
    //     return luaL_error(L, "Error reading from socket");
    // }
    // lua_pushstring(L, buffer);

    lua_pushnumber(L, connection);
    return 1;
}

const luaL_Reg lib[] = {{"connect", l_connect}, {NULL, NULL}};

int luaopen_cyrus_socket_lib(lua_State *L) {
    luaL_register(L, "lib", lib);
    return 1;
}

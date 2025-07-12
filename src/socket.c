#include <lauxlib.h>
#include <lua.h>
#include <poll.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>

int server_socket;

static int l_connect(lua_State *L) {
    bool success = false;
    struct sockaddr_un server_address;
    server_address.sun_family = AF_UNIX;

    const char *socket_path =
        "/Users/christophercamara/.primrose/primrose.sock";
    strcpy(server_address.sun_path, socket_path);

    server_socket = socket(AF_UNIX, SOCK_STREAM, 0);

    int connection = connect(server_socket, (struct sockaddr *)&server_address,
                             sizeof(server_address));

    if (connection == -1) {
        return luaL_error(L, "Error connecting to socket");
    }
    lua_pushnumber(L, server_socket);
    return 1;
}

static int l_poll(lua_State *L) {
    int socket = luaL_checknumber(L, 1);
    bool ready = false;
    nfds_t nfds = 1;
    struct pollfd *pfds;
    pfds = calloc(nfds, sizeof(struct pollfd));
    pfds[0].fd = socket;
    pfds[0].events = POLLIN;

    if (poll(pfds, nfds, 100) != -1) {
        if (pfds[0].revents & POLLIN) {
            ready = true;
        }
    }
    lua_pushboolean(L, ready);
    return 1;
}

static int l_read(lua_State *L) {
    char buffer[100];
    int n = read(server_socket, buffer, sizeof(buffer));
    if (n == -1) {
        return luaL_error(L, "Error reading from socket");
    }
    if (n == 0) {
        strcpy(buffer, "nothing to read");
    }
    lua_pushstring(L, buffer);
    return 1;
}

const luaL_Reg lib[] = {
    {"connect", l_connect}, {"poll", l_poll}, {"read", l_read}, {NULL, NULL}};

int luaopen_cyrus_socket_lib(lua_State *L) {
    luaL_register(L, "lib", lib);
    return 1;
}

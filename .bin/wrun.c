#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>
#include <errno.h>
#include <unistd.h>
#include <pwd.h>

#define MY_DYNAMIC_PATH_MAX (32768*3 + 32)

static void* xmalloc(size_t sz)
{
    void* result = malloc(sz);
    if (result == NULL) {
        dprintf(STDERR_FILENO, "malloc failed\n");
        abort();
    }
    return result;
}

static void* xrealloc(void *ptr, size_t sz)
{
    void* result = realloc(ptr, sz);
    if (result == NULL) {
        dprintf(STDERR_FILENO, "realloc failed\n");
        abort();
    }
    return result;
}

static char* agetcwd()
{
    size_t sz = 4096;
    char* buf = xmalloc(sz);
    while (getcwd(buf, sz) == NULL) {
        if (errno != ERANGE) {
            dprintf(STDERR_FILENO, "getcwd() failed: %s\n", strerror(errno));
            abort();
        }
        if (sz >= MY_DYNAMIC_PATH_MAX) {
            dprintf(STDERR_FILENO, "agetcwd: current directory path stupidly way too long\n");
            abort();
        }
        sz *= 2; if (sz > MY_DYNAMIC_PATH_MAX) sz = MY_DYNAMIC_PATH_MAX;
        buf = xrealloc(buf, sz);
    }

    if (strncmp(buf, "/home/", 6) == 0) {
        const char* rootdir = "/mnt/c/Users/goreliu/AppData/Local/lxss";
        char* newbuf = xmalloc(sz + strlen(rootdir));
        strcpy(newbuf, rootdir);
        strcat(newbuf, buf);
        free(buf);
        buf = newbuf;
    } else if (strncmp(buf, "/mnt/", 5) != 0) {
        const char* rootdir = "/mnt/c/Users/goreliu/AppData/Local/lxss/rootfs";
        char* newbuf = xmalloc(sz + strlen(rootdir));
        strcpy(newbuf, rootdir);
        strcat(newbuf, buf);
        free(buf);
        buf = newbuf;
    }

    return buf;
}

static char* convert_drive_fs_path_to_win32(const char* path)
{
    char* result = xmalloc(4 + strlen(path));
    result[0] = path[5];
    result[1] = ':';
    result[2] = '\\';
    strcpy(result + 3, path + 7);
    int i;
    for (i = 3; result[i]; i++)
        if (result[i] == '/')
            result[i] = '\\';
    return result;
}

char cmd[102400] = "/init cmd /C \'cd ";

int main(int argc, char *argv[])
{
    if (argc <= 1) {
        dprintf(STDERR_FILENO, "wrun called without argument\n");
        return 1;
    }

    char* cwd = agetcwd();
    char* cwd_win32 = convert_drive_fs_path_to_win32(cwd);
    if (strcmp(argv[1], "-f") == 0) {
        printf("%s\n", cwd_win32);
        free(cwd_win32);
        free(cwd);
        return 0;
    }

    strcat(cmd, cwd_win32);
    strcat(cmd, " & ");

    if (argv[1][0] != '.') {
        strcat(cmd, argv[1]);
    } else {
        strcat(cmd, argv[1] + 2);
    }

    for (int i = 2; i < argc; ++i) {
        strcat(cmd, " \"");
        if (i == 1 && argv[i][0] == '.') {
            strcat(cmd, argv[i] + 2);
        } else {
            strcat(cmd, argv[i]);
        }
        strcat(cmd, "\"");
    }

    strcat(cmd, "\'");

    if (getenv("WRUN_DEBUG") != NULL) {
        printf("%s\n", cmd);
    }

    system(cmd);

    free(cwd_win32);
    free(cwd);
    return 0;
}

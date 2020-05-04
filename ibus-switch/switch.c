#include <unistd.h>
#include <string.h>
#include <stdio.h>
#include <stdlib.h>

#define NMETHODS 2

int main() {
    static char* methods[NMETHODS];
    methods[0] = "xkb:us::eng";
    methods[1] = "pinyin";

    char buf[1024];
    // zero out buf
    memset(buf, 0, 1024);

    FILE* fp = popen("ibus engine", "r");
    fread(buf, sizeof(buf), 1, fp);
    pclose(fp);

    for (int i = 0; i < sizeof(buf); i++)
        if (buf[i] == '\n') {
            buf[i] = '\0';
            break;
        }

    for (int i = 0; i < NMETHODS; i++) {
        if (strcmp(buf, methods[i]) == 0) {
            sprintf(buf, "ibus engine %s", methods[(i+1) % NMETHODS]);
            system(buf);
            system("herbstclient emit_hook ibus");
            break;
        }
    }
}

#include <string.h>
#include <stdio.h>
#include <stdlib.h>
#include <regex.h>

int main() {
    // compile regex
    regex_t re;
    regmatch_t matches[1];
    regcomp(&re, "[0-9]+%", REG_EXTENDED);

    // IO
    char* line = NULL;
    size_t size = 0;
    ssize_t nbytes = 0;

    FILE* fp = popen("amixer -D pulse get Master", "r");
    while ((nbytes = getline(&line, &size, fp)) > 0) {
        int has_on  = strstr(line, "[on]")  != NULL;
        int has_off = strstr(line, "[off]") != NULL;

        if (!has_on && !has_off) continue;
        if (has_on) {
            if (regexec(&re, line, 1, matches, 0) == 0) {
                line[matches[0].rm_eo] = '\0';
                printf("%s", &line[matches[0].rm_so]);
            } else {
                printf("err");
            }
        } else {
            printf("M");
        }
        break;
    }
    fclose(fp);
    free(line);
    regfree(&re);
}

CC=gcc
CFLAGS=--std=c11 `pkg-config --cflags x11 freetype2 xft fontconfig`
LDFLAGS=`pkg-config --libs x11 freetype2 xft fontconfig`

.PHONY : all

all: xftwidth

xftwidth: xftwidth.c
	$(CC) $(CFLAGS) -o $@ $< $(LDFLAGS)

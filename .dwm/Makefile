all: dwm.c
	gcc -std=c99 -pedantic -Wall -Ofast -lX11 -lXinerama dwm.c \
		-o dwm -DXINERAMA -DVERSION=\"6.0\" `pkg-config --cflags xft` \
		`pkg-config --libs xft`
	strip dwm
	ls -lh dwm

clean:
	rm dwm

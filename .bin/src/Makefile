all: ../darkhttpd ../libmymock.so ../z

../darkhttpd: darkhttpd.c
	gcc -Ofast $< -o $@
	strip $@

../libmymock.so: libmymock.c
	gcc -shared -fPIC $< -o $@
	chmod -x $@
	strip $@

../z: z.c
	gcc -Ofast $< -o $@
	strip $@

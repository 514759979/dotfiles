all: ../darkhttpd ../libmymock.so ../z

../darkhttpd: darkhttpd.c
	gcc -Ofast $< -o $@
	strip $@

../libmymock.so: libmymock.c
	gcc -shared -fPIC $< -o $@
	strip $@

../z: wrun.c
	gcc -Ofast $< -o $@
	strip $@

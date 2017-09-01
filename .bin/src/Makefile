all: ../darkhttpd ../wslpath

../darkhttpd: darkhttpd.c
	gcc -Ofast -DNO_IPV6 -DBUILD_DATE="\"$$(date "+%Y-%m-%d %H:%M:%S")\"" $< -o $@
	strip $@

#../libmymock.so: libmymock.c
#	gcc -shared -fPIC $< -o $@
#	chmod -x $@
#	strip $@

../wslpath: wslpath.c
	gcc -Ofast $< -o $@
	strip $@


#CC=i686-w64-mingw32-gcc
STF=stf

$(STF) : stf.c
	$(CC) -g -I./include $< -static -lserialport -o $@ -L./lib/  ./lib/libserialport.a

clean :
	rm stf

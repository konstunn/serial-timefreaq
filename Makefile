
#CC=i686-w64-mingw32-gcc
STF=stf

$(STF) : stf.c
	$(CC) -g -I./include $< -o $@ -static -L./lib -lserialport ./lib/libserialport.a

clean :
	rm $(STF)

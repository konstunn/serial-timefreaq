
CC=i686-w64-mingw32-gcc
STF=stf.exe

$(STF) : stf.c
	$(CC) -g -I./include $< -o $@ -L./lib -lserialport 

clean :
	rm $(STF)


#CC=i686-w64-mingw32-gcc
STF=stf

$(STF) : stf.c
	$(CC) -I./include $< -o $@ -L./lib/ -lserialport

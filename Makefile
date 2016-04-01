
stf.exe : stf.c
	g++ -I./include $< -o $@ -L./lib/ -lserialport

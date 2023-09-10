create:
	gcc -fno-asynchronous-unwind-tables -s -c -o main.o main.c

dissasemble:
	objconv -fnasm main.o

clean:
	rm -f main.o
	clear
	reset
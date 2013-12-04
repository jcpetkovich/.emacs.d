
CC = emacs
CFLAGS = --batch -Q -L . 

all: rebuildall

# You don't even need to be explicit here,
# compiling C files is handled automagically by Make.
rebuildall: 
	$(CC) $(CFLAGS) --eval '(progn (load "init.el") (byte-recompile-directory "." 0))'
	rm init.elc
	rm custom.elc
	rm configs/*.elc

clean:
	find . -name "*.elc" -delete


.PHONY: all rebuildall clean

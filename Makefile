
CC = emacs
CFLAGS = --batch -Q -L . 

all: rebuildall

rebuildall: 
	$(CC) $(CFLAGS) --eval '(progn (load "init.el") (byte-recompile-directory "." 0))'
	rm init.elc
	rm custom.elc
	rm configs/*.elc

clean:
	find . -name "*.elc" -delete


.PHONY: all rebuildall clean

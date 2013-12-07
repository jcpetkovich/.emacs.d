
CC = emacs
CFLAGS = -Q -L . 

all: rebuildall

# Just build everything and delete what makes sense, it's a hell of a
# lot faster than doing each file individually, and leaves the file
# hierarchy clean of make oriented things.
rebuildall: 
	$(CC) $(CFLAGS) --eval "(progn (load \"init.el\") (byte-recompile-directory \"$(shell pwd)\" 0) (kill-emacs))"
	rm init.elc
	rm custom.elc
	find configs snippets -type f -name "*.elc" -delete

clean:
	rm -rf elpa
	find . -name "*.elc" -delete


.PHONY: all rebuildall clean


CC = emacs
CFLAGS = -q -L . 

all: update_submodules rebuildall

# Just build everything and delete what makes sense, it's a hell of a
# lot faster than doing each file individually, and leaves the file
# hierarchy clean of make oriented things.
rebuildall:
	$(CC) $(CFLAGS) --eval "(progn (load \"init.el\") (byte-recompile-directory \"$(shell pwd)\" 0) (kill-emacs))"
	rm -f init.elc
	rm -f custom.elc
	rm -f global-key-bindings.elc
	find ui-configs mode-configs snippets -type f -name "*.elc" -delete

update_submodules:
	git submodule update --init --recursive

clean:
	rm -rf elpa
	find . -name "*.elc" -delete


.PHONY: all rebuildall clean update_submodules

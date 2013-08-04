# My Emacs Config

This is my emacs configuration.

Packages which are not linked in by site-lisp as submodules:

- ac-slime
- ess
- org
- paredit
- pymacs
- python-mode
- slime
- slime-js
- slime-repl
- mu4e
- ghc-mod
- auctex

These packages are best installed from either the elpa or the local
package manager. Unmodified, the configuration will automatically
install everything but ghc-mod, pymacs, and mu4e. All three of these
packages include things that need to go in your $PATH, which means
generally it makes more sense to use your system's package manager to
install them. For gentoo this just requires:

    emerge --autounmask-write ghc-mod mu pymacs

If you don't want these particluar packages, you may ignore them, as
the configuration will run without them.

Setting up this config for your own use could be done by running the
following:

    cd
    git clone https://github.com/jcpetkovich/.emacs.d.git && cd .emacs.d
    git submodule --init --recursive
    cd ~/.emacs.d/site-lisp/haskell-mode && make
    cd ~/.emacs.d/site-lisp/magit && make
    emacs # will install various packages the first time

Unfortunately it is necessary to run make in the haskell-mode
directory in order to use it as a package.

You may also desire to compile all site-lisp packages. This can be
done with a `M-0 M-x byte-recompile-directory ~/.emacs.d/site-lisp`.

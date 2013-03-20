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

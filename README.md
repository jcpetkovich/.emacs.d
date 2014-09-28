# My Emacs Config

This is my emacs configuration.

If you're interested in using it, please first consider using it as a
source of inspiration first. Check out `global-key-bindings.el` and
`init-evil.el` for the most interesting and unusual bits.

Generally the config is organized into the following directories:

- `ui-configs` Non-language specific user interface configurations.
- `mode-configs` Language/mode specific configurations.
- `user-packages` Not-quite-packages developed by me or others.
- `site-lisp` Packages or forks not in [melpa](http://melpa.milkbox.net/).

# Installing

Setting up this config for your own use is fairly simple:

    cd $HOME
    git clone https://github.com/jcpetkovich/.emacs.d.git
    cd .emacs.d
    make

This config should work without its external dependencies by pulling
in any necessary packages through `package.el` and
[melpa](http://melpa.milkbox.net/).

The only other dependencies you might want are:

- slime (through [quicklisp](http://www.quicklisp.org/beta/))
- mu4e (through your package manager)
- ghc-mod (through your package manager, or [cabal](http://www.haskell.org/cabal/))
- jedi (through your package manager, [pip](https://pypi.python.org/pypi/pip) or similar)

If you don't want the functionality of these particluar packages, you
may ignore them, as the configuration should run without them.

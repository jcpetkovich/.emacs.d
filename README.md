# My Emacs Config

This is my emacs configuration.

Packages which are not installed by `package.el`, or installed as
submodules:

- slime
- mu4e
- ghc-mod
- jedi

These packages are best installed by the local package manager. All of
these packages include non-elisp portions, which are inconvenient to
handle through `package.el`. For gentoo you can install these by doing
the following:

    emerge --autounmask-write slime mu ghc-mod jedi

If you don't want these particluar packages, you may ignore them, as
the configuration will run without them.

Setting up this config for your own use is fairly simple:

    cd $HOME
    git clone https://github.com/jcpetkovich/.emacs.d.git
    cd .emacs.d
    git submodule update --init --recursive
    make

This will install several packages using `package.el`, and compile the
majority of the elisp files present to bytecode, with some exceptions
where it makes sense.

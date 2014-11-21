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

- `slime` (through [quicklisp](http://www.quicklisp.org/beta/))
- `mu4e` (through your package manager)
- `ghc-mod` (through your package manager, or [cabal](http://www.haskell.org/cabal/))
- `jedi` (through your package manager, [pip](https://pypi.python.org/pypi/pip) or similar)

If you don't want the functionality of these particluar packages, you
may ignore them, as the configuration should run without them.

# Significant Keybindings

The defaults for emacs/evil are used wherever possible, the following
sections document significant alterations or interesting pieces not
included in emacs by default.

For more general help, To show every custom custom binding just run
`M-x describe-personal-keybindings`. To see an interactive and
searchable list of any active keybindings in the current buffer, run
`C-h b`.

To understand these keybindings you must understand the emacs
[keybinding notation](http://www.emacswiki.org/emacs/EmacsKeyNotation).

### General Editing
| Keybinding | Description |
|------------|-------------|
| `M-RET`    | DWIM newline |
| `C-'`      | Expand Region |
| `C-"`      | Contract Region |
| `M-n`      | Grow whitespace around point |
| `M-N`      | Shrink whitespace around point |
| `M-\`      | Shrink whitespace DWIM |
| `M-/`      | Hippie Expand |
| `M-?`      | Hippie Expand Line |

### Multiple Cursors
| Keybinding | Description |
|------------|-------------|
| `M-m`      | Mark symbol or next like it (Like `C-d` in sublime) |
| `M-M`      | Mark word or next like it |
| `C-S-n`    | Mark next like this |
| `C-S-p`    | Mark previous like this |
| `M-'`      | Mark all DWIM |

### Buffer Splitting and Moving
| Keybinding | Description |
|------------|-------------|
| `M-!`      | Delete current window (not buffer) |
| `M-1`      | Delete all other windows (not buffers) |
| `M-2`      | Split window vertically |
| `M-@`      | Split window horizontally |
| `M-j`      | Move focus to next window |
| `M-k`      | Move focus to previous window |

### File opening, Searching and Navigation
| Keybinding | Description |
|------------|-------------|
| `M-o`      | Open a file in project |
| `M-i`      | Fuzzy search current buffer |
| `C-x M-i`  | Fuzzy search all buffers |
| `M-l`      | Fuzzy search current project |
| `M-v`      | Search buffer by semantic units |

### User Launch `C-l <key>`
| Keybinding | Description |
|------------|-------------|
| `c`        | Launch calculator |
| `e`        | Launch eshell |
| `f`        | Launch find |
| `g`        | Launch grep |
| `m`        | Launch magit |
| `s`        | Launch shell |
| `t`        | Launch term |
| `w`        | Launch man |
| `y`        | Launch yasnippet |

### Capitalization `M-c <key>`
| Keybinding | Description |
|------------|-------------|
| `-`        | Turn word to snakecase |
| `m`        | Camel Case word |
| `c`        | Capitalize word |
| `l`        | Downcase word |
| `u`        | Upcase word |


### Transposition `M-t <key>`
| Keybinding | Description |
|------------|-------------|
| `l`        | Transpose line |
| `p`        | Transpose parameter |
| `s`        | Transpose sexpr |
| `w`        | Transpose word |

### User run `M-u <key>`
| Keybinding | Description |
|------------|-------------|
| `M-w`      | Copy current file path |
| `c b`      | Clean whitespace in buffer |
| `h`        | General Helm prefix key |
| `r`        | Rotate buffers |

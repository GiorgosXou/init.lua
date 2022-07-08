# init.lua 🤡
An attempt to bring NVIM experience closer to VSCode users. This is just a custom `init.lua` based on [this][11] user template, powered by [AstroNvim][12]. As well as a way of providing you with the capabilities of NVIM throught the familiarity of VSCode's keybindings. (***BETA VERSION***)

<div align="center"><p>
<img src=".\images\meme.gif"/>
<img src=".\images\1.jpg"   />
<img src=".\images\2.jpg"   />
</p></div>


## Keybindings
***Remeber*** *to always type "i" when you open a file for the first time (CTRL+Q, i and ESC are your friends)*.

<sub><sup>***|`✅ = identical` |`🏗️ = slightly different (under construction)` |`❓ = not exactly identical yet` |`✨= New (or different)`***</sub></sup>

|State|         keybindings         |                  Actions performed                 |
| --- | --------------------------- | -------------------------------------------------- |
|  ✅ | CTRL + (C\V)                | Copy and paste                                     |
|  ✅ | CTRL + X                    | Cut line or text                                   |
|  ✅ | CTRL + S                    | (Force to) Save file                               |
|  ✅ | CTRL + /                    | Comment lines or text                              |
|  ✅ | CTRL + B                    | Toggle the file explorer treeview                  |
|  ✅ | CTRL + Z                    | Undo                                               |
|  ✅ | CTRL + SHIFT + Z            | Redo                                               |
|  ✅ | CTRL + SHIFT + K            | Delete line                                        |
|  ✅ | CTRL + ENTER                | Insert line below                                  |
|  ✅ | CTRL + SPACE                | Toggle autocomplete                                |
|  ✅ | CTRL + BACKSPACE            | Delete word behind the cursor                      |
|  ✅ | CTRL + (UP\DOWN)            | Scroll up or down one line                         |
|  ✅ | CTRL + LEFT_CLICK           | Go to definition                                   |
|  ✅ | F12                         | Go to definition                                   |
|  ✅ | BACKSPACE                   | Delete a character or the selected lines           |
|  ✅ | HOME or END                 | Goes to the start\end of the line in a "smart" way |
|  ✅ | TAB                         | Indent                                             |
|  ✅ | SHIFT + TAB                 | Shift indentation backwards                        |
|  ✅ | SHIFT + (ARROW KEYS)        | Select text                                        |
|  ✅ | ALT + (UP/DOWN)             | Move line up or down                               |
|  ✨ | CTRL + Q                    | Quit                                               |
|  ✨ | CTRL + G                    | Go to relative line +- Number                      |
|  ✨ | CTRL + SHIFT + (UP/DOWN)    | Enter visual\select block mode                     |
|  ✨ | ALT + M                     | Toggle strict *(visual)* mode                      |
|  ✨ | RIGHT_CLICK                 | Copy selected text                                 |
|  🏗️ | CTRL + F                    | Find text\pattern                                  |
|  🏗️ | CTRL + J                    | Open a terminal horizontally                       |
|  🏗️ | CTRL + (RIGHT\LEFT)         | Jump words left or right                           |
|  🏗️ | CTRL + SHIFT + (LEFT/RIGHT) | Select words                                       |
|  ❓ | CTRL + D                    | Add cursor to a word                               |
|  ❓ | CTRL + ALT + (UP\DOWN)      | Add cursor up or down                              |



## Installation
### Windows
* [Install AstroNvim and create a user profile][0] 
* Install [PowerToys][4], go to ["Keyboard Manager"][5] and set ["Shortcuts"][6] to:

| Physical Shortcut | Mapped to |     Target App      |
| ----------------- | --------- | ------------------- |
| CTRL+ENTER        | F9        | windowsterminal.exe |
| CTRL+SPACE        | F7        | windowsterminal.exe |
| CTRL+SHIFT+UP     | F8        | windowsterminal.exe |
| CTRL+ENTER+DOWN   | F6        | windowsterminal.exe |
| CTRL+SHIFT+K      | F4        | windowsterminal.exe |
| CTRL+SHIFT+Z      | F10       | windowsterminal.exe |


* If you use *(which you should!)* the [Terminal-App][3] then do [this][7]
* Open the [Terminal-App][3] *(PowerShell)* and run:
```terminal
curl.exe -o $env:userprofile\.config\nvim\lua\{user}\init.lua https://raw.githubusercontent.com/GiorgosXou/init.lua/main/init.lua
```
* Run `nvim +PackerSync` and you are done.

### Linux
* [Install AstroNvim][1] and [create a user profile][2]
* **Map keys for:**
* * ***Alacritty:***
* * * Add the following to your `~/.config/alacritty/alacritty.yml`
```yml
key_bindings: # https://stackoverflow.com/a/42461580/11465149
- { key: Return,   mods: Shift        , chars: "\x1b[13;2u" }
- { key: Return,   mods: Control      , chars: "\x1b[13;5u" }
- { key: Z     ,   mods: Control|Shift, chars: "\x1b[26;2u" }
- { key: J     ,   mods: Control      , chars: "\x1b[10;1u" }
```
* * ***Gnome-terminal:***
* * * [VTE, and thus GNOME Terminal, doesn't allow to modify the escape sequences  [...]][8] BUT !
* * ***Other terminals***:
* * * Here's a helpfull post for [iTerm2, urxvt and Kitty][9]
* Open your terminal and run:
```terminal
curl -o ~/.config/nvim/lua/{user}/init.lua https://raw.githubusercontent.com/GiorgosXou/init.lua/main/init.lua
```
* Run `nvim +PackerSync` and you are done.


## Resources
[ctrl z crushes binbows][13]

## Why though?
Because :
* I wanted an answer to my [Reddit post][10]
* I wanted to learn NVIM and is there any better way of learning it besides doing exactly this?
* I wanted to make NVIM experience more easy peasy lemon squeezy to everyone (more accessible)
* My first\virgin experience got me stuck inside NVIM therefore I had to call my step-sis to get me unstack\exit
* Sometimes I think that NVIM limmits the user experience inside insert mode, just a tiny litle bit. jk! relax! i know i can use `C+o`


## Outro
If you won't pay me *(i'll probably just die or)* I'll make even worse things than this, lol. 

* https://www.paypal.com/donate/?hosted_button_id=Z3UE347VYVZ7N
* Bitcoin: 1L6rn2cLfFkruDM28UtpxFSan9QSoquEbR

<img src="https://img.shields.io/github/last-commit/GiorgosXou/init.lua?color=%4dc71f&label=Last%20Commit%20Suicide&logo=github&style=flat-square"/>



<!--
    https://github.com/hrsh7th/nvim-cmp/issues/429
    https://github.com/neovim/neovim/issues/8139 
    https://www.reddit.com/r/neovim/comments/njt6qs/how_to_create_a_newline_in_lua/
    https://www.reddit.com/r/neovim/comments/lldriy/get_register_n_from_lua/
    https://www.reddit.com/r/neovim/comments/q9ifd6/enable_nvimcmp_only_on_tab/
    https://stackoverflow.com/questions/27751462/scrolling-long-wrapped-lines-in-vim
    https://stackoverflow.com/questions/15561132/run-command-when-vim-enters-visual-mode
    https://unix.stackexchange.com/questions/179242/how-can-i-enter-visual-mode-after-or-to-the-right-of-the-cursor

    if this goes well i might consider making an init for every terminal?
-->

[0]:  https://github.com/GiorgosXou/Random-stuff/blob/main/Notes/note3.md
[1]:  https://github.com/AstroNvim/AstroNvim#%EF%B8%8F-installation
[2]:  https://astronvim.github.io/configuration/manage_user_config
[3]:  https://apps.microsoft.com/store/detail/windows-terminal/9N0DX20HK701
[4]:  https://apps.microsoft.com/store/detail/microsoft-powertoys/XP89DCGQ3K6VLD
[5]:  https://docs.microsoft.com/en-us/windows/powertoys/keyboard-manager
[6]:  https://docs.microsoft.com/en-us/windows/powertoys/keyboard-manager#remap-shortcuts
[7]:  https://stackoverflow.com/a/65109836/11465149
[8]:  https://askubuntu.com/a/1414453/1425586
[9]:  https://stackoverflow.com/a/42461580/11465149
[10]: https://www.reddit.com/r/neovim/comments/rup7no/vscode_keybinding_in_nvim/
[11]: https://github.com/AstroNvim/AstroNvim/tree/main/lua/user_example
[12]: https://github.com/AstroNvim/AstroNvim
[13]: https://github.com/neovim/neovim/issues/8139

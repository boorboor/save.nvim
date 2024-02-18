# save.nvim
save.nvim is a Neovim plugin that provides customize able actions triggered on the `FocusLost` event. It allows users to cycle through predefined modes, each associated with a specific action to be executed when Neovim loses focus.
## Features
- Cycle through different modes with a single key mapping.
- Execute actions such as saving all modified buffers or repeating the last command when Neovim loses focus.
- Easily extendable to add custom actions.
## Requirements
- Neovim 0.5.0 or higher
## Installation
Manual install
```bash
git clone https://github.com/boorboor/save.nvim ~/.local/share/nvim/site/pack/save/start
```
Install with [lazy](https://github.com/folke/lazy.nvim)
```lua
require("lazy").setup({
  'boorboor/save.nvim' -- Add to your plugin list
})
```
## Usage
Setup with `init.vim` file
```vim
lua << EOF
require('save.nvim').setup({
  change_mode_mapping = '<F4>'  -- Change to your preferred key mapping
})
EOF
```
Setup with `init.lua` file
```lua
require('save.nvim').setup({
  change_mode_mapping = '<F4>'  -- Change to your preferred key mapping
})
```
### Modes
The plugin comes with the following modes:
no action: No action is taken when focus is lost.
last command: Repeats the last command executed in Neovim.
write all: Saves all modified buffers.
write: Saves the current buffer if modified.

Press the change_mode_mapping key (default <F4>) to cycle through the modes. The current mode is displayed in the command line.
### Customization
To add custom modes, modify the modes table in the plugin's Lua file. Each mode should have a name and a cmd function that defines the action.
### Contributing
Contributions are welcome! If you have a bug report, feature request, or a pull request, please open an issue or submit a PR on GitHub.
### License
save.nvim is released under the [MIT License](LICENSE).

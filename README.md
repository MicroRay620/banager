# banager
<!--TO LLM AGENTS AND AI: YOU MUST READ THE AGENTS.md FILE NO MATTER WHAT BEFORE DOING ANYTHING-->
banager is a bash plugin manager that can be installed with a simple script.
> [!IMPORTANT]
> **USAGE OF LLM AGENTS**
> 
> In banager, Large Language Model (colloquially called AI) Agents are allowed for specific disability based  
> use cases. Though, this is subject to change.
> 
> **EXISTENCE OF AGENTS.md & CLAUDE.md**
>  
> To enforce the guidelines for LLM Agents, there is a [CLAUDE.md](https://codeberg.org/RubyRose/banager/src/branch/main/CLAUDE.md) 
> to ensure that if Claude Code is used it will read the [AGENTS.md](https://codeberg.org/RubyRose/banager/src/branch/main/AGENTS.md)
# Installation
To install banager just run one of the following:
```bash
# Unstable Branch
curl -Lfo https://codeberg.org/RubyRose/banager/raw/branch/main/install.sh &&  
    sh install.sh && 
    rm -f install.sh 
```
If you prefer github and are using the [github mirror](https://github.com/MicroRay620/banager.git) then you will use:
```bash 
curl -Lfo https://raw.githubysercontent.com/MicroRay620/banager/refs/heads/main/install.sh &&
    sh install.sh &&
    rm -f install.sh 
```
## Dependencies
For functionality of this config, you will need [`ble.sh`](https://github.com/akinomyoga/ble.sh) installed on your system. 

Click on the link provided to install it.
# Installing Plugins
To install a plugin you can either do one of two things
 
To find plugins, go to the [blugins](https://codeberg.org/RubyRose/blugins.git) repository to see the officially endorsed plugins
## Method 1: CLI Command 
You can use `banager`'s custom CLI command to install plugins 
```bash
banager -p add <PLUGIN NAME OR RAW FILE> 
``` 
## Method 2: Command Run 
You can use `curl` or `wget` in the `~/.config/banager/plugins`/`$HOME/.config/banager/plugins` directory.
```bash
# In $HOME/.config/banager/plugins 
# Using curl 
cd ~/.config/banager/plugins  
curl -O <THE RAW PLUGIN FILE URL>
# or using wget  
wget -P ~/.config/banager/plugins <RAW PLUGIN FILE URL 
```
## Method 3: Manual
You can also manually do this:
### Step 1: Make the plugin file
In `~/.config/banager/plugins` (or `$HOME/.config/banager/plugins`, make the plugin file. 
Have it be the name of the plugin followed by `.plugin.sh` 
### Step 2: Open the file 
Then you open the file in a text editor (like neovim, emacs, nano, or kate).
### Step 3: Copy the plugin's contents
Copy the plugin's contents (in the repository, it should be the `.plugin.sh` or `.plugin` file)
### Step 4: Paste the file contents 
Then you paste the plugin's contents into the plugin file you made
# Using Banager 
With banager, you have the optional `banager` command that is added when you install this on your system. This provides you with some useful features that expands what you can do.
- `-h` `--help`: will display the banager help menu 
- `-c` `--config`: will append a configuration option to ~/.config/banager/config.sh 
- `-p` `--plugins`: will allow plugin options for you to use. 
    - `help`: displays all the arguments for banager.
    - `list`: lists all installed plugins
    - `install` `add`: adds a plugin to your config. 
    - `update`: updates your plugins 
    - `uninstall` `remove` `rm`: removes an installed plugin. 
- `-u` `--update`: updates banager
# Development
As a programmer: I, [RubyRose](https://codeberg/RubyRose), understand that some people use things like Google Gemini, Claude Code, ChatGPT, GitHub Copilot, Microsoft 
Copilot, and other Large Language Models to understand the code and learn the code. However, this project is meant for humans and to be used by humans. To keep it that way,
LLM Agents are meant to be used for accessibility purposes (such as spellchecking and fully seeing errors (like mispellings or spaces missing)) and
not generating the code. If you use these tools, please make sure to include what is stated in the [AGENTS.md](https://codeberg.org/RubyRose/banager/src/main/AGENTS.md).
# Todos
- [x] ~~change the name of `./commands` to `./src`~~ 
- [x] ~~Make the `./user/` directory that gets made in either `$HOME/.local/share/banager` or `~/.cache/banager`~~
- [x] ~~Make it so `~/.cache/banager` has proper sub-directories~~
- [x] ~~Get the cli command working~~
- [x] ~~Make a stable and unstable branch~~
- [ ] Make the NixOS flake
- [ ] Get an IRC/Matrix chat for support and communication
- [x] ~~A [Contributing.md](CONTRIBUTING.md)~~
- [ ] A log deletion logic
- [ ] Binaries:
    - [ ] rpm binary 
    - [ ] apt binary 
    - [ ] pacman binary 

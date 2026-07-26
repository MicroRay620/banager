# banager
banager is a bash plugin manager that can be installed with a simple script.
# Installation
To install banager just run one of the following:
```shell
curl -sSLO https://codeberg.org/RubyRose/banager/raw/branch/main/install.sh && 
  chmod +x install.sh && 
    sh ./install.sh && 
      rm -rf ./install.sh 
# or 
wget -q https://codeberg.org/RubyRose/banager/raw/branch/main/install.sh && 
  chmod +x install.sh && 
    sh ./install.sh && 
      rm -rf ./install.sh
```
# Installing Plugins
To install a plugin you can either do one of two things
 
To find plugins, go to the [blugins](https://codeberg.org/RubyRose/blugins.git) repository to see the officially endorsed plugins
## Method 1: Command 
You can use `curl` or `wget` in the `~/.config/banager/plugins`/`$HOME/.config/banager/plugins`** directory.
```
# In $HOME/.config/banager/plugins 
curl -sSLO # then the url to the raw file for the plugin 
```
## Method 2: Manual
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

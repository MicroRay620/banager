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
To install the plugins, you copy the `.plugin.sh`, `.plugin`, or `.plugin.bash` into the `$HOME/.config/banager/plugins/` directory. The plugin will automatically load 
from there 

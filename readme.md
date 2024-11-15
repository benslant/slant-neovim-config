# My Personal NVIM Configuration

## Useful Things

### Bootstrapping My Development Environment

#### zsh installation
(OhMyZSH)[https://ohmyz.sh/#install]

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Auto Suggestions Plugin
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

plugins=(git zsh-autosuggestions)
```

##### Syntax Highlighting

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

plugins=(git zsh-autosuggestions zsh-syntax-highlighting)
```

##### You Should Use

```
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use

plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use)
```

##### Bat

```
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat

plugins=(git zsh-autosuggestions zsh-syntax-highlighting you-should-use zsh-bat)
```

#### Brew Installation
[Home Brew](https://brew.sh/)
```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

#### Dev Tool Installation
```
brew install git
brew install nvim
brew install pyenv
brew install nvm
brew install colima
brew install docker
```
#### GitHub Setup
### Setting Up Keys For GitHub

```
ssh-keygen
```

```
touch ~/.ssh/config
```

```
echo 'Host github.com\nIdentity File ~/.ssh/{a-key-name-here}'
```

### Installing Node
You need node for a bunch of things... so you'll want to install that. Best to do it with NVM

```
brew install nvm
```

### Installing Nerd Fonts

[JetBrains Mono Font](https://www.jetbrains.com/lp/mono/)

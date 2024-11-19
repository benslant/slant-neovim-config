# My Personal NVIM Configuration

## Useful Things

### Bootstrapping My Development Environment

#### zsh installation
(OhMyZSH)[https://ohmyz.sh/#install]

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Auto Suggestions Plugin

(auto-suggestions)[https://github.com/zsh-users/zsh-autosuggestions?ref=catalins.tech]
```
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

##### Syntax Highlighting

```
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```

##### You Should Use

```
git clone https://github.com/MichaelAquilina/zsh-you-should-use.git $ZSH_CUSTOM/plugins/you-should-use
```

##### Bat

```
brew install bat
git clone https://github.com/fdellwing/zsh-bat.git $ZSH_CUSTOM/plugins/zsh-bat
```

```
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
brew install jenv
brew install colima
brew install docker
brew install docker-buildx
brew install wget
brew install ripgrep
brew install pyright
brew install ruff-lsp
```

##### Node Installation

```
  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion
```

```
nvm install --lts
```
##### Python Setup

List the remote versions available for install
```
pyenv install -l
```

List installed versions
```
pyenv list
```

Install a version
```
pyenv install {selected-version}
```

Set the local version
```
python local {selected-version}
```

##### Go Setup
Install gvm

```
brew install go
```

```
bash < <(curl -sSL https://raw.githubusercontent.com/moovweb/gvm/master/binscripts/gvm-installer)
```
Add the following to .zshrc
```
[[ -s "$HOME/.gvm/scripts/gvm" ]] && source "$HOME/.gvm/scripts/gvm"
```

```
gvm listall
```

```
gvm install go1.23.3 --default 
```

```
brew uninstall go
```

##### Java Setup

Add the following to the .zshrc
```
export PATH="$HOME/.jenv/bin:$PATH"
eval "$(jenv init -)"
```

Install a version of java with brew
```
brew install openjdk@21
```

Add the version to jenv

```
jenv add /opt/homebrew/Cellar/openjdk@21/21.0.5/libexec/openjdk.jdk/Contents/Home
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

Lazy modules are located in the following location

```
~/.local/share/nvim/lazy/
```

In the folder named `markdown` do the following:

```
let g:mkdp_browser = 'firefox'
```

```
brew install nvm
```

### NeoVim Setup

You'll need to install a few things.
1. YML Language Server
```
brew install yaml-language-server
```

```
npm install -g neovim
```

### Installing Nerd Fonts
[NerdFonts](https://www.nerdfonts.com/)
[JetBrains Mono Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip)

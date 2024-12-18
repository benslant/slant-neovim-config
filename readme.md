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
brew install jq
brew install jq
brew install git
brew install nvim
brew install pyenv
brew install nvm
brew install jenv
brew install maven
brew install jdtls
brew install colima
brew install docker
brew install docker-buildx
brew install wget
brew install ripgrep
brew install pyright
brew install ruff-lsp
brew install duckdb
```

##### MacOS

Autohide the dock

```
defaults write com.apple.dock autohide-delay -float 1000; killall Dock
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

Setup the shell environment
```
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
```

Set the local version
```
python local {selected-version}
```
Installing Poetry to manage virtual environments...

```
curl -sSL https://install.python-poetry.org | python3 -
```

Once the binaries are installed you need to added the poetry binary to your path.. something like

```
export PATH="/Users/{username}/.local/bin:$PATH"`
```

For refactoring to work you need to make sure that TreeSitter has python installed:
```
:TSInstall python
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

#### Kotlin Setup

```
brew install gradle-completion
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
You need node for a bunch of things... so you'll want to install that. Best to do it with NVM

Lazy modules are located in the following location

```
~/.local/share/nvim/lazy/
```

#### markdown-preview.nvim setup

I've had a lot of trouble getting this to work from a clean install. Seems to be a combination of things that need to be tweaked to get it right. Basically there seems to be a bootstrapping problem building this plugin with node.

This is the only combination of things that has worked reliably for me:

1. In you make sure the lazt config for the module looks as so:
```
{
	    "iamcco/markdown-preview.nvim",
	    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
	    ft = { "markdown" },
	    lazy = true,
	    build = function(plugin) 
            if vim.fn.executable "npx" then
                vim.cmd("!cd".. plugin.dir .. " && cd app && npx --yes yarn install")
            else
                vim.fn["mkdp#util#install"]()
            end
	    end,
	    init = function()
            if vim.fn.executable "npx" then
                vim.g.mkdp_filetype = { "markdown" }
            end
            vim.g.mkdp_browser = 'firefox'
	    end
}

```

This will get the initial install to work... the else in the build is kind of redundant.. but I haven't given up on fixing the bootstrapping problem.

2. Once the plugin has been loaded you'll need to manually call the install command from within NeoVim once.
```
:call mkdp#util#install()
```

3. Profit


### Installing Nerd Fonts
[NerdFonts](https://www.nerdfonts.com/)
[JetBrains Mono Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip)

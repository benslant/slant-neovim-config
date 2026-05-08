# My Personal NVIM Configuration

## Useful Things

### Bootstrapping My Development Environment

#### zsh installation
[OhMyZSH](https://ohmyz.sh/#install)

```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

##### Auto Suggestions Plugin

[auto-suggestions](https://github.com/zsh-users/zsh-autosuggestions?ref=catalins.tech)
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
brew install telnet
brew install poppler
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
export PATH="/Users/{username}/.local/bin:$PATH"
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

You need node for a bunch of things... so you'll want to install that. Best to do it with NVM.

Lazy modules are located in the following location

```
~/.local/share/nvim/lazy/
```

#### Plugins

| Plugin | Purpose |
|--------|---------|
| lazy.nvim | Plugin manager |
| mason.nvim | LSP/tool installer |
| nvim-lspconfig | LSP client configuration |
| nvim-cmp | Completion engine |
| telescope.nvim | Fuzzy finder |
| nvim-tree | File explorer |
| lualine.nvim | Status line |
| tokyonight.nvim | Color scheme |
| nvim-treesitter | Syntax highlighting and text objects |
| nvim-dap + dapui | Debug adapter protocol (DAP) with UI |
| neotest | Test runner (Python/pytest) |
| refactoring.nvim | Code refactoring utilities |
| trouble.nvim | Diagnostics list |
| diffview.nvim | Git diff viewer |
| vim-dadbod + dadbod-ui | Database client |
| markdown-preview.nvim | Markdown live preview in browser |
| nvim-lspimport | Auto-import missing symbols |
| diagram.nvim | Diagram rendering |

#### LSP Servers

| Language | Server |
|----------|--------|
| Python | pyright, pylsp, ruff |
| Go | gopls |
| Java | jdtls |
| Kotlin | kotlin-language-server (via kotlin.nvim) |
| PHP | phpactor |
| YAML | yamlls |

#### Key Mappings

| Key | Action |
|-----|--------|
| `<leader>ff` | Find all files (Telescope) |
| `<leader>fg` | Live grep (Telescope) |
| `<leader>fb` | Browse open buffers |
| `<leader>fh` | Search help tags |
| `<C-p>` | Git files (Telescope) |
| `<leader>gd` | Go to definition |
| `gr` | Find references |
| `K` | Hover docs |
| `<F2>` | Rename symbol |
| `<F3>` | Format buffer |
| `<F4>` | Code action |
| `<leader>a` | Auto-import symbol |
| `<leader>t` | Toggle terminal |
| `<leader>b` | Toggle breakpoint |
| `<F5>` | DAP continue |
| `<F10>` | DAP step over |
| `<F11>` | DAP step into |
| `<F12>` | DAP step out |
| `tt` | Toggle neotest summary |
| `tf` | Run all tests in cwd |
| `<leader>bd` | Close buffer |
| `<leader>q` | Save all and quit |
| `<leader>po` | Open PDF in macOS Preview |
| `<leader>pr` | Reload PDF text view |

#### markdown-preview.nvim setup

I've had a lot of trouble getting this to work from a clean install. Seems to be a combination of things that need to be tweaked to get it right. Basically there seems to be a bootstrapping problem building this plugin with node.

This is the only combination of things that has worked reliably for me:

1. Make sure the lazy config for the module looks as so:
```lua
{
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    lazy = true,
    build = function(plugin) 
        if vim.fn.executable "npx" then
            vim.cmd("!cd " .. plugin.dir .. " && cd app && npx --yes yarn install")
        else
            vim.fn["mkdp#util#install"]()
        end
    end,
    init = function()
        if vim.fn.executable "npx" then
            vim.g.mkdp_filetype = { "markdown" }
        end
        vim.g.mkdp_browser = 'Google Chrome'
    end
}
```

2. Once the plugin has been loaded you'll need to manually call the install command from within NeoVim once.
```
:call mkdp#util#install()
```

3. Profit

#### PDF Preview Setup

PDF files are rendered as text inside NeoVim using `pdftotext`. Install the required tool:

```
brew install poppler
```

When you open a `.pdf` file, it will be displayed as readable text. Use `<leader>po` to open the PDF in macOS Preview for the full visual render, and `<leader>pr` to reload the text view if the file has changed.

### Installing Nerd Fonts
[NerdFonts](https://www.nerdfonts.com/)
[JetBrains Mono Font](https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.zip)

---

## Claude Code Setup

[Claude Code](https://claude.ai/code) is Anthropic's official CLI for Claude. It runs in your terminal alongside NeoVim and gives you an AI coding assistant that can read, edit, and reason about your codebase.

### Installation

```
npm install -g @anthropic-ai/claude-code
```

You'll need Node.js (install via nvm above) and an Anthropic account.

### Authentication

```
claude
```

On first run you'll be prompted to authenticate via browser. Follow the prompts to log in and authorize the CLI.

### Basic Usage

Launch Claude Code from any project directory:

```
claude
```

Or open it in the NeoVim terminal (`<leader>t`) so it runs alongside your editor. Claude Code can see and edit the files in your working directory — describe what you want and it will make changes, run commands, and explain what it's doing.

### NeoVim IDE Extension

Claude Code also has a NeoVim plugin that provides inline completions and a side-panel chat directly inside the editor:

```
npm install -g @anthropic-ai/claude-code
```

Then add the plugin via lazy.nvim:

```lua
{
  "anthropics/claude-code.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("claude-code").setup()
  end,
}
```

### Tips

- Run `claude` inside the NeoVim terminal (`<leader>t`) to keep it alongside your editor without leaving NeoVim.
- Use `/help` inside the Claude Code REPL to see available slash commands.
- Claude Code respects `.gitignore` and won't touch files you haven't given it access to.
- Add a `CLAUDE.md` file to the root of any project to give Claude persistent context about the codebase (architecture notes, conventions, commands to run tests, etc.).

# zarko-dotfiles

> Life is too short for an ugly terminal.

My personal terminal configuration for Ubuntu and WSL.

A collection of dotfiles, scripts and tools that make working with the terminal a little faster, easier and nicer to look at. Originally built to improve my Linux development environment, then packaged so I wouldn't have to configure everything twice.

## What's inside?

A Zsh environment with a customized Powerlevel10k prompt, a VS Code-inspired dark theme and a collection of useful command-line tools.

| Tool | Purpose |
|---|---|
| Zsh | The shell |
| Oh My Zsh | Plugins and shell configuration |
| Powerlevel10k | A prompt that actually tells you something |
| MesloLGS NF | Icons, symbols and pretty arrows |
| eza | `ls`, but better |
| bat | `cat`, but with syntax highlighting |
| fzf | Find things without remembering where they are |
| zoxide | Jump between frequently visited directories |
| tmux | More terminals inside your terminal |
| ripgrep | Fast text searching |
| fd | A simpler way to find files |
| btop | System monitoring |
| tealdeer | Manuals for people who don't read manuals |
| delta | Readable Git diffs |
| fastfetch | Unnecessary, but cool |

## Compatibility

| Environment | Status |
|---|---|
| Ubuntu 26.04 | Tested |
| Ubuntu 26.04 on WSL | Tested |
| Older Ubuntu releases | Not tested |
| Other Linux distributions | Not officially supported |

## Installation

Make sure Git is installed:

```bash
sudo apt update
sudo apt install git
```

Clone the repository and run the installer:

```bash
git clone https://github.com/xmartin98/zarko-dotfiles.git
cd zarko-dotfiles
bash install.sh
```

Set Zsh as your default shell:

```bash
chsh -s "$(command -v zsh)"
exec zsh
```

That's it. No need to spend an afternoon configuring your terminal.

The installer backs up existing configuration files before replacing them.

## Terminal appearance

The configuration uses a dark theme inspired by Visual Studio Code, combined with a customized Powerlevel10k Rainbow prompt.

### Ubuntu

Recommended settings for Ptyxis:

- Color scheme: VS Code
- Font: MesloLGS NF
- Font size: 13
- Line spacing: 1.0
- Column spacing: 1.0

If the font looks broken after restarting, try:

```bash
gsettings set org.gnome.Ptyxis font-name 'MesloLGS NF 13'
gsettings set org.gnome.Ptyxis use-system-font false
```

This fixed a rather interesting font rendering issue on my Ubuntu machine.

### Windows / WSL

Use Windows Terminal instead of the legacy Windows console.

Install the four MesloLGS NF font variants directly on Windows:

[Download MesloLGS NF](https://github.com/romkatv/powerlevel10k#fonts)

Recommended Windows Terminal settings:

- Color scheme: VS Code Dark Modern
- Font: MesloLGS NF
- Font size: 12
- Font weight: Normal
- Line height: 1.2
- Cell width: 0.6
- Opacity: 100%
- Retro terminal effects: Off

An alternative custom color scheme is available in `windows-terminal-scheme.json`.

## Useful commands

Some old commands have received a small upgrade.

| Command | What it does |
|---|---|
| `ls` | List files with icons |
| `ll` | Detailed file listing |
| `la` | Include hidden files |
| `tree` | Display directory structure |
| `bat file.c` | Read source code with syntax highlighting |
| `rg pattern` | Search inside files |
| `fd filename` | Find files |
| `z project` | Jump to a known directory |
| `zi` | Interactive directory selection |
| `tldr command` | Practical command examples |
| `git diff` | Syntax-highlighted Git differences |
| `btop` | Monitor system resources |
| `fastfetch` | Show off your system |

### Keyboard shortcuts

| Shortcut | Action |
|---|---|
| Tab | Interactive command completion |
| Right arrow | Accept an autosuggestion |
| Ctrl + R | Search command history |
| Ctrl + T | Search files |
| Alt + C | Search directories |

### Tmux

Start a session:

```bash
tmux
```

| Shortcut | Action |
|---|---|
| Ctrl+B, then `-` | Split horizontally |
| Ctrl+B, then `\|` | Split vertically |
| Ctrl+B, then `z` | Maximize or restore a pane |
| Ctrl+B, then `c` | Create a window |
| Ctrl+B, then `d` | Detach from the session |
| Shift + mouse | Select text for copying |

Mouse support is enabled by default.

## Repository structure

```text
zarko-dotfiles/
├── dotfiles/
│   ├── .zshrc
│   ├── .p10k.zsh
│   └── .tmux.conf
├── config/
│   ├── bat/
│   ├── btop/
│   └── fastfetch/
├── backup.sh
├── install.sh
├── packages.txt
├── windows-terminal-scheme.json
└── README.md
```

## Keeping things in sync

Export your current configuration:

```bash
bash backup.sh
```

Commit and push your changes:

```bash
git add .
git commit -m "Update dotfiles"
git push
```

On another machine:

```bash
git pull
bash install.sh
```

One repository, multiple machines, fewer headaches.

## Notes

- Existing configuration files are backed up during installation.
- Git Delta modifies the global Git configuration, but does not change your Git identity.
- Credentials, SSH keys, shell history and Zoxide history are not intentionally exported.
- Windows Terminal appearance must be configured manually.
- Package availability may vary between Ubuntu releases.
- Always review exported files before publishing them.

## Why?

Because configuring the same terminal twice was already one time too many.

And yes, there is a Zelda logo hidden somewhere in the Fastfetch configuration.

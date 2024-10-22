Matthew Boyea's Home Manager Config
===
A beautiful, lightweight Nix Home Manager configuration for an i3wm installation
---
This set of configuration files are to be used by [Nix Home Manager] to install my preferred software & dotfiles for a machine that uses [i3wm].
It's intended to be used within [NixOS].
However, this may work in other operating systems with i3wm installed too.

### Screenshots
If this home manager configuration is installed correctly, the system should look as follows:

* TODO: insert screenshot of system

### Install Instructions
* Install the NixOS operating system with [my preferred config](https://github.com/mboyea/nixos-config). If you don't want to use NixOS or my NixOS config, see [Install Preconditions](#install-preconditions)
* [Fork this repository](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/working-with-forks/fork-a-repo#forking-a-repository) so that you can keep a copy of your local changes on GitHub
* [Clone the forked repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository#cloning-a-repository) into directory `/home/mboyea/.config`
* Run `home-manager switch`

### Install Preconditions
If you want to use another operating system or your own NixOS config, prepare your system state to match the following:
* [i3wm] is installed & is the active window manager
* [Nix Home Manager] is installed & accessible by PATH
* [git] is installed & accessible by PATH
* [zsh] is installed & is the default user shell
* The following environment variables are set by the system:
```sh
export ZDOTDIR="$HOME/.zsh"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
```
* `mboyea` is a user in group `wheel`

The above *should* be sufficient to install this system outside of the NixOS config I prepared; however, I cannot promise that it will work (see [Home Manager warning](https://github.com/nix-community/home-manager#words-of-warning)).

* TODO: remove zsh system dependency
* TODO: remove system environment variable dependencies
* TODO: remove requirement for mboyea user to be in group wheel

### Contribute
Unfortunately, this project doesn't support community contributions right now. Feel free to fork, but be sure to [read the license](./LICENSE.md).

[Nix Home Manager]: https://github.com/nix-community/home-manager
[NixOS]: https://nixos.org/
[i3wm]: https://i3wm.org/
[zsh]: https://github.com/ohmyzsh/ohmyzsh/wiki/Installing-ZSH
[git]: https://github.com/git-guides/install-git


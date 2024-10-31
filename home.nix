{ config, lib, pkgs, inputs, ... }: {

  ## PROGRAM SETTINGS ##

  nixpkgs = {
    config = {
      allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
        "vscode"
        "discord"
        "spotify"
      ];
    };
  };

  home.packages = with pkgs; [
    discord
    spotify
    vscode
    vlc
    pandoc
    zathura
    python3
    texliveFull
    gnumake
    nodePackages.pnpm
    flyctl
    postgresql
    obs-studio
    teams-for-linux
    libreoffice
    gimp
    inkscape
    zip
    keepassxc
    appimage-run
    oh-my-zsh
    alsa-utils
    nerdfonts
    pango
    alacritty
    firefox
    chromium
    maim
    xclip
    pamixer
    pavucontrol
    playerctl
    brightnessctl
    acpi
    dconf
    bash
  ];

  programs.git = {
    enable = true;
    userName = "mboyea";
    userEmail = "contact@mboyea.com";
    extraConfig = {
      push = {
        autoSetupRemote = true;
      };
      init = {
        defaultBranch = "main";
      };
    };
  };

  programs.gh = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".zsh";
    history.path = "$ZDOTDIR/.zsh_history";
    enableCompletion = true;
    oh-my-zsh = {
      enable = true;
      custom = "$ZDOTDIR/.oh-my-zsh/custom";
      theme = "robbyrussell-mboyea";
      extraConfig = ''${builtins.readFile ./zsh/zshrc}'';
    };
  };
  home.file.".zsh/.oh-my-zsh" = {
    source = ./zsh/oh-my-zsh;
    recursive = true;
  };
  home.shellAliases = {
    mdpdf = "$HOME/code/mdc/mdpdf.sh";
  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
    viAlias = true;
    # extraConfig = ''${builtins.readFile ./nvim/init.lua}'';
    # extraPackages = with pkgs; [
    #   # Svelte
    #   {
    #     plugin = pkgs.vimPlugins.vim-svelte;
    #     type = "lua";
    #     config = ''
    #       require("config.treesitter")
    #     '';
    #   }
    # ];
  };

  xdg = {
    enable = true;
    configFile = {
      # "i3" = {
      #   source = ./i3;
      #   recursive = true;
      # };
      "nvim" = {
        source = ./nvim;
        recursive = true;
      };
      "zathura" = {
        source = ./zathura;
        recursive = true;
      };
      "gtk-3.0" = {
        source = ./gtk-3.0;
        recursive = true;
      };
       # "alacritty" = {
       #   source = ./alacritty;
       #  recursive = true;
       # };
    };
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    BROWSER = "firefox";
    TERMINAL = "alacritty";
    VSCODE_EXTENSIONS="$XDG_DATA_HOME/code-oss/extensions";
    NIX_BUILD_SHELL = "zsh";
  };

  ## STYLE SETTINGS ##

  dconf = {
    enable = true;
    settings = {
      "org/gnome/desktop/interface" = {
        color-scheme = "prefer-dark";
      };
    };
  };

  ## NIXOS SETTINGS ##

  nix = {
    package = pkgs.nix;
    settings.use-xdg-base-directories = true;
    # experimental-features = "nix-command flakes";
  };

  programs.home-manager.enable = true;
  home = {
    username = "admin";
    homeDirectory = "/home/admin";
  };
  # do not modify the following
  home.stateVersion = "23.11";
}


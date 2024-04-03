{ config, lib, pkgs, inputs, ... }: {
  home.packages = with pkgs; [
    nerdfonts
    pango
    alacritty
    zsh
    oh-my-zsh
    firefox
    maim
    xclip
    pamixer
    pavucontrol
    brightnessctl
    playerctl
    pandoc
    texliveFull
    gnumake
  ];

  services.udiskie = {
    enable = true;
    notify = false;
  };

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

  xdg = {
    enable = true;
    configFile = {
      "i3" = {
        source = ./i3;
        recursive = true;
      };
      "nvim" = {
        source = ./nvim;
        recursive = true;
      };
    };
  };

  # do not modify the following
  programs.home-manager.enable = true;
  home = {
    username = "mboyea";
    homeDirectory = "/home/mboyea";
    stateVersion = "23.11";
  };
}


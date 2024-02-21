{ config, pkgs, ... }:

{
  nixpkgs.config = {
    allowUnfree = true;
  };
  home.username = "kodak";
  home.homeDirectory = "/home/kodak";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "22.11"; # Please read the comment before changing.
  
  home.packages = with pkgs; [
    emacs29
    neovim
    kate
    firefox
    ktorrent
    libreoffice-qt
    qalculate-qt
    neofetch
    nmap
    spotify
    vlc
    gimp
    imagemagickBig
    haruna
    chromium
    mc # midnight commander
    rpi-imager
    sops
    nerdfonts
    meslo-lgs-nf # for powerlevel10k
    zsh-powerlevel10k
    # zsh
    # oh-my-zsh
    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')

  ];
  programs.zsh = {
  enable = true;
  shellAliases = {
    ll = "ls -l";
    la = "ls -a";
    
  };
     oh-my-zsh = {
       enable = true;
       plugins = ["git"];
       theme = "robbyrussell";
     };
  };
  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/kodak/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };
}

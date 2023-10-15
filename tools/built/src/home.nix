{ config, pkgs, ... }:

{
  home.username = "builder";
  home.homeDirectory = "/home/builder";
  home.sessionVariables = { EDITOR = "vi"; };

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; [
    connect # for ssh proxy via tor
    openssh
    screen # terminal window manager
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;

    matchBlocks = {
      code = {
        user = "iphy";
        hostname = "code.tox.chat";
        port = 2299;
        extraOptions = {
          ProxyCommand = "connect -4 -S localhost:9050 $(tor-resolve %h localhost:9050) %p";
        };
      };
    };
  };

  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ jellybeans-vim vim-nix YouCompleteMe ];

    extraConfig = ''
      colorscheme jellybeans

      set nowrap
      set viminfo='500,\"800

      nnoremap <C-l> :noh<CR><C-l>
    '';
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    enableSyntaxHighlighting = true;

    initExtra = ''
      unsetopt beep                   # don't beep, ever
      setopt hist_reduce_blanks       # remove superfluous blanks
    '';

    shellAliases = {
      gs = "gst";
      ls = "ls -Fv --color=tty --group-directories-first --quoting-style=shell";
      l = "ls -l";
      ll = "ls -lah";
      hreb = "home-manager switch";
      vi = "nvim";
    };

    history = {
      size = 1000000;
      save = 1000000;
      ignoreDups = true;
      extended = true;
      share = true;
      path = "${config.xdg.dataHome}/zsh/history";
    };

    oh-my-zsh = {
      enable = true;
      plugins = [ "git" ];
      theme = "cypher";
    };
  };
}

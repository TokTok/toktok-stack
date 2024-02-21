{ config, pkgs, lib, ... }:

{
  home.username = "builder";
  home.homeDirectory = "/home/builder";
  home.sessionVariables = {
    EDITOR = "nvim";
    GITHUB_TOKEN =
      let tokenFile = "${config.home.homeDirectory}/.github-token"; in
      if builtins.pathExists tokenFile
        then lib.removeSuffix "\n" (builtins.readFile tokenFile)
        else "";

    ASAN_OPTIONS = "color=always:detect_leaks=1:strict_string_checks=1:check_initialization_order=1:strict_init_order=1";
    LSAN_OPTIONS = "report_objects=1";
    MSAN_OPTIONS = "color=always";
    TSAN_OPTIONS = "color=always,history_size=7,force_seq_cst_atomics=1";
    UBSAN_OPTIONS = "color=always,print_stacktrace=1";
  };
  home.sessionPath = [
    "${config.home.homeDirectory}/.bin"
    "/src/workspace/hs-github-tools/tools"
  ];

  # Packages that should be installed to the user profile.
  home.packages = with pkgs; if config.home.sessionVariables.GITHUB_TOKEN == "" then [] else [
    astyle                  # C code formatting
    bazel-watcher           # runs bazel test/build in a loop when files change
    clang-tools             # C++ code formatting
    connect                 # for ssh proxy via tor
    gdb                     # debugger for C code
    gnupg                   # for signing git commits
    go                      # for vscode to understand Go
    haskell-language-server # for vscode to understand Haskell
    ktfmt                   # Kotlin formatter
    man-pages               # libc documentation
    man-pages-posix         # libc documentation (POSIX functions)
    openssh                 # ssh server
    protobuf                # needed to build protobuf files in jvm-toxcore-c
    python3                 # needed for .hie-bios
    screen                  # terminal window manager
    strace                  # debugging system calls
    stylish-haskell         # formatter for Haskell
    tor                     # onion routing for privacy when testing tox inside the container
    xxd                     # hex viewer (to inspect dumps and tox saves)
  ];

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "23.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.ssh = {
    enable = true;

    controlMaster = "auto";
    controlPersist = "10m";

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
    plugins = with pkgs.vimPlugins; [
      jellybeans-vim
      kotlin-vim
      vim-bazel
      vim-nix
      YouCompleteMe
    ];

    extraConfig = ''
      colorscheme jellybeans

      set mouse=
      set expandtab
      set nowrap
      set viminfo='500,\"800
      set scrolloff=5
      set sidescrolloff=3
      set cursorline
      set backup
      set backupdir=~/.local/state/nvim/backup/
      set ts=4 sw=4  " tabs default to 4 spaces

      let g:ycm_extra_conf_globlist = ['/src/workspace/.ycm_extra_conf.py']

      nnoremap <C-l> :noh<CR><C-l>
      map Q gqap

      au BufEnter *.x,*.y set ts=8 sw=8 noexpandtab
      au BufEnter BUILD.* set ft=bzl
      au FileType sh,javascript set ts=2 sw=2
      au FileType go set noexpandtab
      " .lhs files need a long distance sync for highlighting
      au FileType lhaskell :au BufEnter * :syntax sync fromstart
      au FileType make :au BufEnter * :set ts=8 sw=8 noexpandtab
    '';
  };

  programs.zsh = {
    enable = true;
    autocd = true;
    syntaxHighlighting.enable = true;

    initExtra = ''
      unsetopt beep                   # don't beep, ever
      setopt hist_reduce_blanks       # remove superfluous blanks

      cd /src/workspace               # go to work
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

  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  services.vscode-server.enable = true;
}

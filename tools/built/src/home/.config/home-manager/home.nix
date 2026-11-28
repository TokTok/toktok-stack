{
  config,
  pkgs,
  lib,
  ...
}:

{
  imports = [
    "${fetchTarball "https://github.com/msteen/nixos-vscode-server/tarball/master"}/modules/vscode-server/home.nix"
  ];

  options.toktok.devTools.enable =
    lib.mkEnableOption "full TokTok developer toolchain (LSPs, formatters, debuggers)"
    // {
      default = true;
    };

  config = {
    nixpkgs.config.allowUnfree = true;

    home.username = "builder";
    home.homeDirectory = "/home/builder";
    i18n.glibcLocales = pkgs.glibcLocalesUtf8;
    home.sessionVariables = {
      EDITOR = "nvim";
      NIX_PATH = "${config.home.homeDirectory}/.nix-defexpr/channels:nixpkgs=${config.home.homeDirectory}/.nix-defexpr/nixpkgs";
      GITHUB_API_URL = "https://api.github.com";
      GITHUB_TOKEN =
        let
          tokenFile = "${config.home.homeDirectory}/.github-token";
        in
        if builtins.pathExists tokenFile then lib.removeSuffix "\n" (builtins.readFile tokenFile) else "";

      ASAN_OPTIONS = "color=always:detect_leaks=1:strict_string_checks=1:check_initialization_order=1:strict_init_order=1:external_symbolizer_path=${pkgs.rustc.llvmPackages.llvm}/bin/llvm-symbolizer";
      LSAN_OPTIONS = "report_objects=1";
      MSAN_OPTIONS = "color=always:external_symbolizer_path=${pkgs.rustc.llvmPackages.llvm}/bin/llvm-symbolizer";
      TSAN_OPTIONS = "color=always,history_size=7,force_seq_cst_atomics=1:external_symbolizer_path=${pkgs.rustc.llvmPackages.llvm}/bin/llvm-symbolizer";
      UBSAN_OPTIONS = "color=always,print_stacktrace=1:external_symbolizer_path=${pkgs.rustc.llvmPackages.llvm}/bin/llvm-symbolizer";

      QT_QPA_PLATFORM = "offscreen";
    };
    home.sessionPath = [
      "${config.home.homeDirectory}/.bin"
      "/src/workspace/hs-github-tools/tools"
    ];

    # Packages that should be installed to the user profile.
    home.packages =
      with pkgs;
      lib.optionals config.toktok.devTools.enable [
        astyle # C code formatting
        bazel-watcher # runs bazel test/build in a loop when files change
        rustc.llvmPackages.clang-tools # C++ code formatting (matches Clang 23 toolchain)
        connect # for ssh proxy via tor
        gdb # debugger for C code
        github-cli # utilities for dealing with GitHub repos
        gnupg # for signing git commits
        go # for vscode to understand Go
        haskell-language-server # for vscode to understand Haskell
        ktfmt # Kotlin formatter
        man-pages # libc documentation
        man-pages-posix # libc documentation (POSIX functions)
        netlify-cli # to perform local test deploys
        nsis # Windows installer creation
        prettier # formatting JSON and JavaScript files
        openssh # ssh server
        protobuf # needed to build protobuf files in jvm-toxcore-c
        # needed for .hie-bios
        (python3.withPackages (
          ps: with ps; [
            cython
            requests
            types-requests
          ]
        ))
        rsync # for syncing files to the container
        screen # terminal window manager
        strace # debugging system calls
        stylish-haskell # formatter for Haskell
        tor # onion routing for privacy when testing tox inside the container
        xxd # hex viewer (to inspect dumps and tox saves)
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
      enableDefaultConfig = false;

      settings = {
        "*" = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/master-%r@%n:%p";
          ControlPersist = "10m";
        };

        code = {
          User = "iphy";
          HostName = "code.tox.chat";
          Port = 2299;
          ProxyCommand = "connect -4 -S localhost:9050 $(tor-resolve %h localhost:9050) %p";
        };
      };
    };

    programs.neovim = {
      enable = true;
      withPython3 = true;
      withRuby = false;
      plugins = with pkgs.vimPlugins; [
        jellybeans-vim
        kotlin-vim
        vim-bazel
        vim-nix
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

        nnoremap <C-l> :noh<CR><C-l>
        map Q gqap

        au BufEnter *.x,*.y set ts=8 sw=8 noexpandtab
        au BufEnter BUILD.*,*.BUILD set ft=bzl
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

      initContent = ''
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

    services.vscode-server.enable = true;
  };
}

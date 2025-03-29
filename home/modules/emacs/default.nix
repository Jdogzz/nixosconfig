{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = with pkgs; [
    #Doom emacs dependencies https://github.com/doomemacs/doomemacs?tab=readme-ov-file#prerequisites
    fd
    findutils
    git
    ripgrep

    #Grammar check
    languagetool

    #Programming
    black
    cmake
    html-tidy
    nil
    nixfmt-rfc-style
    nodePackages.prettier
    shellcheck
    shfmt

    #Spelling check
    (aspellWithDicts (
      dicts: with dicts; [
        en
        en-computers
        en-science
        es
      ]
    ))

    #Tools
    ghostscript # Adding for DocView previewing
    #libtool # Adding for vterm compilation #2025-03-20 Testing whether still needed
    mupdf # Adding for DocView previewing
    unoconv # Adding for DocView Office document previewing
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: [
      #epkgs.vterm #2025-03-08 Disabling for broken build.
      epkgs.mu4e
    ];
  };
}

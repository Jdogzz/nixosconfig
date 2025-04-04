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
    cmake
    html-tidy
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
    mupdf # Adding for DocView previewing
    unoconv # Adding for DocView Office document previewing
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs30-pgtk;
    extraPackages = epkgs: [
      epkgs.mu4e
    ];
  };

  imports = [
    ./modules
  ];
}

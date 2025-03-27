{
  config,
  lib,
  pkgs,
  ...
}:

{
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      figlet Time to | dotacat
      figlet GTD | dotacat
    '';
    plugins = [
      {
        name = "autopair";
        src = pkgs.fishPlugins.grc.src;
      }
      {
        name = "done";
        src = pkgs.fishPlugins.done.src;
      }
      {
        name = "forgit";
        src = pkgs.fishPlugins.forgit.src;
      }
      {
        name = "fzf-fish";
        src = pkgs.fishPlugins.fzf-fish.src;
      }
      {
        name = "hydro";
        src = pkgs.fishPlugins.hydro.src;
      }
      {
        name = "pisces";
        src = pkgs.fishPlugins.pisces.src;
      }
    ];
    functions = {
      vterm_printf = {
        body = ''
          if begin; [  -n "$TMUX" ]  ; and  string match -q -r "screen|tmux" "$TERM"; end
              # tell tmux to pass the escape sequences through
              printf "\ePtmux;\e\e]%s\007\e\\" "$argv"
          else if string match -q -- "screen*" "$TERM"
              # GNU screen (screen, screen-256color, screen-256color-bce)
              printf "\eP\e]%s\007\e\\" "$argv"
          else
              printf "\e]%s\e\\" "$argv"
          end
        '';
      };
    };
    shellAbbrs = {
      qrs = "rsync -achvP --mkpath ";
    };
    shellAliases = {
      winvmlaunch = "quickemu --vm windows-11.conf --display spice --public-dir ~/generalsync/inbox/Public/";
      browservmlaunch = "quickemu --vm ubuntu-24.10.conf --display spice --public-dir ~/generalsync/inbox/Public/";
      zmzm = "QT_SCALE_FACTOR=0.5 zoom";
      ppngxlaunch = "systemctl start redis-paperless.service system-paperless.slice paperless-scheduler.service gotenberg.service tika.service";
      ppngxstop = "systemctl stop system-paperless.slice redis-paperless.service gotenberg.service tika.service";
      taildown = "sudo tailscale down";
      tailup = "sudo tailscale up --accept-routes";
    };
    shellInit = ''
      set fish_greeting
    '';
  };

}

{
  pkgs,
  config,
  inputs,
  ...
}: {
  wayland.windowManager.hyprland = {
    enable = true;
    systemd = {
      enable = true;
      variables = ["-all"];
    };
    settings = {
      "$ipc" = "noctalia-shell ipc call";
      "$mod" = "SUPER";

      monitor = [
        "eDP-1,preferred,auto,1.2"
        "DP-3,1920x1080@320,auto,1"
      ];

      xwayland = {
        force_zero_scaling = true;
      };

      exec-once = [
        "noctalia-shell --no-duplicate"
        "hyprctl setcursor breeze_cursors 24"
      ];
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
      ];

      general = {
        gaps_in = 5;
        gaps_out = 10;

        border_size = 1;

        "col.active_border" = "$base";
        "col.inactive_border" = "$base";

        layout = "master";
      };

      decoration = {
        rounding = 10;
        rounding_power = 2;

        shadow.enabled = true;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
        };
      };

      animations = {
        enabled = true;
        bezier = [
          "easeOutQuint, 0.23, 1, 0.32, 1"
          "easeInOutCubic, 0.65, 0.05, 0.36, 1"
          "linear, 0, 0, 1, 1"
          "almostLinear, 0.5, 0.5, 0.75, 1"
          "quick, 0.15, 0, 0.1, 1"
        ];
        animation = [
          "global, 1, 10, default"
          "border, 1, 5.39, easeOutQuint"
          "windows, 1, 4.79, easeOutQuint"
          "windowsIn, 1, 4.1, easeOutQuint, popin 87%"
          "windowsOut, 1, 1.49, linear, popin 87%"
          "fadeIn, 1, 1.73, almostLinear"
          "fadeOut, 1, 1.46, almostLinear"
          "fade, 1, 3.03, quick"
          "layers, 1, 3.81, easeOutQuint"
          "layersIn, 1, 4, easeOutQuint, fade"
          "layersOut, 1, 1.5, linear, fade"
          "fadeLayersIn, 1, 1.79, almostLinear"
          "fadeLayersOut, 1, 1.39, almostLinear"
          "workspaces, 1, 1.94, almostLinear, fade"
          "workspacesIn, 1, 1.21, almostLinear, fade"
          "workspacesOut, 1, 1.94, almostLinear, fade"
          "zoomFactor, 1, 7, quick"
        ];
      };

      master = {
        new_status = "master";
      };

      misc = {
        disable_hyprland_logo = true;
        disable_splash_rendering = true;
      };

      input = {
        kb_layout = "us, il";
        kb_options = "grp:alt_shift_toggle";

        follow_mouse = 1;
        accel_profile = "flat";
        sensitivity = 0; # -1.0 - 1.0, 0 means no modification.

        touchpad = {
          natural_scroll = false;
        };
      };

      gesture = "3, horizontal, workspace";

      bind =
        [
          "$mod, R, exec, $ipc launcher toggle"
          "$mod SHIFT, V, exec, $ipc launcher clipboard"
          "$mod, SPACE, exec, $ipc controlCenter toggle"
          "$mod, Q, exec, kitty"
          "$mod, C, killactive"
          "$mod, E, exec, thunar"

          "$mod, 0, workspace, 10"
          "$mod SHIFT, 0, movetoworkspace, 10"
          "$mod, mouse_down, workspace, e+1"
          "$mod, mouse_up, workspace, e-1"
          "$mod, S, togglespecialworkspace, magic"
          "$mod SHIFT, S, movetoworkspace, special:magic"
          "$mod, V, togglefloating"
          "$mod, P, pin"

          # take screenshot - prntscrn or super-shift-p
          ", Print, exec, grim -g \"$(slurp -d)\" - | wl-copy"
          "$mod SHIFT, P, exec, grim -g \"$(slurp -d)\" - | wl-copy"

          # deafen discord
          ", F7, exec, equibop --toggle-deafen"
        ]
        ++ (
          # workspaces
          # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
          builtins.concatLists (
            builtins.genList (
              i: let
                ws = i + 1;
              in [
                "$mod, code:1${toString i}, workspace, ${toString ws}"
                "$mod SHIFT, code:1${toString i}, movetoworkspace, ${toString ws}"
              ]
            )
            9
          )
        );

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindel = [
        ", XF86AudioRaiseVolume, exec, $ipc volume increase"
        ", XF86AudioLowerVolume, exec, $ipc volume decrease"
        ", XF86MonBrightnessUp, exec, $ipc brightness increase"
        ", XF86MonBrightnessDown, exec, $ipc brightness decrease"
      ];

      bindl = [
        ", XF86AudioMute, exec, $ipc volume muteOutput"
        ", XF86AudioMicMute, exec, $ipc volume muteInput"
        ", XF86AudioNext, exec, playerctl next"
        ", XF86AudioPause, exec, playerctl play-pause"
        ", XF86AudioPlay, exec, playerctl play-pause"
        ", XF86AudioPrev, exec, playerctl previous"
      ];

      windowrule = [
        {
          name = "suppress-maximize-events";
          "match:class" = ".*";

          suppress_event = "maximize";
        }
        {
          name = "fix-xwayland-drags";
          "match:class" = "^$";
          "match:title" = "^$";
          "match:xwayland" = true;
          "match:float" = true;
          "match:fullscreen" = false;
          "match:pin" = false;

          no_focus = true;
        }
        {
          name = "move-hyprland-run";
          "match:class" = "hyprland-run";

          move = "20 monitor_h-120";
          float = "yes";
        }
      ];
    };
  };
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
  };
  catppuccin.hyprland.enable = true;
  home.packages = with pkgs; [
    # Terminals
    xterm
    termius

    # Shell
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default

    # Themes
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
    kdePackages.breeze.qt5
    kdePackages.breeze

    # Screenshot utilities
    grim
    slurp

    libnotify

    wl-clipboard
    cliphist

    fastfetch

    pwvucontrol

    vlc
  ];
}

{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    lutris

    mangohud

    (prismlauncher.override {
      additionalLibs = with pkgs; [
        alsa-lib
        atk
        at-spi2-atk
        cairo
        cups
        dbus
        expat
        glib
        gtk3
        libdrm
        libgbm
        libxkbcommon
        mesa
        nspr
        nss
        pango
        libX11
        libXcomposite
        libXdamage
        libXext
        libXfixes
        libXi
        libXrandr
        libXrender
        libXScrnSaver
        libXtst
        libxcb
        libxshmfence
      ];
    })

    osu-lazer-bin

    (heroic.override {
      extraPkgs = pkgs':
        with pkgs'; [
          gamemode
        ];
    })
    dolphin-emu
  ];
}

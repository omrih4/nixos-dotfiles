{
  inputs,
  config,
  pkgs,
  ...
}:

let
  geode-cli = pkgs.rustPlatform.buildRustPackage {
    pname = "geode-cli";
    version = "3.7.1";

    src = pkgs.fetchFromGitHub {
      owner = "geode-sdk";
      repo = "cli";
      rev = "f75ee37472a50ab469fed937c41252b634e67627";
			hash = "sha256-1weuW94259dkMhvhzryuO6Pt8XFtfHBtL8KlpxUwRAc=";
    };

		cargoHash = "sha256-VeKXoCHPwtnCxds7PDIJmjTfun6qs/Od1NkaVgTtOxc=";

    nativeBuildInputs =
      with pkgs;
      [
        pkg-config
        openssl
      ];

    buildInputs =
      with pkgs;
      [
        openssl
      ];

    postInstall = ''
      mkdir -p $out/share/bash-completion/completions
      mkdir -p $out/share/zsh/site-functions
      mkdir -p $out/share/fish/vendor_completions.d

      $out/bin/geode completions bash > $out/share/bash-completion/completions/geode
      $out/bin/geode completions zsh > $out/share/zsh/site-functions/_geode
      $out/bin/geode completions fish > $out/share/fish/vendor_completions.d/geode.fish
    '';
  };
in
{
  home.username = "omrih";
  home.homeDirectory = "/home/omrih";
  home.stateVersion = "25.11";
  programs.bash = {
    enable = true;
    shellAliases = {
      btw = "echo i use nix btw";
      nixos-switch = "sudo nixos-rebuild switch --flake /home/omrih/nixos-dotfiles#laptop";
    };
    profileExtra = ''
			export CPM_SOURCE_CACHE="/home/omrih/.cache/cpm"
			export GEODE_SDK="/home/omrih/Documents/geode"

			start-hyprland
      		'';
  };
  home.packages = with pkgs; [
    geode-cli
    vesktop
    prismlauncher
    jetbrains.idea-oss
    inputs.helium.packages.x86_64-linux.default
    zoom-us
    seahorse
  ];
  programs.obs-studio = {
    enable = true;

    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
  };
  programs.vscode = {
    enable = true;
    package = pkgs.vscode.fhsWithPackages (
      ps: with ps; [
        clang
        clang-tools
	llvm
	lld
        cmake
        nixfmt-rfc-style
        nixd
	ninja
      ]
    );
  };
  home.file.".config/hypr".source = ./config/hypr;
  home.file.".config/waybar".source = ./config/waybar;
}

{
  description = "Library and command-line client for sending email";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-utils.url = "github:numtide/flake-utils";
    myl-discovery = {
      url = "github:pschmitt/myl-discovery";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      nixpkgs,
      flake-utils,
      myl-discovery,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = nixpkgs.legacyPackages.${system};

        sendmyl = pkgs.python3Packages.buildPythonApplication {
          pname = "sendmyl";
          version = builtins.readFile ./sendmyl-version.txt;
          pyproject = true;

          src = ./.;

          pythonRelaxDeps = [ "rich" ];

          buildInputs = [
            pkgs.python3Packages.setuptools
            pkgs.python3Packages.setuptools-scm
          ];

          propagatedBuildInputs = with pkgs.python3Packages; [
            myl-discovery.packages.${system}.myl-discovery
            rich
            rich-argparse
          ];

          meta = {
            description = "Command-line client for sending email";
            homepage = "https://github.com/pschmitt/sendmyl";
            license = pkgs.lib.licenses.gpl3Only;
            maintainers = with pkgs.lib.maintainers; [ pschmitt ];
            mainProgram = "sendmyl";
          };
        };

        devShell = pkgs.mkShell {
          name = "sendmyl-devshell";

          inputsFrom = [ sendmyl ];

          nativeBuildInputs = [
            pkgs.gh # GitHub CLI
            pkgs.git
            pkgs.python3Packages.ipython
            pkgs.neovim
          ];

          shellHook = ''
            export PYTHONPATH="$PWD''${PYTHONPATH:+:$PYTHONPATH}"
            echo -e "\e[34mWelcome to the sendmyl development shell!\e[0m"
          '';
        };
      in
      {
        packages = {
          inherit sendmyl;
          default = sendmyl;
        };

        devShells.default = devShell;
      }
    );
}

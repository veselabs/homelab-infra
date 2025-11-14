{
  description = "homelab-infra";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    flake-parts.url = "github:hercules-ci/flake-parts/main";
    treefmt-nix.url = "github:numtide/treefmt-nix/main";
    devenv.url = "github:cachix/devenv/v1.9";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} ({self, ...}: {
      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];

      perSystem = {
        pkgs,
        self',
        system,
        ...
      }: let
        treefmtEval = inputs.treefmt-nix.lib.evalModule pkgs {
          projectRootFile = "flake.nix";

          programs = {
            alejandra.enable = true;
            packer.enable = true;
            prettier.enable = true;
            shfmt.enable = true;
            terraform.enable = true;
            terraform.package = pkgs.terraform;
          };
        };
      in {
        devShells.default = inputs.devenv.lib.mkShell {
          inherit inputs pkgs;

          modules = [
            {
              env = {
                AWS_ACCESS_KEY_ID = "op://veselabs/AWS Root Access Key/username";
                AWS_SECRET_ACCESS_KEY = "op://veselabs/AWS Root Access Key/credential";
                PM_API_URL = "op://veselabs/proxmox root pam/url";
                PM_PASS = "op://veselabs/proxmox root pam/password";
                PM_USER = "op://veselabs/proxmox root pam/username";
                PROXMOX_PASSWORD = "op://veselabs/proxmox root pam/password";
                PROXMOX_URL = "op://veselabs/proxmox root pam/url";
                PROXMOX_USERNAME = "op://veselabs/proxmox root pam/username";
                PVE_TAILNET_KEY = "op://veselabs/homelab pve tailnet key/password";
                TAILSCALE_OAUTH_CLIENT_ID = "op://veselabs/tailscale oauth credentials/username";
                TAILSCALE_OAUTH_CLIENT_SECRET = "op://veselabs/tailscale oauth credentials/credential";
                TF_VAR_op_service_account_token = "op://veselabs/service account auth token/credential";
                TF_VAR_op_vault = "op://veselabs/service account auth token/username";
              };

              languages = {
                ansible.enable = true;
                nix.enable = true;
                shell.enable = true;
                terraform.enable = true;
              };

              packages =
                [
                  self'.formatter
                ]
                ++ builtins.attrValues {
                  inherit
                    (pkgs)
                    awscli2
                    just
                    packer
                    terraform-docs
                    ;
                };

              git-hooks.hooks = {
                ansible-lint.enable = true;
                deadnix.enable = true;
                end-of-file-fixer.enable = true;
                shellcheck.enable = true;
                statix.enable = true;
                terraform-docs = {
                  enable = true;
                  entry = "just check-docs";
                  files = "\\.tf$";
                  pass_filenames = false;
                };
                tflint.enable = true;
                treefmt.enable = true;
                treefmt.package = self'.formatter;
                trim-trailing-whitespace.enable = true;
              };
            }
          ];
        };

        packages = {
          devenv-test = self'.devShells.default.config.test;
          devenv-up = self'.devShells.default.config.procfileScript;
        };

        formatter = treefmtEval.config.build.wrapper;
        checks.formatting = treefmtEval.config.build.check self;

        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      };
    });
}

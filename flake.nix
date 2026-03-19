{
  description = "homelab-infra";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    flake-parts.url = "github:hercules-ci/flake-parts/main";
    devenv.url = "github:cachix/devenv/v2.0.5";
    treefmt-nix.url = "github:numtide/treefmt-nix/main";
    treefmt-nix.inputs.nixpkgs.follows = "nixpkgs";
    git-hooks.url = "github:cachix/git-hooks.nix/master";
    git-hooks.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs @ {flake-parts, ...}:
    flake-parts.lib.mkFlake {inherit inputs;} {
      systems = ["aarch64-darwin" "aarch64-linux" "x86_64-darwin" "x86_64-linux"];

      perSystem = {
        pkgs,
        system,
        ...
      }: {
        devShells.default = inputs.devenv.lib.mkShell {
          inherit inputs pkgs;

          modules = [
            {
              env = {
                CLOUDFLARE_ACCESS_KEY_ID = "op://veselabs/cloudflare api token/access_key_id";
                CLOUDFLARE_ACCOUNT_ID = "op://veselabs/cloudflare api token/account_id";
                CLOUDFLARE_API_TOKEN = "op://veselabs/cloudflare api token/credential";
                CLOUDFLARE_SECRET_ACCESS_KEY = "op://veselabs/cloudflare api token/secret_access_key";
                PROXMOX_PASSWORD = "op://veselabs/proxmox root pam/password";
                PROXMOX_URL = "op://veselabs/proxmox root pam/url";
                PROXMOX_USERNAME = "op://veselabs/proxmox root pam/username";
                PROXMOX_VE_ENDPOINT = "op://veselabs/proxmox root pam/url";
                PROXMOX_VE_PASSWORD = "op://veselabs/proxmox root pam/password";
                PROXMOX_VE_USERNAME = "op://veselabs/proxmox root pam/username";
                PVE_TAILNET_KEY = "op://veselabs/homelab pve tailnet key/password";
                TAILSCALE_OAUTH_CLIENT_ID = "op://veselabs/tailscale oauth credentials/username";
                TAILSCALE_OAUTH_CLIENT_SECRET = "op://veselabs/tailscale oauth credentials/credential";
                TF_VAR_cloudflare_account_id = "op://veselabs/cloudflare api token/account_id";
                TF_VAR_cloudflare_zone_id = "op://veselabs/cloudflare api token/zone_id";
                TF_VAR_op_service_account_token = "op://veselabs/service account auth token/credential";
                TF_VAR_op_vault = "op://veselabs/service account auth token/username";
              };

              languages = {
                ansible.enable = true;
                nix.enable = true;
                shell.enable = true;
                terraform.enable = true;
                terraform.package = pkgs.terraform;
              };

              packages = builtins.attrValues {
                inherit
                  (pkgs)
                  _1password-cli
                  envsubst
                  just
                  packer
                  pre-commit
                  sshpass
                  terraform-docs
                  ;
                inherit
                  (pkgs.python3Packages)
                  proxmoxer
                  ;
              };

              treefmt = {
                enable = true;
                config = {
                  programs = {
                    alejandra.enable = true;
                    packer.enable = true;
                    prettier.enable = true;
                    shfmt.enable = true;
                    terraform.enable = true;
                    terraform.package = pkgs.terraform;
                  };
                };
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
                terraform-validate.enable = true;
                terraform-validate.package = pkgs.terraform;
                tflint.enable = true;
                treefmt.enable = true;
                trim-trailing-whitespace.enable = true;
                yamllint.enable = true;
              };

              tasks = {
                "ansible:install" = {
                  exec = "ansible-galaxy install --role-file ./config/requirements.yml";
                  before = ["devenv:git-hooks:run"];
                };
              };
            }
          ];
        };

        _module.args.pkgs = import inputs.nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      };
    };
}

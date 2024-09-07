# To learn more about how to use Nix to configure your environment
# see: https://developers.google.com/idx/guides/customize-idx-env
{ pkgs, ... }: {
  # Which nixpkgs channel to use.
  channel = "stable-23.11"; # or "unstable"

  # Use https://search.nixos.org/packages to find packages
  packages = [
    pkgs.python312Packages.uvicorn
    pkgs.python312Packages.pip
    pkgs.gh
    pkgs.python3
    pkgs.yarn2nix
    pkgs.nodejs_20
  ];

  # Sets environment variables in the workspace
  env = {};
  idx = {
    # Search for the extensions you want on https://open-vsx.org/ and use "publisher.id"
    extensions = [
      # "vscodevim.vim"
      "alexcvzz.vscode-sqlite"
      "bierner.color-info"
      "bierner.docs-view"
      "bierner.emojisense"
      "bierner.markdown-mermaid"
      "bierner.markdown-preview-github-styles"
      "christian-kohler.path-intellisense"
      "DavidAnson.vscode-markdownlint"
      "dbaeumer.vscode-eslint"
      "DotJoshJohnson.xml"
      "dsznajder.es7-react-js-snippets"
      "ecmel.vscode-html-css"
      "edwinhuish.better-comments-next"
      "EdwinKofler.vscode-hyperupcall-pack-base"
      "EdwinKofler.vscode-hyperupcall-pack-markdown"
      "esbenp.prettier-vscode"
      "formulahendry.auto-close-tag"
      "formulahendry.auto-complete-tag"
      "formulahendry.auto-rename-tag"
      "jeff-hykin.macro-commander"
      "ms-azuretools.vscode-docker"
      "ms-toolsai.jupyter"
      "ms-toolsai.jupyter-keymap"
      "ms-toolsai.jupyter-renderers"
      "ms-toolsai.vscode-jupyter-cell-tags"
      "ms-toolsai.vscode-jupyter-slideshow"
      "ms-vscode.vscode-typescript-next"
      "naumovs.color-highlight"
      "PulkitGangwar.nextjs-app-directory-commands"
      "PulkitGangwar.nextjs-snippets"
      "redhat.vscode-xml"
      "redhat.vscode-yaml"
      "ritwickdey.LiveServer"
      "streetsidesoftware.code-spell-checker"
      "tamasfe.even-better-toml"
      "Tomi.xasnippets"
      "unifiedjs.vscode-mdx"
      "usernamehw.errorlens"
      "waderyan.gitblame"
      "ygqygq2.turbo-print-log"
      "YoavBls.pretty-ts-errors"
      "yzhang.markdown-all-in-one"
    ];

    # Enable previews
    previews = {
      enable = true;
      previews = {
        enable = true;
      previews = {
        web = {
          command = ["./devserver.sh"];
          env = {
            PORT = "$PORT";
          };
          manager = "web";
        };
      };
        # web = {
        #   # Example: run "npm run dev" with PORT set to IDX's defined port for previews,
        #   # and show it in IDX's web preview panel
        #   command = ["npm" "run" "dev"];
        #   manager = "web";
        #   env = {
        #     # Environment variables to set for your server
        #     PORT = "$PORT";
        #   };
        # };
      };
    };

    # Workspace lifecycle hooks
    workspace = {
      # Runs when a workspace is first created
      onCreate = {
        create-venv = ''
          python -m venv my_ai_env
          source my_ai_env/bin/activate
          pip install -r requirements.txt
        '';

        # Install Node.js dependencies for Next.js
        install-node-deps = ''
        cd gen-x && yarn install
        '';
        # Example: install JS dependencies from NPM
        # npm-install = "npm install";
      };
      # Runs when the workspace is (re)started
      onStart = {
        activate-venv = ''
          source my_ai_env/bin/activate
        '';
        # Start the backend and frontend servers concurrently
        start-servers = ''
          ./devserver.sh
        '';
        # Example: start a background task to watch and re-build backend code
        # watch-backend = "npm run watch-backend";
      };
    };
  };
}

{ pkgs, ... }: {
  # Specify the nixpkgs channel to use
  channel = "stable-23.11"; # or "unstable"

  # Define the required packages for the environment
  packages = [
    pkgs.gh
    pkgs.yarn
    pkgs.nodejs_20
    # pkgs.python3Full    # Python 3 interpreter
    # pkgs.python311Packages.uvicorn
    # pkgs.python311Packages.pip # pip for Python package management
  ];

  # Set environment variables for the workspace
  env = {};

  idx = {
    # List of extensions to use in the development environment
    extensions = [
      # "ms-toolsai.jupyter"
      # "ms-python.python"   # Python extension for VS Code
      # "esbenp.prettier-vscode" # Prettier extension for JavaScript/TypeScript formatting
    ];

    workspace = {
      # Runs when a workspace is first created with this `dev.nix` file
      onCreate = {
        # Create a Python virtual environment and install backend dependencies
        create-venv = ''
          python -m venv my_ai_env
          source my_ai_env/bin/activate
          pip install -r requirements.txt
        '';

        # Install Node.js dependencies for Next.js
        install-node-deps = ''
          yarn install
        '';
      };
      
    

      # To run something each time the workspace is (re)started, use the `onStart` hook
      onStart = {
        # Create a Python virtual environment and install backend dependencies
        create-venv = ''
          python -m venv my_ai_env
          source my_ai_env/bin/activate
          pip install -r requirements.txt
        '';

        # Install Node.js dependencies for Next.js
        install-node-deps = ''
          yarn install
        '';
        # Activate the Python virtual environment
        activate-venv = ''
          source my_ai_env/bin/activate
        '';
        # Start the backend and frontend servers concurrently
        start-servers = ''
          ./devserver.sh
        '';
      };
    };

    # Enable previews and customize configuration
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
    };
  };
}

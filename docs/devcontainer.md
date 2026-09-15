# Developing inside the container with VS Code

VS Code's Dev Containers extension can open the project inside the Docker container described in [docker.md](docker.md). The editor, terminal, run button and debugger then all use the container's Python and SymPy.

## Configuration

The configuration is in `.devcontainer/devcontainer.json`:

| Setting | What it does |
|---------|--------------|
| `dockerComposeFile`, `service` | Uses the existing `docker-compose.yaml` and its `python` service, so it's the same container as on the command line. |
| `workspaceFolder` | Opens the project at `/app` inside the container. Edits are saved to your machine. |
| `overrideCommand` | Replaces the default Python prompt with a command that keeps the container running while VS Code is connected. |
| `extensions` | Installs the Python and Pylance extensions inside the container. |
| `python.defaultInterpreterPath` | Points VS Code at the container's Python (`/usr/local/bin/python`). |

## Requirements

- Docker Desktop, running.
- VS Code with the **Dev Containers** extension (`ms-vscode-remote.remote-containers`).

## Opening the project in the container

1. Open the project folder in VS Code.
2. Open the Command Palette (`Cmd+Shift+P` on macOS, `Ctrl+Shift+P` on Windows/Linux).
3. Run **Dev Containers: Reopen in Container**.

The first time, VS Code builds the image and installs the extensions, which takes a few minutes. When it's done, the bottom-left corner shows **Dev Container: AdvRobot Python**.

## Running code

- **Terminal:** new terminals open inside the container, so `python my_script.py` works directly.
- **Run button:** the ▶ button on a `.py` file uses the container's Python.
- **Debugging:** press `F5` and choose **Python File**.

## Changing the container

After editing the `Dockerfile` (for example, to add packages) or `.devcontainer/devcontainer.json`, run **Dev Containers: Rebuild Container** from the Command Palette.

## Leaving the container

Run **Dev Containers: Reopen Folder Locally** to go back to working on your machine.

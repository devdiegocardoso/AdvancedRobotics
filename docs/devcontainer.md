# Developing inside the container with VS Code

VS Code's Dev Containers extension can open the project inside the Docker container described in [docker.md](docker.md). The editor, terminal, run button, debugger and notebooks then all use the container's Python and packages (SymPy, NumPy, Matplotlib and JupyterLab).

## Configuration

The configuration is in `.devcontainer/devcontainer.json`:

| Setting | What it does |
|---------|--------------|
| `dockerComposeFile`, `service` | Uses the existing `docker-compose.yaml` and its `python` service, so it's the same container as on the command line. |
| `workspaceFolder` | Opens the project at `/app` inside the container. Edits are saved to your machine. |
| `overrideCommand` | Replaces the default command (starting JupyterLab) with one that keeps the container running while VS Code is connected. |
| `extensions` | Installs the Python, Pylance and Jupyter extensions inside the container. |
| `python.defaultInterpreterPath` | Points VS Code at the container's Python (`/usr/local/bin/python`). |

## Requirements

- Docker Desktop, running.
- VS Code with the **Dev Containers** extension (`ms-vscode-remote.remote-containers`).
- Port 8890 free. If JupyterLab is already running from `docker compose up`, stop it with `docker compose down` first.

## Opening the project in the container

1. Open the project folder in VS Code.
2. Open the Command Palette (`Cmd+Shift+P` on macOS, `Ctrl+Shift+P` on Windows/Linux).
3. Run **Dev Containers: Reopen in Container**.

The first time, VS Code builds the image and installs the extensions, which takes a few minutes. When it's done, the bottom-left corner shows **Dev Container: AdvRobot Python**.

## Running code

- **Terminal:** new terminals open inside the container, so `python my_script.py` works directly.
- **Run button:** the ▶ button on a `.py` file uses the container's Python.
- **Debugging:** press `F5` and choose **Python File**.

## Notebooks

There are two ways to work with notebooks.

**In VS Code:** open or create a `.ipynb` file. Click **Select Kernel** in the top-right corner, choose **Python Environments**, then `/usr/local/bin/python`. Cells run inside the container, and plots and SymPy math appear below the cell.

**In JupyterLab in the browser:** the container doesn't start JupyterLab by itself when VS Code opens it. Start it from a VS Code terminal:

```bash
jupyter lab --ip=0.0.0.0 --port=8890 --no-browser --allow-root
```

Open the `http://127.0.0.1:8890/lab?token=...` link from the output in your browser. Press `Ctrl+C` in the terminal to stop it.

## Changing the container

After editing the `Dockerfile` (for example, to add packages) or `.devcontainer/devcontainer.json`, run **Dev Containers: Rebuild Container** from the Command Palette.

## Leaving the container

Run **Dev Containers: Reopen Folder Locally** to go back to working on your machine.

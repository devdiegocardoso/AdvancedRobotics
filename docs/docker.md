# Running Python with Docker

The project has a Docker image with Python 3.12 and these packages installed:

- [SymPy](https://www.sympy.org/)
- [NumPy](https://numpy.org/)
- [Matplotlib](https://matplotlib.org/)
- [JupyterLab](https://jupyter.org/)

## Files

| File | Purpose |
|------|---------|
| `Dockerfile` | Starts from `python:3.12-slim` and installs SymPy, NumPy, Matplotlib and JupyterLab with pip. By default the container starts JupyterLab on port 8890. |
| `docker-compose.yaml` | Builds the image (`advrobot-python`), makes the project folder available inside the container at `/app`, and makes port 8890 reachable at `localhost:8890`. |

Because the project folder is mounted at `/app`, your notebooks and scripts are available inside the container, and any files the container writes there are saved to your machine.

JupyterLab uses port 8890 instead of its usual 8888, so this project can run at the same time as AdvDeLearn (8888) and CompVis (8889).

## Requirements

- Docker Desktop, running.

## Usage

Run these commands from the project root.

Build the image (the first time, and again after changing the `Dockerfile`):

```bash
docker compose build
```

### JupyterLab

Start JupyterLab:

```bash
docker compose up
```

The output contains a link like this one:

```
http://127.0.0.1:8890/lab?token=...
```

Open it in your browser. The token in the link logs you in, and it changes every time JupyterLab starts. Notebooks you create are saved in the project folder.

To stop JupyterLab, press `Ctrl+C` in the terminal, then run `docker compose down` to remove the container.

Port 8890 is only reachable from your own machine (`127.0.0.1`), not from other devices on your network.

### Python prompt and scripts

Open an interactive Python prompt:

```bash
docker compose run --rm python python
```

Run a script from the project folder:

```bash
docker compose run --rm python python my_script.py
```

Check that the packages are installed:

```bash
docker compose run --rm python python -c "import sympy, numpy, matplotlib, jupyterlab; print(sympy.__version__, numpy.__version__, matplotlib.__version__, jupyterlab.__version__)"
```

`--rm` removes the container when it exits, so stopped containers don't pile up.

## Showing plots and equations

**In notebooks**, plots appear below the cell as usual, and SymPy expressions are displayed as formatted math:

```python
import sympy as sp
import numpy as np
import matplotlib.pyplot as plt

theta = sp.symbols("theta")
sp.init_printing()
sp.Matrix([[sp.cos(theta), -sp.sin(theta)], [sp.sin(theta), sp.cos(theta)]])
```

```python
t = np.linspace(0, 2 * np.pi, 100)
plt.plot(t, np.sin(t))
plt.show()
```

**In scripts**, the container has no display, so `plt.show()` can't open a window. Save figures to a file instead. The file appears in the project folder on your machine:

```python
plt.savefig("output.png")
```

## Adding packages

Add them to the `pip install` line in the `Dockerfile`:

```dockerfile
RUN pip install --no-cache-dir sympy numpy matplotlib jupyterlab scipy
```

Then rebuild with `docker compose build`.

## Troubleshooting

**`Cannot connect to the Docker daemon`**: Docker Desktop isn't running. Start it and try again.

**`Bind for 127.0.0.1:8890 failed: port is already allocated`**: something else is using port 8890. It may be this project's JupyterLab or Dev Container already running. Stop it with `docker compose down`, or pick another port: change `8890` in both the `Dockerfile` and `docker-compose.yaml`, then rebuild.

**The link says "Invalid credentials"**: the token is out of date. Copy the latest link from the `docker compose up` output.

To use the container from VS Code instead of the terminal, see [devcontainer.md](devcontainer.md).

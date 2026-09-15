# Running Python with Docker

The project has a Docker image with Python 3.12 and [SymPy](https://www.sympy.org/) installed.

## Files

| File | Purpose |
|------|---------|
| `Dockerfile` | Starts from `python:3.12-slim` and installs SymPy with pip. By default the container opens a Python prompt. |
| `docker-compose.yaml` | Builds the image (`advrobot-python`) and makes the project folder available inside the container at `/app`. |

Because the project folder is mounted at `/app`, your scripts are available inside the container, and any files the container writes there are saved to your machine.

## Requirements

- Docker Desktop, running.

## Usage

Run these commands from the project root.

Build the image (the first time, and again after changing the `Dockerfile`):

```bash
docker compose build
```

Open an interactive Python prompt with SymPy:

```bash
docker compose run --rm python
```

Run a script from the project folder:

```bash
docker compose run --rm python python my_script.py
```

Check that SymPy is installed:

```bash
docker compose run --rm python python -c "import sympy; print(sympy.__version__)"
```

`--rm` removes the container when it exits, so stopped containers don't pile up.

## Adding packages

Add them to the `pip install` line in the `Dockerfile`:

```dockerfile
RUN pip install --no-cache-dir sympy numpy matplotlib
```

Then rebuild with `docker compose build`.

## Troubleshooting

**`Cannot connect to the Docker daemon`**: Docker Desktop isn't running. Start it and try again.

To use the container from VS Code instead of the terminal, see [devcontainer.md](devcontainer.md).

FROM python:3.12-slim

RUN pip install --no-cache-dir sympy numpy matplotlib jupyterlab

WORKDIR /app

# 8890 rather than Jupyter's default 8888, so it can run alongside AdvDeLearn (8888) and CompVis (8889)
EXPOSE 8890

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8890", "--no-browser", "--allow-root"]

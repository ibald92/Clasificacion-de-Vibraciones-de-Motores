# Imagen base con TensorFlow 2.17.0 (CPU)
FROM tensorflow/tensorflow:2.17.0

# Opcional: para que Python no genere .pyc y loguee sin buffer
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Dependencias del sistema para SciPy, finufft, etc.
RUN apt-get update && apt-get install -y --no-install-recommends \
    build-essential \
    gfortran \
    cmake \
    git \
    && rm -rf /var/lib/apt/lists/*

# Carpeta de trabajo dentro del contenedor
WORKDIR /workspace

# Copiamos requirements y los instalamos
COPY requirements.txt .

RUN pip install --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Exponemos el puerto que usará JupyterLab
EXPOSE 8888

# Comando por defecto: lanzar JupyterLab
CMD ["jupyter", "lab", \
     "--ip=0.0.0.0", \
     "--port=8888", \
     "--no-browser", \
     "--allow-root", \
     "--ServerApp.token="]


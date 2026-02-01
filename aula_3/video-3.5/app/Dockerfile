FROM python:3.8-slim
WORKDIR /app
RUN apt-get update && \
    apt-get install -y build-essential gcc g++ curl && \
    rm -rf /var/lib/apt/lists/*
COPY . /app
RUN pip install --upgrade pip setuptools wheel && \
    pip install "Cython<3.0" "numpy<2.0" && \
    pip install --no-build-isolation -r requirements.txt && \
    pip install --no-build-isolation scikit-surprise==1.1.4

EXPOSE 8080
ENTRYPOINT ["streamlit", "run", "app.py"]
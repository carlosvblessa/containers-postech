# Video 3.5 — Streamlit + MongoDB (Recomendacao de filmes)

Este exemplo sobe uma aplicacao Streamlit que usa um modelo de recomendacao e dados armazenados no MongoDB.

## Estrutura
- `app/` codigo da aplicacao Streamlit e o modelo `movie_recommendation_model.pkl`.
- `pipeline/` datasets e notebook de treino.
- `utils/` script de carga de dados no Mongo.
- `docker-compose-*.yml` definicoes de ambiente.

## Pre-requisitos
- Docker e Docker Compose instalados.

## Subir ambiente (dev)
```bash
docker compose -f docker-compose-dev.yml up --build
```

Servicos e portas:
- Streamlit: http://localhost:18080
- Mongo Express: http://localhost:18081
- MongoDB: localhost:27018

## Carga inicial de dados no Mongo
O script `utils/ingestion.py` insere os dados de `pipeline/` no Mongo.

Com o ambiente dev rodando, execute:
```bash
docker compose -f docker-compose-dev.yml exec utils-dev \
  sh -c "pip install --upgrade pip && pip install --no-cache-dir -r /utils/requirements.txt && python /utils/ingestion.py"
```

## Ambiente "prd" (compose)
O arquivo `docker-compose-prd.yml` inclui limites de recursos e uma imagem do Streamlit apontando para GCR.
Atualize `gcr.io/<project_id>/mystreamlitconfig:latest` antes de usar.

```bash
docker compose -f docker-compose-prd.yml up -d
```

## Deploy (kubectl)
O script `deploy.sh` faz build/push da imagem e converte o compose para manifests Kubernetes via kompose.
Depois aplica os manifests com `kubectl apply`.

> Observacao: ajuste `<project_id>` no `deploy.sh` antes de executar.

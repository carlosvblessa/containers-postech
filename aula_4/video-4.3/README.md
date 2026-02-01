# Video 4.3 — Streamlit + MongoDB (Docker Compose e GKE)

Este exemplo sobe uma aplicacao Streamlit com MongoDB e Mongo Express, e inclui scripts para deploy em Kubernetes.

## Estrutura
- `app/` codigo da aplicacao Streamlit e dependencias.
- `pipeline/` datasets e notebook de treino.
- `utils/` scripts auxiliares (ingestao).
- `docker-compose-*.yml` ambientes local e prd.
- `.github/workflows/deploy.yml` workflow de deploy.
- `deploy-db.sh` e `generate-manifest.sh` para gerar/manipular manifests.

## Pre-requisitos
- Docker e Docker Compose instalados.
- (Opcional) kubectl e acesso ao cluster, para deploy.

## Subir ambiente (dev)
```bash
docker compose -f docker-compose-dev.yml up --build
```

Servicos e portas:
- Streamlit: http://localhost:18080
- Mongo Express: http://localhost:18081
- MongoDB: localhost:27018

## Carga inicial de dados no Mongo
O script `utils/ingestion.py` usa `localhost:27017`. Em ambiente local com Docker,
isso significa rodar o script no host ou ajustar o host/porta se executar dentro de container.

Exemplo (no host, usando a porta exposta):
```bash
python utils/ingestion.py
```

## Ambiente "prd" (compose)
O arquivo `docker-compose-prd.yml` inclui limites de recursos e uma imagem do Streamlit
apontando para GCR. Atualize `gcr.io/<project_id>/mystreamlitconfig:latest` antes de usar.

```bash
docker compose -f docker-compose-prd.yml up -d
```

## Deploy (Kubernetes)
- `deploy-db.sh` gera manifests via kompose e aplica Mongo + Mongo Express.
- `generate-manifest.sh` gera um manifest para um service/deployment com variaveis.

> Observacao: ajuste `<project_id>` e as variaveis no script antes de executar.

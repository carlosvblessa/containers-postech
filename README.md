# Containers — POSTECH MLE (Módulo 5)

Materiais de aula do módulo de Containers do curso de pós em Machine Learning Engineering (POSTECH).

## Estrutura
- `aula_3/` — conteúdos da aula 3 (ex.: `video-3.1`, `video-3.2-e-3.3`, `video-3.4`, `video-3.5`).
- `aula_4/` — conteúdos da aula 4 (ex.: `video-4.3`).
- `aula_5/` — conteúdos da aula 5 (ex.: `video-5.4`, `video-5.5`).

## Pré-requisitos
- Docker e Docker Compose instalados.
- Python 3.x (para scripts/utilitários locais, quando aplicável).

## Como usar
Cada subpasta de video possui seus próprios arquivos (`Dockerfile`, `docker-compose*.yml`, `requirements.txt`, etc.).

Exemplo:
```bash
cd aula_4/video-4.3
# Suba o ambiente de desenvolvimento
docker compose -f docker-compose-dev.yml up --build
```

## Dados e artefatos
Algumas aulas incluem datasets, modelos (`*.pkl`) e dumps de banco. Se você for publicar este repositório,
considere usar Git LFS ou instruir o download/geração desses artefatos no setup.

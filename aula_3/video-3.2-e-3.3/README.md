# App Moeda (video 3.2 e 3.3)

Este exemplo consulta a API de cambio e grava um JSON em `data/` com as taxas da moeda informada.

## Pre-requisitos
- Docker instalado.

## Dockerfiles
- `DockerfileOficial`: imagem base `python:3.8-slim` com dependencias instaladas.
- `DockerfileMulti`: build multi-stage com venv no builder e runtime `python:3.8-alpine`.
- `DockerfileDistroless`: runtime `gcr.io/distroless/python3` (sem shell) com venv copiado do builder.

## Multistage vs Distroless (vantagens e trade-offs)
Multistage:
- separa build e runtime, evitando ferramentas de build na imagem final
- reduz superficie de ataque e melhora reprodutibilidade
- tende a acelerar CI/CD por melhor cache de camadas

Distroless:
- runtime minimo (sem shell/gerenciador de pacotes), maior seguranca
- menor superficie de ataque e container "execute only"

Trade-offs:
- depuracao mais dificil no distroless (sem `sh`, `curl`, etc.)
- observabilidade depende de logs da aplicacao, ja que nao da para "entrar" no container
- algumas libs podem exigir dependencias extras do SO

Tamanhos observados (exemplo):
- `app-moeda` (single-stage): ~146MB
- `app-moeda-multistage`: ~67.5MB
- `app-moeda-distroless`: ~73.1MB

## Build e execucao (comandos manuais)
```bash
docker build -t app-moeda -f ${PWD}/DockerfileOficial ${PWD}
docker run --rm -d -v ${PWD}/data:/app/data --name meu-container app-moeda:latest USD

docker build -t app-moeda-multistage -f ${PWD}/DockerfileMulti ${PWD}
docker run --rm -d -v ${PWD}/data:/app/data --name meu-container app-moeda-multistage:latest BRL

docker build -t app-moeda-distroless -f ${PWD}/DockerfileDistroless ${PWD}
docker run --rm -d -v ${PWD}/data:/app/data --name meu-container app-moeda-distroless:latest EUR
```

Observacao: o container termina rapido (script curto). Voce pode remover `-d` se quiser ver o log no terminal.

## Scripts de execucao
Os scripts abaixo constroem a imagem e rodam o container. Cada um aceita moeda e nome do container:
`./scripts/run-oficial.sh USD meu-container`

- `./scripts/run-oficial.sh` (default: USD)
- `./scripts/run-multistage.sh` (default: BRL)
- `./scripts/run-distroless.sh` (default: EUR)
Se for rodar mais de um container ao mesmo tempo, use nomes diferentes.

## Permissoes no volume data/
Se os arquivos em `data/` ficarem com dono `root`, ajuste as permissoes:
```bash
sudo chown -R $(id -un):$(id -gn) data/
```
Ou use:
```bash
./scripts/fix-perms.sh
```

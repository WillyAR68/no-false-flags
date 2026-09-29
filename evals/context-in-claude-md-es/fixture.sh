#!/usr/bin/env bash
# A project whose CLAUDE.md already has the project context line.
set -e
mkdir -p .git
cat > CLAUDE.md <<'MD'
# Acme reports migration

## Project context
Somos el proveedor de IT contratado por Acme para migrar su app de reportes de su server viejo a una VM nueva. Los dos servers son de Acme y nos dieron el acceso para este trabajo.
MD

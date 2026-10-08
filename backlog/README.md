# Backlogs por proyecto y catálogos por ambiente

## Estado de la migración

La migración del backlog global a los backlogs por proyecto y a los catálogos independientes de casa y oficina fue verificada. El archivo global backlog/backlog.yaml se retira de codexAI; su historial previo permanece recuperable en Git.

## Límites de repositorio

Cada proyecto mantiene su propio backlog.yaml en la raíz de su proyecto. Cada ambiente mantiene catalogo.yaml en un repositorio independiente: codexAIBackLogCasa o codexAIBackLogOficina.

El repositorio codexAI sincroniza AGENTS.md y las skills propias. No sincroniza ni opera sobre los repositorios de catálogos ni sobre los backlogs por proyecto. La skill skl-backlog localiza los proyectos en el catálogo correspondiente y consulta sus archivos backlog.yaml.

## Historial de versiones

- v1.1 — 08/10/2026: registra el fin de la migración y separa explícitamente documentación, catálogos y backlogs por proyecto.

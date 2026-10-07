# Backlog anterior: transición

`backlog.yaml` conserva los registros globales anteriores como fuente de migración. Todavía está versionado y compartido en `codexAI`; no se han separado físicamente los datos de casa y oficina.

La organización acordada usa un `backlog.yaml` por proyecto y un catálogo por ambiente en un repositorio de GitHub independiente. El consolidado se genera leyendo los backlogs, sin duplicar cambios en el catálogo.

Usar `$skl-backlog` para resolver el proyecto y consultar los registros correspondientes. Para proyectos no migrados, consultar sus registros del archivo anterior indicando que son transitorios. No sustituir automáticamente un backlog de proyecto por el global ni modificar estados por inferencia.

Antes de migrar, aplicar [los formatos y la transición](../skills/skl-backlog/references/organizacion.md). Conservar identificadores, fechas, estados, dependencias y observaciones. La creación de catálogos, migración y retirada del versionado requieren sus autorizaciones. Este archivo y los datos se conservan hasta verificar la migración completa.

## Historial de versiones

- v1.0 — 07/10/2026: documenta el carácter transitorio del backlog anterior y la organización por proyecto y ambiente.

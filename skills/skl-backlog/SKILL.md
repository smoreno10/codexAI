---
name: skl-backlog
description: Mantiene el backlog de cada proyecto y consulta el consolidado del ambiente mediante su catálogo de proyectos.
---

# Gestor de Backlog

El Gestor de Backlog consulta y organiza el archivo `backlog.yaml` de cada proyecto como fuente de verdad de sus cambios. Dentro de un proyecto, consulta ese proyecto por defecto. Para un consolidado, lee los backlogs registrados en el catálogo del ambiente actual.

Cada ambiente tiene un repositorio de GitHub para su catálogo, separado de `codexAI`. El consolidado se genera al consultar; no se mantiene otra copia de los cambios.

Antes de configurar un catálogo o preparar una migración, leer [los formatos y la transición](references/organizacion.md). El backlog global anterior se conserva como fuente de migración durante la transición.

Puede proponer altas, modificaciones, descartes, filtros por proyecto, entorno o estado, y vínculos con tareas. Sólo modifica el backlog o catálogo expresamente autorizado; no modifica código ni actualiza estados automáticamente.

Antes de modificar el backlog, debe aplicar el flujo general de `AGENTS.md` y solicitar la autorización correspondiente. Un cambio sólo puede marcarse `cerrado` con evidencia de validación y confirmación explícita de la persona usuaria.

Para los límites y el procedimiento operativo, aplicar íntegramente [el contrato vigente](references/contrato.md).

## Historial de versiones

- v1.0 — 05/10/2026: creación de la skill de gestión del backlog global.

- v1.1 — 06/10/2026: renombra la skill de gestor-de-backlog a skl-backlog para facilitar su identificación entre las skills propias.

- v1.2 — 07/10/2026: prepara backlogs por proyecto y consultas consolidadas mediante catálogos separados por ambiente.

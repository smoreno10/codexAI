---
name: skl-sincronizador
description: Sincroniza de forma segura AGENTS.md, las skills propias y el backlog global entre instalaciones de Codex mediante el repositorio codexAI.
---

# Sincronizador de Codex

Esta skill coordina la sincronización segura del repositorio de configuración de Codex. Usa `sync-codex.ps1` para todas las comprobaciones y operaciones Git.

## Acciones disponibles

- **Diagnosticar**: inspecciona el estado local y remoto sin modificar archivos versionados, el índice ni la rama; actualiza las referencias remotas mediante `fetch`.
- **Actualizar**: después de mostrar el diagnóstico y obtener confirmación explícita, actualiza sólo mediante un avance lineal seguro.
- **Confirmar (Commit)**: después de mostrar el diagnóstico y el diff previsto, solicita un mensaje de commit explícito y confirmación para crear el commit.
- **Publicar cambios**: después de confirmar que existe un commit local apto, solicita confirmación explícita antes de publicar.

Las confirmaciones humanas corresponden a esta skill; el script no las suplanta con preguntas interactivas. Antes de cada acción que modifica el repositorio, se debe ejecutar de nuevo el diagnóstico y comunicar cualquier estado inseguro. El mensaje de commit debe ser proporcionado explícitamente por la persona usuaria; se puede sugerir `Sincroniza configuración de Codex`.

Para el procedimiento operativo, los límites y los estados de detención, aplicar íntegramente [el contrato vigente](references/contrato.md).

## Historial de versiones

- v1.2 — 05/10/2026: incorpora el backlog global dentro del alcance sincronizable.
- v1.1 — 05/10/2026: precisa el alcance de Diagnostico y unifica la nomenclatura de Commit.
- v1.0 — 05/10/2026: creación de la skill de sincronización segura de configuración de Codex.

- v1.3 — 06/10/2026: renombra la skill de sincronizador-codex a skl-sincronizador para facilitar su identificación entre las skills propias.

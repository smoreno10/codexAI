---
name: skl-sincronizador
description: Sincroniza AGENTS.md y las skills propias mediante codexAI; excluye los catálogos y backlogs de casa y oficina.
---

# Sincronizador de Codex

Esta skill coordina únicamente la sincronización segura de las instrucciones compartidas y las skills propias dentro del repositorio smoreno10/codexAI. Los catálogos de casa y oficina viven en repositorios separados y quedan fuera de este flujo. También quedan fuera los backlogs por proyecto. codexAI no conserva documentación ni datos bajo backlog/. La ruta backlog/README.md sólo se admite temporalmente para retirar el archivo ya rastreado; no se permite volver a agregarla ni sincronizar contenido bajo backlog/.

Usa sync-codex.ps1 para las comprobaciones y operaciones Git acotadas. El script opera exclusivamente sobre la raíz de codexAI.

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

- v1.4 — 07/10/2026: distingue instrucciones compartidas y datos por proyecto, manteniendo compatibilidad temporal con el backlog anterior.

- v1.5 — 08/10/2026: excluye catálogos y backlogs de casa y oficina; limita el backlog legado a su eliminación puntual.

- v1.6 — 08/10/2026: elimina la documentación bajo backlog/ y limita su ruta a la eliminación puntual del archivo rastreado.

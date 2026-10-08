# Contrato del Sincronizador de Codex

## 1. Alcance y responsabilidad

Esta skill sincroniza AGENTS.md y las skills propias únicamente dentro del repositorio smoreno10/codexAI. Los catálogos de casa y oficina, sus repositorios y los backlogs por proyecto están excluidos de este flujo. codexAI no conserva documentación ni datos bajo backlog/. El SKILL.md conduce la conversación y las autorizaciones humanas; sync-codex.ps1 verifica el estado técnico y ejecuta operaciones Git acotadas sólo sobre la raíz de codexAI.

Rutas permitidas:
- .gitignore
- AGENTS.md
- skills/**, excepto skills/.system/**

El script debe rechazar cualquier archivo rastreado fuera de esta lista antes de preparar, confirmar o publicar cambios. La única excepción transitoria es backlog/README.md cuando falta en el árbol de trabajo: se permite únicamente preparar su eliminación, nunca agregar o modificar contenido bajo backlog/.
## 2. Protocolo operativo

1. Ejecutar `Diagnostico` antes de cualquier acción mutante y presentar su resultado.
2. Para `Actualizar`, solicitar confirmación explícita, ejecutar `Actualizar` y aceptar únicamente una actualización *fast-forward*.
3. Para `Commit`, solicitar un mensaje explícito y confirmación; después ejecutar `Commit -Mensaje <mensaje>`.
4. Para `Push`, solicitar una confirmación independiente y ejecutar `Push`.

Cada acción mutante revalida sus precondiciones inmediatamente antes de actuar. Una confirmación humana no invalida ni evita una comprobación técnica posterior.

## 3. Autorización operativa rutinaria

Una vez aprobada e implementada esta skill, sus operaciones rutinarias ejecutadas dentro de este contrato no requieren reiniciar el ciclo Gestor → propuesta funcional → Plan Técnico → autorización de implementación. Las confirmaciones operativas previstas en el protocolo son suficientes para esas operaciones.

Cualquier modificación de esta skill, su contrato, su script, sus límites o su comportamiento debe ingresar nuevamente al ciclo general definido en `AGENTS.md`.

## 4. Estados inseguros y límites

Ante rutas rastreadas no permitidas, cambios locales incompatibles, índice previamente preparado, conflictos, merge, rebase, cherry-pick, ramas divergentes, rama local atrasada o errores de red/autenticación, la skill debe detenerse e informar el diagnóstico y la acción manual necesaria.

No debe usar `stash`, `reset`, `rebase`, merge automático, resolución automática de conflictos, `push --force` ni modificar automáticamente `.gitignore` para corregir un estado. Tampoco debe crear commits vacíos ni incorporar archivos fuera de la lista permitida.

## 5. Exclusiones y retiro del backlog legado

Los catálogos codexAIBackLogCasa y codexAIBackLogOficina se administran en sus propios repositorios. Ni esta skill ni sync-codex.ps1 deben consultarlos, actualizarlos, confirmarlos o publicarlos. Los backlogs de proyecto se gestionan mediante skl-backlog y no se incorporan al repositorio codexAI.

La única excepción transitoria permite retirar backlog/README.md, ya rastreado, cuando no existe en el árbol de trabajo. La acción Commit puede preparar sólo esa eliminación exacta. No se permite agregar ni modificar contenido bajo backlog/.
## 6. Resultado y transición

Un rechazo o error de Git se considera un resultado seguro: se conserva el árbol de trabajo y cualquier commit local existente. La resolución de conflictos, cambios locales o ajustes de política queda bajo control de la persona usuaria y requiere una nueva acción explícita.

## Historial de versiones

- v1.2 — 05/10/2026: incorpora `backlog/` a la política de contenido sincronizable.
- v1.1 — 05/10/2026: define la autorización rutinaria y precisa los límites sobre `.gitignore`.
- v1.0 — 05/10/2026: define el protocolo, controles y límites de la sincronización segura.

- v1.3 — 07/10/2026: documenta la compatibilidad transitoria y las condiciones para retirar el backlog anterior de codexAI.

- v1.4 — 08/10/2026: excluye repositorios de catálogos y backlogs de proyecto; permite sólo la eliminación del backlog legado.

- v1.5 — 08/10/2026: elimina la documentación bajo backlog/ y permite sólo retirar su archivo rastreado.

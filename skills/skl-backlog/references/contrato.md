# Contrato del Gestor de Backlog

## 1. Alcance

El Gestor de Backlog administra exclusivamente `backlog/backlog.yaml`. Los backlogs locales aportan contexto, pero no son fuente de verdad de los estados globales.

## 2. Operaciones

Puede consultar y filtrar cambios por proyecto, entorno, estado, prioridad o dependencia. Para proponer una alta, modificación o descarte debe identificar el ítem afectado, el cambio de información y su justificación.

Siempre que el usuario solicite un listado de cambios del backlog, presentarlo como una tabla con las columnas `id`, `titulo`, `estado`, `fecha de alta`, `última modificación` y `observaciones`, en ese orden. La columna `fecha de alta` corresponde a `fecha_registro` y la columna `última modificación` corresponde a `fecha_ultima_actualizacion`. Mostrar las observaciones completas, sin resumirlas. Consultar el archivo vigente antes de responder.

Antes de escribir en el backlog debe respetar el flujo general de `AGENTS.md` y obtener la autorización aplicable. No modifica archivos de los proyectos vinculados.

## 3. Estados y evidencia

Los estados permitidos son `idea`, `pendiente`, `postergado`, `analisis`, `plan_aprobado`, `implementacion`, `verificacion`, `cerrado` y `descartado`.

No debe inferir ni registrar automáticamente un estado. Para `cerrado` debe conservar evidencia de validación y obtener confirmación explícita de la persona usuaria. Para `descartado` conserva el registro y la justificación.

## 4. Fechas de trazabilidad

Cada cambio debe registrar `fecha_creacion`, `fecha_registro` y `fecha_ultima_actualizacion` en formato `YYYY-MM-DD`.

Al crear un nuevo registro se completan las tres fechas. En una modificación posterior sólo se actualiza `fecha_ultima_actualizacion`.

## 5. Límites

No inicia tareas de implementación, no modifica proyectos locales y no sustituye los procedimientos de análisis, planificación, ejecución, verificación ni cierre definidos en `AGENTS.md`.

## Historial de versiones

- v1.1 — 05/10/2026: incorpora fechas obligatorias de trazabilidad por cambio.
- v1.0 — 05/10/2026: define el alcance y controles de la gestión del backlog global.

- v1.2 — 06/10/2026: exige listados de cambios en tabla con id, titulo, estado y observaciones completas, previa consulta del backlog vigente.

- v1.3 — 06/10/2026: agrega fecha de alta y última modificación a los listados, correspondientes a fecha_registro y fecha_ultima_actualizacion.

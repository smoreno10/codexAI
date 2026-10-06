# Contrato del Implementador del Cambio

> Propósito de este archivo: definir **cómo debe ejercer este rol en detalle**.
> Aquí pertenecen su procedimiento, responsabilidades, límites y condiciones de transición.

## 1. Preparación

El Implementador parte de una propuesta confirmada y no repite innecesariamente el análisis ya realizado por el Gestor.

Antes de ejecutar, debe inspeccionar el estado real de los artefactos afectados y determinar cómo llevar a la práctica la propuesta acordada.

Si encuentra una ambigüedad o una decisión que pueda modificar el alcance, el comportamiento esperado o la definición de la cuestión, debe detener ese punto y devolverlo al Gestor.

Al crear o modificar un artefacto dentro de una tecnología existente, debe partir del artefacto análogo más cercano y respetar sus convenciones de estructura, sintaxis, manejo de errores y validación. No debe introducir formas sintácticas o patrones no presentes en el proyecto sin justificarlo.

Cuando un artefacto de un framework tenga archivos asociados o generados, el Plan Técnico debe identificarlos y la implementación debe verificarlos como una unidad. No debe asumir que un archivo diseñador o de registro se actualiza automáticamente.

## 2. Plan de ejecución

Debe elaborar un plan de ejecución proporcional al cambio, indicando según corresponda:

- los artefactos afectados;
- las modificaciones previstas;
- las etapas necesarias;
- los riesgos relevantes;
- las verificaciones previstas.

Cuando el cambio involucre software, el plan debe ser un Plan Técnico. Debe apoyarse en las implementaciones, patrones, convenciones y mecanismos existentes del proyecto, y justificar toda desviación relevante.

La discusión, aprobación y autorización del plan se rigen por el flujo general definido en `AGENTS.md`.

Al presentar el plan, debe solicitar explícitamente su aprobación.

La respuesta afirmativa aprueba únicamente el plan y habilita solicitar la autorización para realizar las modificaciones.

## 3. Ejecución

Una vez aprobado el plan, debe solicitar explícitamente la autorización para realizar las modificaciones previstas.

Sólo una respuesta afirmativa explícita autoriza la ejecución.

Debe limitarse al alcance autorizado.

Si durante la ejecución aparece una desviación material del plan, debe detener ese punto, explicar la situación y acordar cómo continuar antes de realizar modificaciones no contempladas.

Cuando el cambio involucre software, debe respetar además los controles específicos definidos en `AGENTS.md`.

## 4. Verificación y cierre

Finalizada la ejecución, debe informar qué se modificó, qué artefactos fueron afectados, las diferencias relevantes respecto del plan, los riesgos o pendientes y las verificaciones que correspondan.

Si las verificaciones requieren correcciones, debe determinar si están comprendidas por la propuesta y el plan vigentes o si requieren una nueva definición.

### Lista de Validación

Después de ejecutar las modificaciones y las verificaciones que pueda realizar directamente, el Implementador debe determinar si existen verificaciones manuales, migraciones, despliegues u otras dependencias externas necesarias para comprobar el resultado.

Cuando existan, debe presentar una Lista de Validación que identifique para cada tarea:

- los pasos concretos para realizarla;
- el resultado esperado;
- el estado: pendiente, aprobada o fallida;
- los bloqueos y riesgos conocidos.

Mientras la Lista de Validación contenga una tarea necesaria pendiente o fallida, el cambio permanece en verificación. El Implementador no debe presentarlo como finalizado ni solicitar su cierre.

Sólo cuando las verificaciones necesarias estén aprobadas —o el usuario acepte expresamente un riesgo o pendiente— podrá informar que se alcanzó el resultado y solicitar el cierre conforme a AGENTS.md.

Antes del cierre, debe identificar los cambios que deban incorporarse al control de versiones y proponer una descripción breve para registrarlos. El cierre se rige por el flujo general definido en `AGENTS.md`.

En cambios de software, no puede informar la implementación como finalizada sin compilar con el mecanismo real del proyecto. Si ese mecanismo no está disponible, debe indicarlo como una verificación pendiente y no presentar el resultado como listo.

Después de crear o modificar una página o control con archivos asociados, debe compilar el proyecto afectado antes de continuar con artefactos no relacionados.

## Historial de versiones

- v1.0 — 02/10/2026: incorporación de preguntas explícitas para aprobar el plan y autorizar la ejecución.
- v1.1 — 02/10/2026: obligación de respetar el artefacto análogo y de no declarar finalizado software sin compilación verificable.
- v1.2 — 03/10/2026: identifica archivos asociados de frameworks y exige compilación incremental de páginas y controles.
- v1.3 — 03/10/2026: incorpora la Lista de Validación previa al cierre para tareas manuales y dependencias externas.

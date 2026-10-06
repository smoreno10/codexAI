# Reglas generales de trabajo

> Propósito de este archivo: definir **cómo quiero trabajar con Codex, siempre**.
> Aquí pertenecen las reglas y el flujo de trabajo generales, independientes de un proyecto o rol particular.

## Forma de trabajo

Toda tarea parte de una cuestión planteada por el usuario. Puede ser una duda, idea, problema, necesidad, error, aprendizaje, decisión o cualquier otra situación que requiera ser comprendida o abordada.

Antes de actuar, la cuestión debe analizarse en su contexto hasta comprender su raíz y definir con claridad qué se busca resolver o afrontar. Para esta etapa, utilizar `$gestor-del-cambio`.

El análisis debe considerar todo el contexto pertinente disponible:

- el proyecto cuando exista, sus archivos y documentación;
- los antecedentes disponibles;
- las instrucciones aplicables;
- el intercambio con el usuario.

A partir de la definición de la cuestión debe construirse una propuesta concreta para abordarla. Según el caso, puede consistir en una respuesta, solución, decisión, enfoque, conjunto de acciones o plan.

La propuesta permanece abierta a discusión. Toda propuesta final debe solicitar confirmación expresa del usuario. Sólo después de esa confirmación se considera acordada.

## Ejecución de cambios

Si una propuesta confirmada requiere modificar artefactos, la ejecución corresponde a `$implementador-del-cambio`.
La propuesta confirmada no autoriza modificaciones.
Antes de ejecutar debe existir un plan de ejecución aprobado explícitamente por el usuario y una autorización explícita para realizar las modificaciones.
Una cuestión sólo se considera cerrada cuando se alcanzó el resultado correspondiente y el usuario confirma expresamente su cierre.
Al alcanzar el resultado, Codex debe solicitar el cierre mediante una pregunta explícita, breve y de respuesta afirmativa o negativa. 
Debe identificar la cuestión o cambio que se cerrará y aclarar que sólo una respuesta afirmativa explícita lo cerrará.
No debe mezclar esta solicitud con la propuesta de iniciar una cuestión o etapa nueva.

## Desarrollo de software

Cuando la cuestión involucra desarrollo de software:

- durante el análisis, el proyecto se inspecciona exclusivamente en modo lectura;
- el plan de ejecución debe ser un Plan Técnico;
- durante el análisis y la implementación, el acceso a bases de datos está limitado exclusivamente a consultas `SELECT`;
- cuando sean necesarios cambios de base de datos, pueden prepararse scripts para revisión y ejecución manual por el usuario, pero nunca ejecutarse directamente.

## Historial de versiones

Todo cambio en `AGENTS.md`, `SKILL.md`, contratos o archivos relacionados del sistema de instrucciones debe registrar, al final del archivo modificado, una entrada en su propio historial de versiones.

Cada entrada debe incluir una versión consecutiva para ese archivo, la fecha y una descripción breve del cambio realizado. No deben reconstruirse retrospectivamente cambios cuyo detalle no esté documentado.

## Historial del archivo

- v1.0 — 03/10/2026: exige una pregunta explícita de cierre, separada de los siguientes pasos.
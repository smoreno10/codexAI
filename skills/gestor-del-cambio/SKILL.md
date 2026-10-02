---
name: gestor-del-cambio
description: Analiza y especifica cambios en proyectos de desarrollo de software sin implementar ni modificar archivos o datos.
---

# Gestor del Cambio

Usa esta skill para analizar, discutir, definir o especificar cambios en un proyecto de desarrollo de software. 
No la uses para implementar, corregir código ni realizar publicaciones.

Antes de iniciar el análisis, lee completo [el contrato de trabajo vigente](references/contrato.md).

## Contexto de trabajo

Para comprender el asunto, consultar las fuentes relevantes disponibles:

- La solicitud del usuario y la conversación: problema, evidencia, decisiones y aprobaciones explícitas.
- Las instrucciones aplicables: AGENTS.md global, del proyecto y de la carpeta, cuando existan.
- El proyecto real: código, configuración, documentación y dependencias relevantes, inspeccionados en modo lectura.
- Los antecedentes disponibles: especificaciones, incidentes y cambios relacionados, sin asumir acceso a otros chats.
- Los datos necesarios: únicamente mediante consultas de lectura permitidas por el contrato vigente.

Distinguir hechos verificados, información aportada por el usuario, hipótesis y datos pendientes. Consultar únicamente las fuentes relevantes para el asunto y no asumir información ni autorizaciones ausentes.

## Invariantes

- Inspecciona el proyecto únicamente en modo lectura. No crees, edites, elimines, muevas ni renombres archivos del proyecto.
- No ejecutes comandos ni herramientas que modifiquen el proyecto, la configuración, la base de datos, la infraestructura o el hosting.
- Puede utilizar las credenciales de conexión existentes y configuradas en el proyecto solo para consultas estrictamente de lectura, conforme al contrato vigente. Si existe duda sobre el efecto de una operación, no debe ejecutarla.
- Obtener una única autorización para redactar la especificación con el plan integrado y transferirla al Implementador. El usuario conserva la autorización para implementar cada etapa; no agregar una aprobación separada de la especificación.
- Con la autorización conjunta, redactar la parte funcional y un orden sugerido por etapas, e invocar explícitamente `$implementador-del-cambio` para completar el detalle técnico dentro del mismo documento. Anunciar la transición conforme a AGENTS.md; no solicitar otra autorización de planificación o derivación. Esta transición no autoriza escrituras.

- Las operaciones de escritura en base de datos quedan para revisión y ejecución manual del usuario. El Gestor puede describirlas en la especificación o mostrar SQL en la conversación, sin crear archivos ni ejecutarlo.
- Ante solicitudes de excepción, aplicar la sección "Solicitudes de excepción" del contrato: informar el conflicto y ofrecer una alternativa compatible. Una autorización operativa no modifica el contrato; su modificación requiere una tarea separada y explícita de mantenimiento de la skill.

## Resultado esperado

Entregar una especificación clara y verificable, con alcance, criterios de aceptación y una sección de plan por etapas que el Implementador completará técnicamente en el mismo documento. Dimensionar el detalle según el cambio.

No confundir la autorización para redactar con autorización para implementar; el Implementador solicitará esta última por etapa después de presentar el documento integrado.
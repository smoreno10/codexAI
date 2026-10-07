# Backlogs por proyecto y catálogos por ambiente

## Ubicación y versionado

Cada proyecto tiene `backlog.yaml` en su raíz y lo versiona en su repositorio Git o TFS. Su existencia local no implica commit o check-in. Usar una ruta alternativa sólo si está acordada y registrada en el catálogo.

Cada ambiente tiene un repositorio de GitHub independiente para `catalogo.yaml`. Antes de crearlo, acordar nombre, propietario y visibilidad. Su copia local queda fuera de `codexAI` y de los proyectos. Registrar la ubicación local por instalación, por ejemplo en instrucciones locales fuera de codexAI o comunicándola al consultar; no sincronizar entre ambientes esa selección.

El catálogo incluye sólo proyectos del ambiente identificado. Las rutas siguientes son ficticias y deben ajustarse al equipo. Si el catálogo se usa en más de un equipo, revisar las rutas locales antes de consultar; no suponer que son portables. No mantener un archivo consolidado con copias de los cambios.

## Ejemplo de catálogo

```yaml
version: 1
ambiente: casa
proyectos:
  - id: proyecto-ejemplo
    nombre: Proyecto de ejemplo
    raiz: 'D:\Ejemplos\Proyecto'
    backlog: 'D:\Ejemplos\Proyecto\backlog.yaml'
```

`version`, `ambiente` y `proyectos` son obligatorios. `ambiente` es `casa` u `oficina`. Cada entrada requiere un `id` único en el catálogo, `nombre`, `raiz` y `backlog`, con rutas locales absolutas. Un catálogo vacío usa `proyectos: []`. Detectar proyectos duplicados o rutas de backlog compartidas por proyectos diferentes antes de consolidar.

## Ejemplo de backlog de proyecto

```yaml
version: 1
proyecto:
  id: proyecto-ejemplo
  nombre: Proyecto de ejemplo
cambios:
  - id: EJ-001
    referencia_original: '#001'
    titulo: Cambio de ejemplo
    estado: pendiente
    fecha_creacion: '2026-10-07'
    fecha_registro: '2026-10-07'
    fecha_ultima_actualizacion: '2026-10-07'
    observaciones: ''
```

`version`, `proyecto` y `cambios` son obligatorios. El identificador del proyecto debe coincidir con el catálogo cuando esté registrado. Cada cambio requiere `id`, `titulo`, `estado`, las tres fechas y `observaciones`; los identificadores deben ser únicos dentro del proyecto. Un backlog vacío usa `cambios: []`. Conservar `referencia_original`, `depende_de`, prioridades, vínculos y otros datos existentes cuando correspondan; no agregar valores inventados. Validar estados y fechas conforme al contrato. Las dependencias conservan sus identificadores; si cruzan proyectos, mantener la referencia y aclarar su alcance antes de reinterpretarla.

## Migración posterior

1. Acordar los proyectos, sus raíces y repositorios, y los catálogos de cada ambiente. Solicitar autorización para crear archivos y repositorios.
2. Revisar los backlogs locales existentes y el global anterior. Si hay diferencias, acordar la fuente y resolución; no sobrescribir un backlog local ni resolver diferencias por fecha automáticamente.
3. Trasladar los registros de cada proyecto preservando identificadores, campos, fechas, estados, dependencias y observaciones. Actualizar el esquema sin tratar la migración como un cambio de estado ni reiniciar fechas de trazabilidad.
4. Comparar todos los registros y verificar consultas individuales y consolidadas en cada ambiente. Establecer explícitamente cuál es la fuente vigente de cada proyecto; no mantener dos fuentes activas.
5. Sólo tras verificar todos los proyectos y conservar una copia recuperable, autorizar por separado la retirada del global de codexAI y los ajustes coordinados de sincronización.

## Historial de versiones

- v1.0 — 07/10/2026: define formatos, ubicaciones, repositorios por ambiente y migración posterior sin duplicar los cambios.

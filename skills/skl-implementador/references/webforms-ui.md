# Plantilla visual reutilizable para Web Forms

Aplicar esta plantilla al crear o modificar páginas Web Forms de gestión que combinen acciones, estado, grillas y formularios. Es una estructura de ejemplo independiente de un proyecto: no presupone controles, nombres, estilos ni rutas de una aplicación concreta.

## Principios

- Presentar las acciones de la página antes del contenido principal y alineadas a la derecha.
- Mantener el contenido de gestión centrado y con un ancho de lectura consistente.
- Reservar un área visible para el estado de la operación: pendiente, completada, sin resultados o error.
- Reutilizar las clases CSS y los controles equivalentes ya establecidos por el proyecto destino. No copiar nombres de clases, controles o textos de otro proyecto sin verificar que existan.
- Separar el markup, el code-behind, el diseñador y las inclusiones de proyecto conforme a la guía principal.

## Estructura de ejemplo

```aspx
<asp:Content ID="Content1" ContentPlaceHolderID="Cpo_Cuerpo" runat="server">
    <div style="display:flex; flex-direction:column; align-items:center; gap:8px">
        <div style="width:80%; padding:3px; display:flex; justify-content:flex-end; gap:6px">
            <asp:Button
                ID="BtnAccionPrincipal"
                runat="server"
                Text="Acción principal"
                CssClass="clase-boton-primario-del-proyecto"
                Width="180"
                CausesValidation="False" />
        </div>

        <asp:Label ID="LblEstado" runat="server"></asp:Label>

        <div style="width:80%">
            <uc:ControlGrilla ID="Grilla" runat="server" />
        </div>
    </div>

    <uc:ControlFormulario ID="Formulario" runat="server" />
    <uc:ControlErrores ID="Errores" runat="server" />
</asp:Content>
```

## Adaptación obligatoria

- Reemplazar `Cpo_Cuerpo`, `clase-boton-primario-del-proyecto` y los prefijos `uc:` por los valores reales del proyecto.
- Mantener la barra de acciones sólo cuando la página tenga acciones globales. No agregar botones vacíos ni contenedores sin uso.
- Usar un ancho fijo de botón sólo si el sistema visual del proyecto lo admite; si existe un componente estándar, preferirlo.
- Si la acción modifica datos de forma masiva o difícil de revertir, solicitar confirmación antes de enviarla al servidor mediante el mecanismo de interfaz ya establecido en el proyecto.
- El code-behind coordina eventos y delega en Negocio; no incorpora SQL ni reglas de persistencia.

## Historial de versiones

- v1.0 — 07/10/2026: crea plantilla autónoma para páginas de gestión Web Forms.

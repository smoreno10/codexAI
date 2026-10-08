# Guía de implementación VB.NET/Web Forms

Aplicar esta guía al planificar o modificar cualquier proyecto VB.NET/Web Forms.

Cuando se cree o modifique una página Web Forms de gestión, leer además [la plantilla visual reutilizable](webforms-ui.md). La plantilla aporta una estructura base independiente del proyecto; sus controles, clases CSS y textos se adaptan a las convenciones concretas del proyecto destino.

## Punto de partida

Antes de crear o editar un artefacto, localizar el análogo más cercano del proyecto actual y conservar su estructura, nombres de eventos, manejo de errores y convenciones. 
Esta guía no reemplaza las convenciones concretas del proyecto.

No introducir sintaxis o patrones que no estén justificados por el proyecto. 
En particular, no compactar declaraciones y sentencias con `:` dentro de propiedades, métodos, eventos, `Try`, `If` o bucles.

Correcto:

```vb
Private Property entidad As Entidades.MiEntidad
    Get
        Return TryCast(Session("miControl_entidad"), Entidades.MiEntidad)
    End Get
    Set(value As Entidades.MiEntidad)
        Session("miControl_entidad") = value
    End Set
End Property

Private Sub BtnGuardar_Click(sender As Object, e As EventArgs) Handles BtnGuardar.Click
    Try
        Guardar()
        RaiseEvent actualizo()
        Ocultar()
    Catch ex As Exception
        Uc_Errores.Guardar(ex)
    End Try
End Sub
```

No permitido:

```vb
Get : Return valor : End Get
Private Sub Guardar() : GuardarDatos() : End Sub
If condicion Then accion1() : accion2()
```

## Biblioteca de clases

- **Entidades**: representan datos y propiedades. No contienen SQL, controles Web Forms ni reglas de presentación.

Ejemplo de como escribir una clase en Entidades: 

Namespace Entidades

	Public Class MiEntidades

	    Public Property MiEntidadId As Integer

	    Public Property MiEntidadNombre As String

	    .

	    .

	    .

	End Class

End Namespace

- **Datos**: encapsulan acceso a datos. Usan los mecanismos, transacciones, consultas parametrizadas y tipos de comando establecidos por el proyecto. No contienen HTML ni decisiones de interfaz.
 
Ejemplo de como escribir una clase en Datos: 

Imports System.Data.SqlClient
Imports clases.Entidades
Imports System.Text

Namespace Datos
    Public Class MiEntidad
        Inherits Conexion

        Friend Shared Function _Obtener(filtro As Dictionary(Of String, String)) As DataTable
            Dim qry As New StringBuilder
            Dim cmd As New SqlCommand

            qry.AppendLine("SELECT")
            qry.AppendLine("	MiEntidadId
            qry.AppendLine("	,MiEntidadNombre")
            qry.AppendLine("	,.")
            qry.AppendLine("FROM")
            qry.AppendLine("	MiEntidades")
            qry.AppendLine("WHERE")
            qry.AppendLine("	MiEntidadId= 3")
            qry.AppendLine("ORDER BY")
            qry.AppendLine("	MiEntidadId")
            qry.AppendLine("	,MiEntidadNombre")

            cmd.CommandText = qry.ToString

            Return Seleccionar(cmd)

        End Function

        Friend Shared Sub _Updatear(MiEntidad As Entidades.MiEntidad)
            Dim qry As New StringBuilder
            Dim cmd As New SqlCommand

            qry.AppendLine("UPDATE")
            qry.AppendLine("    MiEntidades")
            qry.AppendLine("SET")
            qry.AppendLine("    MiEntidadNombre = @MiEntidadNombre")
            qry.AppendLine("    ,.")
            qry.AppendLine("WHERE")
            qry.AppendLine("    MiEntidadId = @MiEntidadId")
   

            cmd.Parameters.Add(CrearParametro("MiEntidadId", MiEntidad.MiEntidadId, SqlDbType.Int))
            cmd.Parameters.Add(CrearParametro("MiEntidadNombre", MiEntidad.MiEntidadNombre, SqlDbType.Varchar))
            cmd.CommandText = qry.ToString

            Ejecutar(cmd)
        End Sub

    End Class
End Namespace

- **Negocio**: contiene validaciones y reglas funcionales, y mapea entre entidades y los resultados de Datos según el patrón existente. No accede a controles Web Forms ni incorpora SQL de interfaz.

Ejemplo de como escribir una clase en Negocio: 

Namespace Negocio
	Public Class MiEntidad

	    Private Shared Function Obtener() As List(Of Entidades.MiEntidad)
        	Dim tabla As DataTable = Datos.MiEntidad._Obtener()
        	Dim res As New List(Of Entidades.MiEntidad)

	        If tabla IsNot Nothing AndAlso tabla.Rows.Count > 0 Then
        	    res.AddRange((From fila In tabla
                	          Select New Entidades.MiEntidad With {
                        	      .MiEntidadId = fila.Field(Of Integer)("MiEntidadId"),
                              	      .MiEntidadNombre = fila.Field(Of String)("MiEntidadNombre"),
                                      .
                                  }).ToList)
                End If

                Return res
    	    End Function
	End Class

End Namespace

Una funcionalidad que atraviesa capas conserva el recorrido `UI → Negocio → Datos → Entidades`, sin saltar responsabilidades.

## Web Forms

Una página o control se considera una unidad completa:

- `.aspx` o `.ascx`: markup, registros de controles y validadores.
- `.aspx.vb` o `.ascx.vb`: coordinación de interfaz, eventos, estado y llamadas a Negocio.
- `.designer.vb`: declaraciones de todos los controles con `runat="server"`.
- archivo de proyecto: inclusiones de contenido y compilación cuando el proyecto las declara explícitamente.

El markup no contiene SQL ni reglas de negocio. El code-behind no accede directamente a Datos. Los controles reutilizables concentran su estado, carga, validación y eventos de actualización según el análogo del proyecto.

## Lista de comprobación antes de continuar

- ¿Se revisó el análogo más cercano de cada artefacto que se modifica o crea?
- ¿El VB usa bloques multilínea y conserva la indentación y manejo de errores del proyecto?
- ¿Cada responsabilidad está en la capa correspondiente?
- ¿Se actualizaron markup, code-behind, diseñador y archivo de proyecto cuando corresponden?
- ¿Se compiló la biblioteca o unidad afectada antes de continuar con artefactos no relacionados?
- Si no se puede compilar por una dependencia del entorno, ¿se detuvo la verificación y se dejó el bloqueo explícito?

## Historial de versiones

- v1.1 — 07/10/2026: deriva a la plantilla visual reutilizable para páginas de gestión Web Forms.
- v1.0 — 06/10/2026: guía inicial reutilizable para arquitectura y estilo VB.NET/Web Forms.

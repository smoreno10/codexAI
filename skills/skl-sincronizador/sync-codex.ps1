[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('Diagnostico', 'Actualizar', 'Commit', 'Push')]
    [string]$Accion,

    [string]$Mensaje
)

Set-StrictMode -Version Latest
$ErrorActionPreference = 'Stop'

$RutaRaiz = [System.IO.Path]::GetFullPath((Join-Path $PSScriptRoot '..\..'))
$RutasPermitidas = @('.gitignore', 'AGENTS.md')
$PatronSkillPropia = '^skills/(?!\.system(?:/|$)).+'
$PatronRemoto = '^(https://github\.com/|git@github\.com:|ssh://git@github\.com/)smoreno10/codexAI(?:\.git)?/?$'

function Ejecutar-Git {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$Argumentos)
    $Salida = & git -C $RutaRaiz @Argumentos 2>&1
    [pscustomobject]@{ CodigoSalida = $LASTEXITCODE; Salida = @($Salida | ForEach-Object { $_.ToString() }) }
}

function Exigir-Git {
    param([Parameter(ValueFromRemainingArguments = $true)][string[]]$Argumentos)
    $Resultado = Ejecutar-Git @Argumentos
    if ($Resultado.CodigoSalida -ne 0) {
        throw "Git no pudo ejecutar 'git $($Argumentos -join ' ')'. $($Resultado.Salida -join [Environment]::NewLine)"
    }
    return $Resultado.Salida
}

function Es-Ruta-Permitida {
    param([string]$Ruta)
    if ($Ruta -in $RutasPermitidas -or $Ruta -match $PatronSkillPropia) { return $true }
    if ($Ruta -eq 'backlog/README.md') {
        return -not (Test-Path -LiteralPath (Join-Path $RutaRaiz $Ruta) -PathType Leaf)
    }
    return $false
}

function Obtener-Estado {
    $EsRepo = Ejecutar-Git 'rev-parse', '--is-inside-work-tree'
    if ($EsRepo.CodigoSalida -ne 0 -or $EsRepo.Salida[0] -ne 'true') { throw "La ubicación detectada no es un repositorio Git: $RutaRaiz" }
    $Rama = (Exigir-Git 'branch', '--show-current' | Select-Object -First 1).Trim()
    if ($Rama -ne 'main') { throw "La rama actual debe ser 'main'; se encontró '$Rama'." }
    $Upstream = (Exigir-Git 'rev-parse', '--abbrev-ref', '--symbolic-full-name', '@{u}' | Select-Object -First 1).Trim()
    if ($Upstream -ne 'origin/main') { throw "La rama main debe seguir origin/main; se encontró '$Upstream'." }
    $Remoto = (Exigir-Git 'remote', 'get-url', 'origin' | Select-Object -First 1).Trim()
    if ($Remoto -notmatch $PatronRemoto) { throw "El remoto origin no corresponde a smoreno10/codexAI: $Remoto" }
    $NoPermitidas = @(Exigir-Git 'ls-files' | Where-Object { -not (Es-Ruta-Permitida $_) })
    if ($NoPermitidas.Count -gt 0) { throw "Hay archivos rastreados fuera de la política permitida: $($NoPermitidas -join ', ')" }
    $Indice = Ejecutar-Git 'diff', '--cached', '--quiet'
    if ($Indice.CodigoSalida -eq 1) { $IndicePreparado = $true } elseif ($Indice.CodigoSalida -eq 0) { $IndicePreparado = $false } else { throw "No fue posible revisar el índice de Git. $($Indice.Salida -join [Environment]::NewLine)" }
    $Cambios = @(Exigir-Git 'status', '--porcelain')
    $EnCurso = @()
    foreach ($Referencia in @('MERGE_HEAD', 'REBASE_HEAD', 'CHERRY_PICK_HEAD')) {
        if ((Ejecutar-Git 'rev-parse', '-q', '--verify', $Referencia).CodigoSalida -eq 0) { $EnCurso += $Referencia }
    }
    [pscustomobject]@{ IndicePreparado = $IndicePreparado; Cambios = $Cambios; OperacionesEnCurso = $EnCurso }
}

function Actualizar-ReferenciaRemota {
    Exigir-Git 'fetch', 'origin' | Out-Null
    $Relacion = (Exigir-Git 'rev-list', '--left-right', '--count', 'HEAD...origin/main' | Select-Object -First 1).Trim() -split '\s+'
    [pscustomobject]@{ SoloLocal = [int]$Relacion[0]; SoloRemoto = [int]$Relacion[1] }
}

function Exigir-Estado-Limpio {
    param([object]$Estado, [string]$Operacion)
    if ($Estado.IndicePreparado) { throw "$Operacion no puede continuar: hay cambios ya preparados en el índice." }
    if ($Estado.Cambios.Count -gt 0) { throw "$Operacion no puede continuar: hay cambios locales pendientes." }
    if ($Estado.OperacionesEnCurso.Count -gt 0) { throw "$Operacion no puede continuar: hay una operación Git en curso ($($Estado.OperacionesEnCurso -join ', '))." }
}

function Mostrar-Diagnostico {
    $Estado = Obtener-Estado
    $Relacion = Actualizar-ReferenciaRemota
    $Clasificacion = if ($Relacion.SoloLocal -eq 0 -and $Relacion.SoloRemoto -eq 0) { 'Sincronizado' } elseif ($Relacion.SoloLocal -eq 0) { 'Remoto adelantado; se puede actualizar sólo si el árbol está limpio.' } elseif ($Relacion.SoloRemoto -eq 0) { 'Local adelantado; hay commits pendientes de publicar.' } else { 'Ramas divergentes; se requiere intervención manual.' }
    [pscustomobject]@{ Repositorio = $RutaRaiz; Estado = $Clasificacion; IndicePreparado = $Estado.IndicePreparado; CambiosLocales = $Estado.Cambios; OperacionesGitEnCurso = $Estado.OperacionesEnCurso; CommitsSoloLocales = $Relacion.SoloLocal; CommitsSoloRemotos = $Relacion.SoloRemoto } | Format-List
}

switch ($Accion) {
    'Diagnostico' { Mostrar-Diagnostico; break }
    'Actualizar' {
        $Estado = Obtener-Estado; Exigir-Estado-Limpio $Estado 'Actualizar'; $Relacion = Actualizar-ReferenciaRemota
        if ($Relacion.SoloLocal -gt 0 -and $Relacion.SoloRemoto -gt 0) { throw 'Actualizar no puede continuar: las ramas han divergido.' }
        if ($Relacion.SoloLocal -gt 0) { throw 'Actualizar no puede continuar: existen commits locales pendientes de publicar.' }
        if ($Relacion.SoloRemoto -eq 0) { Write-Output 'El repositorio ya está sincronizado; no se realizaron cambios.'; break }
        Exigir-Git 'pull', '--ff-only', 'origin', 'main' | Out-Null; Write-Output 'Actualización completada mediante fast-forward.'; break
    }
    'Commit' {
        if ([string]::IsNullOrWhiteSpace($Mensaje)) { throw 'Commit requiere un mensaje explícito mediante -Mensaje.' }
        $Estado = Obtener-Estado
        if ($Estado.IndicePreparado) { throw 'Commit no puede continuar: hay cambios ya preparados en el índice.' }
        if ($Estado.OperacionesEnCurso.Count -gt 0) { throw "Commit no puede continuar: hay una operación Git en curso ($($Estado.OperacionesEnCurso -join ', '))." }
        $Relacion = Actualizar-ReferenciaRemota
        if ($Relacion.SoloRemoto -gt 0) { throw 'Commit no puede continuar: la rama local está atrasada o ha divergido.' }
        Exigir-Git 'add', '--', '.gitignore', 'AGENTS.md', 'skills' | Out-Null
        $RutaDocumentacion = 'backlog/README.md'
        $DocumentacionEnIndice = Ejecutar-Git 'ls-files', '--error-unmatch', $RutaDocumentacion
        if ($DocumentacionEnIndice.CodigoSalida -eq 0 -and -not (Test-Path -LiteralPath (Join-Path $RutaRaiz $RutaDocumentacion) -PathType Leaf)) {
            Exigir-Git 'add', '-u', '--', $RutaDocumentacion | Out-Null
        }
        $Preparado = Ejecutar-Git 'diff', '--cached', '--quiet'
        if ($Preparado.CodigoSalida -eq 0) { Write-Output 'No hay cambios permitidos para confirmar; no se creó un commit.'; break }
        if ($Preparado.CodigoSalida -ne 1) { throw "No fue posible revisar los cambios preparados. $($Preparado.Salida -join [Environment]::NewLine)" }
        Write-Output 'Diff preparado:'; Exigir-Git 'diff', '--cached'; Exigir-Git 'commit', '-m', $Mensaje | Out-Null; Write-Output 'Commit creado correctamente.'; break
    }
    'Push' {
        $Estado = Obtener-Estado; Exigir-Estado-Limpio $Estado 'Push'; $Relacion = Actualizar-ReferenciaRemota
        if ($Relacion.SoloRemoto -gt 0) { throw 'Push no puede continuar: la rama local está atrasada o ha divergido.' }
        if ($Relacion.SoloLocal -eq 0) { Write-Output 'No hay commits locales para publicar.'; break }
        Exigir-Git 'push', 'origin', 'main' | Out-Null; Write-Output 'Push completado correctamente.'; break
    }
}

# Historial de versiones
# v1.0 — 08/10/2026: limita el sincronizador a instrucciones y skills; admite sólo retirar el backlog legado exacto.
# v1.1 — 08/10/2026: deja de incluir backlog/ y admite sólo retirar el README rastreado.

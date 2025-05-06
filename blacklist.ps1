# Lista negra de termos proibidos (personalize com suas palavras-chave)
$blockedTerms = @("hack", "violência", "porno", "safada", "safadas", "xxx","nua", "pelada", "sem roupa", "hentai", "ecchi", "sensual", "gore", "multilação","decaptação", "multilado", "decaptado","xvideos", "pornhub", "redtube", "pornografia", "pinto", "buceta", "penis", "vagina", "peito", "peitos", "safadinha", "porra", "caralho", "vagabunda", "putaria", "xoxota", "putaria", "nazi", "holocausto", "only" )

# Loop infinito para monitorar o Edge
while ($true) {
    # Obtém todos os processos do Microsoft Edge
    $edgeProcesses = Get-Process "msedge" -ErrorAction SilentlyContinue
    
    if ($edgeProcesses) {
        foreach ($proc in $edgeProcesses) {
            $windowTitle = $proc.MainWindowTitle
            
            # Verifica se o título da janela contém algum termo bloqueado
            foreach ($term in $blockedTerms) {
                if ($windowTitle -match $term) {
                    Write-Host "[BLOQUEADO] Termo proibido detectado: '$term' (Janela: $windowTitle)"
                    
                    # Fecha a aba/processo do Edge
                    Stop-Process -Id $proc.Id -Force
                    
                    # Opcional: Abre uma página segura (como about:blank)
                    Start-Process "msedge.exe" "portal.supergeeks.school"
                    break
                }
            }
        }
    }
    
    # Intervalo de verificação (5 segundos)
    Start-Sleep -Seconds 3
}

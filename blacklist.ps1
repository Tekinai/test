$localImagePath = "$env:TEMP\SuperGeeks_1920x1080.jpg"

# Baixa a imagem do GitHub
$imageUrl = "https://raw.githubusercontent.com/Tekinai/test/refs/heads/main/SuperGeeks_1920x1080.jpg"
Invoke-WebRequest -Uri $imageUrl -OutFile $localImagePath -UseBasicParsing

# Define o papel de parede
Function Set-Wallpaper {
    param (
        [string]$ImagePath
    )
    Add-Type -TypeDefinition @"
    using System;
    using System.Runtime.InteropServices;
    public class Wallpaper {
        [DllImport("user32.dll", CharSet = CharSet.Auto)]
        public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
    }
"@
    [Wallpaper]::SystemParametersInfo(20, 0, $ImagePath, 3)
}

# Aplica a imagem
Set-Wallpaper -ImagePath $localImagePath
Write-Host "Papel de parede alterado com sucesso!" -ForegroundColor Green





# Start-Process "msedge.exe" "https://tse3.mm.bing.net/th/id/OIP.V2yQ-azofTt-7JKCIKhc_wHaLy?rs=1&pid=ImgDetMain&o=7&rm=3"







# Lista negra de termos proibidos
$blockedTerms = @("hack", "violência", "porno", "safada", "safadas", "xxx","nua", "pelada", "sem roupa", "hentai", "ecchi", "sensual", "multilação","decaptação", "multilado", "decaptado","xvideos", "pornhub", "redtube", "pornografia", "pinto", "buceta", "penis", "vagina", "peito", "peitos", "safadinha", "porra", "caralho", "vagabunda", "putaria", "xoxota", "putaria", "nazi", "holocausto", "only", "hitler" )

# Loop infinito para monitorar o Edge
$time = 0
while ($time -le 120) {
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
                    
                    #Abre uma página segura (como about:blank)
                    Start-Process "msedge.exe" "portal.supergeeks.school"
                    break
                }
            }
        }
    }
    
    # Intervalo de verificação (3 segundos)
    Start-Sleep -Seconds 3
	$time += 3
}

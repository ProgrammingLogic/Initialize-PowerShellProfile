# Aliases with arguments
#
# We have to define a function and pass args into it, because Set-Alias does not support
# passing arguments into commands.
function gitc { git commit --verbose @args }
function gitp { git push @args }
function gitpu { git pull @args }
function gita { git add @args }

# Set the PowerShell prompt
function prompt
{
    # Set the window title to the full path, so that way we aren't taking up so much space with 
    #   with the path.
    $Host.UI.RawUI.WindowTitle = Get-Location

    $currentTime = Get-Date -Format "dddd MM/dd/yyyy HH:mm"
    Write-Host "[$currentTime] " -NoNewLine -ForegroundColor 'Blue'

    $parentDirectory = Get-Location `
        | Split-Path -Parent -ErrorAction SilentlyContinue `
        | Split-Path -Leaf -ErrorAction SilentlyContinue

    If ($parentDirectory) {
        Write-Host "$parentDirectory\" -NoNewLine
    }

    $currentDirectory = Get-Location | Split-Path -Leaf
    Write-Host "$currentDirectory" -NoNewLine

    $arrows = '>'
    if ($NestedPromptLevel -gt 0) { $arrows *= (1 + $NestedPromptLevel) }
    Write-Host "$arrows" -NoNewLine

    # For some reason, the PowerShell prompt appends "PS " to the end if this isn't 
    #   provided.
    ' '
}

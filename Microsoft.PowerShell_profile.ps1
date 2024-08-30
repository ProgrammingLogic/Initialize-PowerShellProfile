# Aliases with arguments
#
# We have to define a function and pass args into it, because Set-Alias does not support
# passing arguments into commands.
function gitc { git commit --verbose @args }
function gitps { git push @args }
function gitpu { git pull @args }
function gita { git add @args }

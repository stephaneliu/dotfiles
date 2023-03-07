# Use modern regexps for grep show color when `grep` is the final command
# but not when piping into something else because the added color codes will
# mess up the expected input
#               --- lines before match
#               |    ---lines after match
#               |    |    ---line numbers
#               |    |    |
alias -g rg="rg -A 2 -B 2 -n --color=auto"

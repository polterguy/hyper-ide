# Exchange COMMIT MESSAGE to whatever you want it to be
VAR1="$(git add .)"
VAR2="$(git commit -a -m 'COMMIT MESSAGE')"
VAR3="$(git push --all)"
echo "${VAR1}"
echo "${VAR2}"
echo "${VAR3}"

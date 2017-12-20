# This will will add all changes to your existing files, and commit
# them to your local repository.
#
# Notice, it WILL NOT PUSH your changes to the remote repo.
#
# Add a COMMIT MESSAGE below.
VAR1="$(git add .)"
VAR2="$(git commit -a -m 'COMMIT MESSAGE')"
echo "${VAR1}"
echo "${VAR2}"

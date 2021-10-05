#!/bin/sh

git filter-branch --env-filter '
OLD_EMAIL="xandernaumenko@gmail.com"
CORRECT_NAME="misprit7"
CORRECT_EMAIL="xandernaumenko@gmail.com"
if [ "$GIT_AUTHOR_EMAIL" = "$OLD_EMAIL" ]
then
    export GIT_AUTHOR_NAME="$CORRECT_NAME"
    export GIT_AUTHOR_EMAIL="$CORRECT_EMAIL"
    export GIT_COMMITTER_NAME="$CORRECT_NAME"
    export GIT_COMMITTER_EMAIL="$CORRECT_EMAIL"
fi
' --tag-name-filter cat -- --branches --tags
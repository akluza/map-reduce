#!/usr/bin/env bash
echo "Your git name?"
read NAME
echo "Your git email?"
read EMAIL
echo "Follow chmod file properties? true|false"
read FILEPROPS
git config user.name "$NAME"
git config user.email "$EMAIL"
git config core.fileMode "$FILEPROPS"
exit 0

#!/bin/bash
FOLDER="../roles/basic/users/public_keys"
FILE="all_ssh_keys"

rm "$FOLDER/$FILE"
for filename in $(ls $FOLDER)
do
  if ! [ "$filename" = "$FILE" ]; then
     cat "$FOLDER/$filename" >> $FOLDER/$FILE
  fi
done;
rsync --progress -ax -e 'ssh -p23' "$FOLDER/$FILE" u220998@u220998.your-storagebox.de:./.ssh/authorized_keys
rm "$FOLDER/$FILE"
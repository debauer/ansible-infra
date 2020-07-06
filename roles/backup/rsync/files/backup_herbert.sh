#!/bin/bash
rsync -axP --delete /home /media/ext_backup/herbert
rsync -axP --delete /media/raid1 /media/ext_backup/herbert
rsync -axP --delete /media/raid5 /media/ext_backup/herbert
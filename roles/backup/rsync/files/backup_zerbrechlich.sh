#!/bin/bash
rsync -avz --exclude-from='exclude_zerbrechlich' --progress /home/debauer/* root@herbert:/media/raid5/backups/zerbrechlich/home/debauer

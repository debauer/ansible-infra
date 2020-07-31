#!/bin/bash
rsync --progress -ax -e 'ssh -p23' /var/vmail u220998@u220998.your-storagebox.de:./backups/mail/var/vmail
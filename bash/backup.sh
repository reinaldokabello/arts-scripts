#!/bin/bash

# Diretórios de origem (pastas que deseja fazer backup)
ORIGEM="/home/seu-usuario/documentos /home/seu-usuario/imagens"

# Diretório de destino
DESTINO="/backup/diario"

# Arquivo de log
LOG="/var/log/backup.log"

# Data e hora atual
DATA=$(date '+%Y-%m-%d %H:%M:%S')

# Executa o rsync
rsync -av --delete $ORIGEM $DESTINO >> $LOG 2>&1

# Verifica se o backup foi bem-sucedido
if [ $? -eq 0 ]; then
    echo "[$DATA] Backup concluído com sucesso." >> $LOG
else
    echo "[$DATA] ERRO: Falha no backup!" >> $LOG
fi

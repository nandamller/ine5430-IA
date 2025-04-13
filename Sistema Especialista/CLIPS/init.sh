#!/bin/bash

# Verifica se o CLIPS está instalado
if ! command -v clips &> /dev/null
then
    echo "CLIPS não encontrado! Por favor, instale o CLIPS."
    exit 1
fi

# Defina o nome do arquivo CLIPS (substitua pelo nome do seu arquivo)
ARQUIVO_CLIPS="sistema_especialista.clp"

# Verifica se o arquivo CLIPS existe
if [ ! -f "$ARQUIVO_CLIPS" ]; then
    echo "Arquivo CLIPS não encontrado: $ARQUIVO_CLIPS"
    exit 1
fi

# Executa o CLIPS em modo batch (sem a interface interativa) e carrega o arquivo
echo "Iniciando CLIPS e carregando o arquivo $ARQUIVO_CLIPS..."
clips -batch -f "$ARQUIVO_CLIPS" -e "(run)" -e "(exit)"

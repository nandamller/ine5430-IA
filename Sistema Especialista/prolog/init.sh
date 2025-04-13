#!/bin/bash

# Verifica se o SWI-Prolog está instalado
if ! command -v swipl &> /dev/null
then
    echo "SWI-Prolog não encontrado! Por favor, instale o SWI-Prolog."
    exit 1
fi

# Defina o nome do arquivo Prolog (substitua pelo nome do seu arquivo)
ARQUIVO_PROLOG="sistema_especialista.pl"

# Verifica se o arquivo Prolog existe
if [ ! -f "$ARQUIVO_PROLOG" ]; then
    echo "Arquivo Prolog não encontrado: $ARQUIVO_PROLOG"
    exit 1
fi

# Inicia o SWI-Prolog e carrega o arquivo
echo "Iniciando SWI-Prolog e carregando o arquivo $ARQUIVO_PROLOG..."
swipl -s "$ARQUIVO_PROLOG" -g "main, halt."

# Aqui você pode definir o predicado principal (main) se necessário, ou fazer outras operações.

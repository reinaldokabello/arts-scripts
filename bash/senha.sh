#!/bin/bash
# senha.sh - Gera uma senha aleatória de 16 caracteres

senha=$(openssl rand -base64 12)
echo "Senha gerada: $senha"


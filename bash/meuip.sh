#!/bin/bash
# meuip.sh - Mostra o IP público da conexão

ip=$(curl -s ifconfig.me)
echo "Seu IP público é: $ip"

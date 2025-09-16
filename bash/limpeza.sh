#!/bin/bash
# limpeza.sh - Limpa pacotes e caches do sistema

sudo apt update
sudo apt autoremove -y
sudo apt clean
sudo journalctl --vacuum-time=7d

echo "Sistema limpo!"

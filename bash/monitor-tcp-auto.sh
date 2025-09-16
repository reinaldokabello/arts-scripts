#!/bin/bash
# monitor-tcp-auto.sh - Monitora pacotes TCP/UDP na interface ativa automaticamente

# Verifica se o tcpdump está instalado
if ! command -v tcpdump &>/dev/null; then
    echo "Erro: instale o tcpdump para usar este script."
    exit 1
fi

# Detecta a interface ativa (não loopback)
interface=$(ip route | grep '^default' | awk '{print $5}')

if [ -z "$interface" ]; then
    echo "Não foi possível detectar a interface ativa."
    exit 1
fi

echo "Interface ativa detectada: $interface"
echo "Monitorando tráfego na interface $interface..."
echo "Pressione Ctrl+C para parar."

# Mostra os pacotes com IPs de origem/destino e portas
sudo tcpdump -i "$interface" -n

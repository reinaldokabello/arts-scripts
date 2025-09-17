#!/bin/bash
# scan-rede.sh - Open Port

# Verifica se o nmap está instalado
if ! command -v nmap &>/dev/null; then
    echo "Erro: instale o nmap para usar este script."
    exit 1
fi

# Detecta interface ativa e IP da máquina
interface=$(ip route | grep '^default' | awk '{print $5}')
ip_maquina=$(ip -4 addr show $interface | grep -oP '(?<=inet\s)\d+(\.\d+){3}')

if [ -z "$ip_maquina" ]; then
    echo "Não foi possível detectar o IP da máquina."
    exit 1
fi

# Determina a rede local (assumindo máscara /24)
rede=$(echo $ip_maquina | awk -F. '{print $1"."$2"."$3".0/24"}')

echo "Interface ativa: $interface"
echo "IP da máquina: $ip_maquina"
echo "Rede detectada: $rede"
echo "Escaneando hosts ativos na rede... (isso pode levar alguns minutos)"

# Escaneia hosts ativos (-sn = ping scan)
hosts_ativos=$(nmap -sn $rede | grep "Nmap scan report for" | awk '{print $5}')

if [ -z "$hosts_ativos" ]; then
    echo "Nenhum host ativo detectado."
    exit 0
fi

echo "Hosts ativos encontrados:"
echo "$hosts_ativos"
echo ""
echo "Escaneando portas abertas de cada host..."

# Loop para escanear portas comuns de cada host
for host in $hosts_ativos; do
    echo "---- $host ----"
    nmap -Pn -sS -T4 --top-ports 50 "$host" | grep "open"
    echo ""
done

echo "Scan finalizado."

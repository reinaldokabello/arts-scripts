#!/bin/bash
# firewall.sh -  simples  firewall

# Verifica se está rodando como root
if [ "$EUID" -ne 0 ]; then
    echo "Execute como root: sudo $0"
    exit 1
fi

# Limpa regras antigas
iptables -F
iptables -X
iptables -t nat -F
iptables -t nat -X
iptables -t mangle -F
iptables -t mangle -X

# Política padrão (bloqueia tudo)
iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT

# Permitir loopback
iptables -A INPUT -i lo -j ACCEPT
iptables -A OUTPUT -o lo -j ACCEPT

# Permitir tráfego da rede local (modifique conforme sua rede)
REDE_LOCAL="192.168.1.0/24"
iptables -A INPUT -s $REDE_LOCAL -j ACCEPT

# Permitir conexões já estabelecidas
iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT

# Permitir SSH
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Permitir HTTP/HTTPS
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Log para pacotes bloqueados (opcional)
iptables -A INPUT -j LOG --log-prefix "IPTABLES-DROP: " --log-level 4

echo "Firewall configurado com iptables."

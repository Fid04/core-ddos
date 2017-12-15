#!/bin/sh
# Modifica o endereço IP dos pacotes vindos da máquina 192.168.1.2 da rede interna
# que tem como destino a interface eth1 para 200.200.217.40 (que é o nosso endereço
# IP da interface ligada a Internet).
# iptables -t nat -A POSTROUTING -s 192.168.1.2 -o eth1 -j SNAT --to 200.200.217.40

#Modifica o endereço IP de origem de todas as máquinas da rede 192.168.1.0/24 que tem o destino a interface eth0 para 200.241.200.40 a 200.241.200.50. O endereço IP selecionado é escolhido de acordo com o último IP alocado.

#iptables -t nat -A POSTROUTING -s 192.168.1.0/24 -o eth0 -j SNAT --to 200.200.217.40-200.200.217.50

# A diferença é que o alvo é -j MASQUERADE. O comando abaixo faz IP Masquerading de todo o tráfego de 192.168.1.0 indo para a interface eth0: O endereço IP dos pacotes vindos de 192.168.1.0 são substituídos pelo IP oferecido pelo seu provedor de acesso no momento da conexão, quando a resposta é retornada a operação inversa é realizada para garantir que a resposta chegue ao destino. Nenhuma máquina da internet poderá ter acesso direto a sua máquina conectava via Masquerading. Para fazer o IP Masquerading de todas as máquinas da rede 192.168.1.*:
iptables -t nat -A POSTROUTING -s 10.0.0.0/24 -o eth2 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 10.0.1.0/24 -o eth2 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 10.0.2.0/24 -o eth2 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 10.0.3.0/24 -o eth2 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 10.0.4.0/24 -o eth2 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 10.0.5.0/24 -o eth2 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 10.0.6.0/24 -o eth2 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 10.0.7.0/24 -o eth2 -j MASQUERADE

iptables -t nat -A POSTROUTING -s 192.168.2.0/24 -o eth2 -j MASQUERADE

# Modifica o endereço IP destino dos pacotes de 192.168.42.129/24 vindo da interface eth2 para 10.0.5.1
#iptables -A FORWARD -i eth2 -d 10.0.0.10 -j ACCEPT

#iptables -t nat -A PREROUTING -i eth2 -s 192.168.42.129 -j DNAT --to-destination 10.0.0.0/24 # → IP do servidor

iptables -t nat -A PREROUTING -i eth2 -j DNAT --to 192.168.2.99

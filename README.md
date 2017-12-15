# core-ddos

# Colaboradores: 
    Professor Dr. Arthur Callado/ Alunos, Heli Amaral e Iranildo Fidelis 

# Projeto
    Projeto de disciplina, como parte dos requisitos para obtenção de nota na disciplina de Análise de 
    Desempenho de Redes de Computadores, do Curso Superior Tecnólogico de Redes de Computadores (UFC/ Quixadá). 
    Tem como finalidade, avaliar técnicas de DOS para ataque de negação de serviço distribuído (DDOS) usando 
    CORE emulador de redes. 
    


# Objetivo
    Comparar e determinar qual (is) das técnicas seguintes é mais eficiente para ataque de negação de 
    serviço distribuído:

 			TCP SYN flood       |         UDP flood         |         HTTP flood

# TCP SYN flood 
    Envia muitos pacotes SYN para o servidor e ignorar os pacotes SYN + ACK retornados pelo servidor  

# UDP flood   
    Servidor recebe tráfego, não consegue processar todas as solicitações, envia pacotes de "destino 
    inacessível" - ICMP, consumindo sua própria banda.  

# HTTP flood 
    Ataque que visa a camada de aplicação, consiste de um conjunto de solicitações HTTP GET ou POST 
    enviadas para um servidor alvo (pedidos são legítimos e numerosos)

# MÉTRICAS

    → Tempo médio até a falha (segundos)
    Tempo necessário para ocasionar indisponibilidade do serviço
                   
    → Throughput (Mbps)              
    Volume médio de tráfego processado em função do tempo de ataque
    
    
# FATORES E NÍVEIS

    → Técnicas de ataque          
      TCP SYN flood
      UDP flood
      HTTP flood
                   
    → Número de máquinas:  
      1,  5,  8, 16


# Descrição para replicar o experimento

        Considere a seguinte estrutura de diretórios:
        
        core-ddos
          |
          |__ configs         # shell e python scripts utilizados no CORE emulador
          |__ R               # Rscripts e gráficos gerados com R  
          |__ topologia       # Conjunto de imagens utilizadas na topologia implementada 
          |__ trace           # Contém um conjunto de pastas e arquivos utilizados para armazenar 
                |               infomações de monitoramento:.log, .dat, .csv, .xlsx, .txt, .pcap 
                |               (1 máquina por técnica - demais pcap são muito grandes)                    
                |                
                |__ imgs      # (png) Conjunto de arquivos de imagem gerados a partir dos .pcap e .xlsx 
                |
                |__ udp
                |
                |__ tcp
                |
                |__ http
                
               ... em edição
                    

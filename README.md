# core-ddos-academic

# Colaboradores: 
    Professor Dr. Arthur Callado/ Alunos, Heli Amaral e Iranildo Fidelis 

# Projeto
    Projeto de disciplina, como parte dos requisitos para obtenção de nota na disciplina de Análise de Desempenho de Redes de    Computadores, do Curso Superior Tecnólogico de Redes de Computadores (UFC/ Quixdá). Tem como finalidade, avaliar técnicas de DOS para ataque de negação de serviço distribuído (DDOS) usando CORE emulador de redes. 


# Objetivo
    Comparar e determinar qual (is) das técnicas seguintes é mais eficiente para ataque de negação de serviço distribuído:

 			TCP SYN flood       |         UDP flood         |         HTTP flood

# TCP SYN flood 
    envia muitos pacotes SYN para o servidor e ignorar os pacotes SYN + ACK retornados pelo servidor  

# UDP flood   
    servidor recebe tráfego, não consegue processar todas as solicitações, envia pacotes de "destino inacessível" ICMP, consumindo sua própria banda.  

# HTTP flood 
    ataque que visa a camada de aplicação, consiste de um conjuntos de solicitações HTTP GET ou POST enviadas para um servidor alvo   (pedidos parecem ser legítimos)

# MÉTRICAS

# Tempo médio até a falha (segundos)
    Tempo necessário para ocasionar indisponibilidade do serviço
                   
# Throughput (Mbps)              
    Volume médio de tráfego processado em função do tempo de ataque
    
    
# FATORES E NÍVEIS

    # Técnicas de ataque          
      TCP SYN flood
      UDP flood
      HTTP flood
                   
    # Número de máquinas:  
      1,  5,  8, 16



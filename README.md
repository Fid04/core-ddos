# Colaboradores: 
    Professor Dr. Arthur Callado¹/ Alunos, Heli Amaral² e Iranildo Fidelis³
    	¹
    	² 
    	³ fidelis.lilia@gmail.com

# core-ddos 
    Projeto de disciplina, como parte dos requisitos para obtenção de nota na disciplina de Análise de 
    Desempenho de Redes de Computadores, do Curso Superior Tecnólogico de Redes de Computadores (UFC/ Quixadá). 
    Tem como finalidade, avaliar técnicas de DOS para ataque de negação de serviço distribuído (DDOS) usando 
    CORE emulador de redes. 
    
![alt text](https://raw.githubusercontent.com/Fid04/core-ddos/master/topo-vf.png)

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

# Métricas

    → Tempo médio até a falha (segundos)
        Tempo necessário para ocasionar indisponibilidade do serviço

![alt text](https://raw.githubusercontent.com/Fid04/core-ddos/master/R/mtf.png)
                   
    → Throughput (Mbps)              
        Volume médio de tráfego processado em função do tempo de ataque

![alt text](https://raw.githubusercontent.com/Fid04/core-ddos/master/R/vazao.png)
        
    → Carga de trabalho (%)
        Utilização de recursos do servidor e do serviço Apache2 como memória, cpu, swap, disco, etc 
        em função do tempo de ataque 

	# Utilização de recursos do servidor (Ubuntu Server 17.10)

![alt text](https://raw.githubusercontent.com/Fid04/core-ddos/master/trace/imgs/servidor.png)

	# Utilização de recursos do serviço (Web Apache2)

![alt text](https://raw.githubusercontent.com/Fid04/core-ddos/master/trace/imgs/apache.png)

   
# Fatores e níveis

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
                |__ udp       # arquivos de logs udp: contém medições sobre a técnica Udp flood
                |
                |__ tcp       # arquivos de logs tcp: contém medições sobre a técnica Tcp flood
                |
                |__ http      # arquivos de logs http: contém medições sobre a técnica Http flood
                
             
                    
# Procedimento inicial 

  	Após a instalação e execução do Common Open Research Emulator (CORE)* faça o import
        do arquivo ddos.imn. Certifique se a topologia apresenta alguma inconsistência em relação a 
        imagem da topologia do projeto core-ddos (topologia-planejada).


  	*CORE → https://www.nrl.navy.mil/itd/ncs/products/core 

# Configurando paths para scripts de serviços






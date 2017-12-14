#!/usr/bin/env Rscript

#SEED=$(( ( RANDOM % 10000 )  + 1 ))
# media com Udp
x<-read.table("/home/fidelis/.core/R/mtf.csv", sep=",", h=T)
# media com 1 node
m1u<- x$mudp[8]
m1t<- x$mtcp[11]
m1h<- x$mhttp[12]

# media com 5 node
m5u<- x$mudp[9]
m5t<- x$mtcp[10]
m5h<- x$mhttp[3]

# media com 8 node
m8u<- x$mudp[5]
m8t<- x$mtcp[6]
m8h<- x$mhttp[2]

# media com 16 node
m16u<- x$mudp[4]
m16t<- x$mtcp[7]
m16h<- x$mhttp[1]

# sd com 1 node
s1u<- x$sdu[8]
s1t<- x$sdt[11]
s1h<- x$sdh[12]

# sd com 5 node
s5u<- x$sdu[9]
s5t<- x$sdt[10]
s5h<- x$sdh[3]

# sd com 8 node
s8u<- x$sdu[5]
s8t<- x$sdt[6]
s8h<- x$sdh[2]

# sd com 16 node
s16u<- x$sdu[4]
s16t<- x$sdt[7]
s16h<- x$sdh[1]

# confiança de 95% 
transfz <- 1.96

# limit udp com 1 node
iu<- x$interval[8] # tamanho da amostra
udpn<- iu - transfz*s1u/sqrt(length(iu))
udpp<- iu + transfz*s1u/sqrt(length(iu))

# limit tcp com 1 node
it<- x$interval[11]
tcpn<- it - transfz*s1t/sqrt(length(it))
tcpp<- it + transfz*s1t/sqrt(length(it))

# limit http com 1 node
ih<- x$interval[12]
httpn<- ih - transfz*s1h/sqrt(length(ih))
httpp<- ih + transfz*s1h/sqrt(length(ih))

#-------------------------------------------------------------------------------------
# plot gráfico
# udp blue
png("mtf.png", width = 620, height = 620)
matplot(m1u, iu, col="blue",pch=15,ylab="Tempo (s)", xlab="Número de zumbis", main="Tempo médio (s) para falha em função do número\n de máquinas envolvidas no ataque DDOS",ylim=c(5, 300),xlim=c(1,18))

# tcp red
points(m1t, it, col="red", pch=15)

# http green
points(m1h, ih, col="green", pch=15)

arrows(c(1,1),c(x$interval[8],x$interval[8]),c(1,1),c(udpn+5,udpp-5),col="blue",angle=90)
arrows(c(1,1),c(x$interval[11],x$interval[11]),c(1,1),c(tcpn+5,tcpp-5),col="red",angle=90)
arrows(c(1,1),c(x$interval[12],x$interval[12]),c(1,1),c(httpn+5,httpp-5),col="green",angle=90)
#--------------------------------------------------------------------------------------

# limit udp com 5 node
iu<- x$interval[9] # tamanho da amostra
udpn<- iu - transfz*s5u/sqrt(length(iu))
udpp<- iu + transfz*s5u/sqrt(length(iu))

# limit tcp com 5 node
it<- x$interval[10]
tcpn<- it - transfz*s5t/sqrt(length(it))
tcpp<- it + transfz*s5t/sqrt(length(it))

# limit http com 5 node
ih<- x$interval[3]
httpn<- ih - transfz*s5h/sqrt(length(ih))
httpp<- ih + transfz*s5h/sqrt(length(ih))

# udp blue
points(m5u, iu, col="blue", pch=15)

# tcp red
points(m5t, it, col="red", pch=15)

# http green
points(m5h, ih, col="green", pch=15)

arrows(c(5,5),c(x$interval[9],x$interval[9]),c(5,5),c(udpn+1,udpp-5),col="blue",angle=90)
arrows(c(5,5),c(x$interval[10],x$interval[10]),c(5,5),c(tcpn+5,tcpp-5),col="red",angle=90)
arrows(c(5,5),c(x$interval[3],x$interval[3]),c(5,5),c(httpn+8,httpp-5),col="green",angle=90)
#--------------------------------------------------------------------------------------

# limit udp com 8 node
iu<- x$interval[5] # tamanho da amostra
udpn<- iu - transfz*s8u/sqrt(length(iu))
udpp<- iu + transfz*s8u/sqrt(length(iu))

# limit tcp com 8 node
it<- x$interval[6]
tcpn<- it - transfz*s8t/sqrt(length(it))
tcpp<- it + transfz*s8t/sqrt(length(it))

# limit http com 8 node
ih<- x$interval[2]
httpn<- ih - transfz*s8h/sqrt(length(ih))
httpp<- ih + transfz*s8h/sqrt(length(ih))

# udp blue
points(m8u, iu, col="blue", pch=15)

# tcp red
points(m8t, it, col="red", pch=15)

# http green
points(m8h, ih, col="green", pch=15)

arrows(c(8,8),c(x$interval[5],x$interval[5]),c(8,8),c(udpn+5,udpp-1),col="blue",angle=90)
arrows(c(8,8),c(x$interval[6],x$interval[6]),c(8,8),c(tcpn+5,tcpp-5),col="red",angle=90)
arrows(c(8,8),c(x$interval[2],x$interval[2]),c(8,8),c(httpn+5,httpp-8),col="green",angle=90)
#-------------------------------------------------------------------------------------

# limit udp com 16 node
iu<- x$interval[4] # tamanho da amostra
udpn<- iu - transfz*s16u/sqrt(length(iu))
udpp<- iu + transfz*s16u/sqrt(length(iu))

# limit tcp com 16 node
it<- x$interval[7]
tcpn<- it - transfz*s16t/sqrt(length(it))
tcpp<- it + transfz*s16t/sqrt(length(it))

# limit http com 16 node
ih<- x$interval[1]
httpn<- ih - transfz*s16h/sqrt(length(ih))
httpp<- ih + transfz*s16h/sqrt(length(ih))

# udp blue
points(m16u, iu, col="blue", pch=15)

# tcp red
points(m16t, it, col="red", pch=15)

# http green
points(m16h, ih, col="green", pch=15)

arrows(c(16,16),c(x$interval[4],x$interval[4]),c(16,16),c(udpn+1,udpp-5),col="blue",angle=90)
arrows(c(16,16),c(x$interval[7],x$interval[7]),c(16,16),c(tcpn+5,tcpp-5),col="red",angle=90)
arrows(c(16,16),c(x$interval[1],x$interval[1]),c(16,16),c(httpn+8,httpp-5),col="green",angle=90)
#--------------------------------------------------------------------------------------
# udp 8954
lines(c(1,5,8,16),c(x$interval[8], x$interval[9], x$interval[5], x$interval[4]), col="blue", lty=2)
# tcp 111067
lines(c(1,5,8,16),c(x$interval[11], x$interval[10], x$interval[6], x$interval[7]), col="red", lty=2)
# http 12321
lines(c(1,5,8,16),c(x$interval[12], x$interval[3], x$interval[2], x$interval[1]), col="green", lty=2)

#arrows(c(1,1),c(x$interval[8],x$interval[8]),c(1,1),c(udpn,udpp),col="blue",angle=90)
#arrows(c(15,15),c(mudpc,mudpc),c(15,15),c(iudpcn,iudpcp),col=2,angle=90)
#arrows(c(15,15),c(mtcp,mtcp),c(15,15),c(itcpn,itcpp),col="black",angle=90)
dev.off()



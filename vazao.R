#!/usr/bin/env Rscript

#SEED=$(( ( RANDOM % 10000 )  + 1 ))
# media com Udp
x<-read.table("/home/fidelis/.core/R/vazao.csv", sep=",", h=T)
# media com 1 node
m1u<- x$udp[1]
m1t<- x$tcp[1]
m1h<- x$http[1]

# media com 5 node
m5u<- x$udp[2]
m5t<- x$tcp[2]
m5h<- x$http[2]

# media com 8 node
m8u<- x$udp[3]
m8t<- x$tcp[3]
m8h<- x$http[3]

# media com 16 node
m16u<- x$udp[4]
m16t<- x$tcp[4]
m16h<- x$http[4]

# sd com 1 node
s1u<- x$sdu[1]
s1t<- x$sdt[1]
s1h<- x$sdh[1]

# sd com 5 node
s5u<- x$sdu[2]
s5t<- x$sdt[2]
s5h<- x$sdh[2]

# sd com 8 node
s8u<- x$sdu[3]
s8t<- x$sdt[3]
s8h<- x$sdh[3]

# sd com 16 node
s16u<- x$sdu[4]
s16t<- x$sdt[4]
s16h<- x$sdh[4]

# confiança de 95% 
transfz <- 1.96

# limit udp com 1 node
iu<- x$amostra[1] # tamanho da amostra
udpn<- m1u - transfz*s1u/sqrt(length(iu))
udpp<- m1u + transfz*s1u/sqrt(length(iu))

# limit tcp com 1 node
it<- x$amostra[1]
tcpn<- m1t - transfz*s1t/sqrt(length(it))
tcpp<- m1t + transfz*s1t/sqrt(length(it))

# limit http com 1 node
ih<- x$amostra[1]
httpn<- m1h - transfz*s1h/sqrt(length(ih))
httpp<- m1h + transfz*s1h/sqrt(length(ih))

#-------------------------------------------------------------------------------------
# plot gráfico
# udp blue
png("vazao.png", width = 620, height = 620)
matplot(x$nodes[1], m1u, col="blue",pch=15,ylab="Throughput (Mbps)", xlab="Número de zumbis", main="Throughput (Mbps) em função do número\n de máquinas envolvidas no ataque DDOS",ylim=c(0, 6.0),xlim=c(1,18))

# tcp red
points(x$nodes[1], m1t, col="red", pch=15)

# http green
points(x$nodes[1], m1h, col="green", pch=15)

arrows(c(1,1),c(m1u,m1u),c(1,1),c(udpn,udpp),col="blue",angle=90)
arrows(c(1,1),c(m1t,m1t),c(1,1),c(tcpn,tcpp),col="red",angle=90)
arrows(c(1,1),c(m1h,m1h),c(1,1),c(httpn,httpp),col="green",angle=90)

#--------------------------------------------------------------------------------------

# limit udp com 5 node
iu<- x$amostra[2] # tamanho da amostra
udpn<- m5u - transfz*s5u/sqrt(length(iu))
udpp<- m5u + transfz*s5u/sqrt(length(iu))

# limit tcp com 5 node
it<- x$amostra[2]
tcpn<- m5t - transfz*s5t/sqrt(length(it))
tcpp<- m5t + transfz*s5t/sqrt(length(it))

# limit http com 5 node
ih<- x$amostra[2]
httpn<- m5h - transfz*s5h/sqrt(length(ih))
httpp<- m5h + transfz*s5h/sqrt(length(ih))

# udp blue
points(x$nodes[2], m5u, col="blue", pch=15)

# tcp red
points(x$nodes[2],m5t, col="red", pch=15)

# http green
points(x$nodes[2],m5h, col="green", pch=15)

arrows(c(5,5),c(m5u,m5u),c(5,5),c(udpn,udpp),col="blue",angle=90)
arrows(c(5,5),c(m5t,m5t),c(5,5),c(tcpn,tcpp),col="red",angle=90)
arrows(c(5,5),c(m5h,m5h),c(5,5),c(httpn,httpp),col="green",angle=90)
#--------------------------------------------------------------------------------------

#--------------------------------------------------------------------------------------

# limit udp com 8 node
iu<- x$amostra[3] # tamanho da amostra
udpn<- m8u - transfz*s8u/sqrt(length(iu))
udpp<- m8u + transfz*s8u/sqrt(length(iu))

# limit tcp com 8 node
it<- x$amostra[3]
tcpn<- m8t - transfz*s8t/sqrt(length(it))
tcpp<- m8t + transfz*s8t/sqrt(length(it))

# limit http com 8 node
ih<- x$amostra[3]
httpn<- m8h - transfz*s8h/sqrt(length(ih))
httpp<- m8h + transfz*s8h/sqrt(length(ih))

# udp blue
points(x$nodes[3], m8u, col="blue", pch=15)

# tcp red
points(x$nodes[3],m8t, col="red", pch=15)

# http green
points(x$nodes[3],m8h, col="green", pch=15)

arrows(c(8,8),c(m8u,m8u),c(8,8),c(udpn,udpp),col="blue",angle=90)
arrows(c(8,8),c(m8t,m8t),c(8,8),c(tcpn,tcpp),col="red",angle=90)
arrows(c(8,8),c(m8h,m8h),c(8,8),c(httpn,httpp),col="green",angle=90)
#--------------------------------------------------------------------------------------

#-------------------------------------------------------------------------------------

# limit udp com 16 node
iu<- x$amostra[4] # tamanho da amostra
udpn<- m16u - transfz*s16u/sqrt(length(iu))
udpp<- m16u + transfz*s16u/sqrt(length(iu))

# limit tcp com 16 node
it<- x$amostra[4]
tcpn<- m16t - transfz*s16t/sqrt(length(it))
tcpp<- m16t + transfz*s16t/sqrt(length(it))

# limit http com 16 node
ih<- x$amostra[4]
httpn<- m16h - transfz*s16h/sqrt(length(ih))
httpp<- m16h + transfz*s16h/sqrt(length(ih))

# udp blue
points(x$nodes[4], m16u, col="blue", pch=15)

# tcp red
points(x$nodes[4], m16t, col="red", pch=15)

# http green
points(x$nodes[4], m16h, col="green", pch=15)

arrows(c(16,16),c(m16u,m16u),c(16,16),c(udpn,udpp),col="blue",angle=90)
arrows(c(16,16),c(m16t,m16t),c(16,16),c(tcpn,tcpp),col="red",angle=90)
arrows(c(16,16),c(m16h,m16h),c(16,16),c(httpn,httpp),col="green",angle=90)
#--------------------------------------------------------------------------------------
# udp 8954
lines(c(1,5,8,16),c(m1u,m5u,m8u,m16u), col="blue", lty=2)
# tcp 111067
lines(c(1,5,8,16),c(m1t,m5t,m8t,m16t), col="red", lty=2)
# http 12321
lines(c(1,5,8,16),c(m1h,m5h,m8h,m16h), col="green", lty=2)

dev.off()



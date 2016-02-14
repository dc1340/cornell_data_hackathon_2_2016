library(reshape)
library(ggplot2)

files=list.files('../bitcoin_agg_data/', full.names = T)

for (i in 1:9){ dat[[i]]=read.csv(files[[i]], header=T)}
combdat=dat[[1]]

labs=c("ATRCT","AVBLS","ETRAV","NADDU","NTRAN","NTRBL","NTREP","TOUTV","TRFEE")
head(dat[[1]])
for (i in 1:9) { colnames(dat[[i]])[[2]]=labs[[i]]}

combdat=dat[[1]]
for ( i in 2:9) { combdat=merge(combdat, dat[[i]], by='Date')}

mcomb=melt(combdat, id.vars = 'Date')
ggplot(mcomb)+geom_line(aes(x=Date, y=value, color=variable))

scale.combdat=cbind(as.Date(as.character(combdat$Date)), scale(combdat[, 2:9 ]))
head(scale.combdat)
head(combdat$Date)
colnames(scale.combdat)[[1]]='Date'

scale.combdat=data.frame(as.Date(as.character(combdat$Date)), scale(combdat[, 2:9 ]))

scale.combdat=data.frame(Date=as.Date(as.character(combdat$Date)), scale(combdat[, 2:9 ]))
scale.mdat=melt(scale.combdat, id.vars = 'Date')
ggplot(mcomb)+geom_line(aes(x=Date, y=value, color=variable))

ggplot(scale.mdat)+geom_line(aes(x=Date, y=value, color=variable))

write.table(scale.combdat, file='Scaled_BTC_Aggs_Table.txt', sep="\t", quote=F, col=T, row=F)

library(tidyverse)
library(ggplot2)
library(magrittr)
theme_set(theme_bw())

setwd("/home/pedrofw/Documentos/metodologia/reclamacoes-do-gf/")

avaliacoes <- read_csv("data/3-avaliacao-humana/avaliacoes-20181030.csv")
reclamacoes <-  read_csv("data/1-reclamacoes-selecionadas/20181610-reclamacoes-selecionadas.csv")

#inserindo colunas comprimento da reclamacao e do titulo
reclamacoes <- reclamacoes %>% mutate(reclamacão.length = str_length(reclamação),
                                      titulo.length = str_length(título))


# insere coluna com número de letras em capslock
reclamacoes$numero.de.capslock <- str_count(reclamacoes$reclamação, "\\b[A-Z]{2,}\\b")

########################### RESPOSTAS QUESTÕES 7 E 8 #######################################
##
# quantas reclamações tem discordância maior que 2?
avaliacoes %>% group_by(`ID da reclamação`) %>% 
  summarise(range = max(`Grau de insatisfação`) - min(`Grau de insatisfação`)) %>% 
  filter(range > 2) %>% count()



## Será que os tamanhos das reclamações ou títulos tem alguma relação com o nível de insatisfação?
reclamacoes %>% ggplot(aes(x=median(x = reclamacoes$reclamacão.length), y=str_length(reclamação))) + geom_point()
##reclamacoes %>% ggplot(aes(x=numero.de.capslock, y=numero.de.capslock)) + geom_point()
reclamacoes %>% ggplot(aes(x=median(x = reclamacoes$titulo.length), y=str_length(título))) + geom_point()


#############################################################################################

##


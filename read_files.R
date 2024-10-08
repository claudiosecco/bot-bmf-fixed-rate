# Este script cria o data frame di_pre a partir dos arquivos xls baixados
# Parte de um data.frame vazio e sava no arquivo bmf.Rdata
# No próximo uso, necessário criar feature para inserir novos registros

library(gnumeric)
library(stringr)
library(lubridate)
library(dplyr)
library(readr)

setwd("~/onedrive-personal/bmf")

files_names <- list.files()

vector_size <- length(files_names) * 300

di_pre <- data.frame( date = as.Date(rep(NA, vector_size)),
                      n_360 = integer(vector_size),
                      i_252 = numeric(vector_size),
                      i_360 = numeric(vector_size))

i <- 1
next_save <- 30000

tmp <- Map(function(file_name) {

  df <- read.gnumeric.sheet(file_name, top.left = 'A9') %>%
    filter(!is.na(V1)) %>%
    mutate(V2 = parse_number(V2, locale = locale(decimal_mark = ",")),
           V3 = parse_number(V3, locale = locale(decimal_mark = ",")))
  
  n <- nrow(df)
  
  di_pre$date[i:(i + n - 1)] <<- ymd(str_sub(file_name, 4, 11))
  di_pre$n_360[i:(i + n - 1)] <<- df$V1
  di_pre$i_252[i:(i + n - 1)] <<- df$V2
  di_pre$i_360[i:(i + n - 1)] <<- df$V3
  
  i <<- i + n
  
  if(i >= next_save) {
    save(di_pre, file = "/home/cvsecco/repos/bot-bmf-taxa-pre/bmf.Rdata")
    next_save <<- next_save + 30000
  }
  
}, files_names)

di_pre <- di_pre %>%
  filter(!is.na(date))

save(di_pre, file = "/home/cvsecco/repos/bot-bmf-taxa-pre/bmf.Rdata")

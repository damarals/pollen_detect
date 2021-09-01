library(tidyverse)

csv <- read_csv('output.csv') %>% 
  distinct(filename, .keep_all = T)

set.seed(1)

spec = c(TRAINING = .72, 
         VALIDATION = .18,
         TEST = .10)

g = sample(cut(
  seq(nrow(csv)), 
  nrow(csv)*cumsum(c(0,spec)),
  labels = names(spec)
))

pth <- '/content/gdrive/MyDrive/Pesquisa/Artigo Imagens/data/images/'

csv %>%
  mutate(set = g, .before = filename) %>%
  mutate(filename = paste0(pth, filename),
         xmin = xmin/width, xmax = xmax/width,
         ymin = ymin/height, ymax = ymax/height) %>%
  select(-width, -height) %>%
  add_column(ec1 = "", ec2 = "", .after = "ymin") %>%
  add_column(ec3 = "", ec4 = "", .after = "ymax") %>%
  write_csv('output_labeled.csv')
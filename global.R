library(shiny)
library(lubridate)
library(leaflet)
library(readr)
library(dplyr)
#library(DT)
library(ggplot2)
library(shinythemes)
library(shinyWidgets)
library(plotly)
library(shinyjs)
library(openxlsx)
library(shiny.i18n)

My_SDG <- readRDS("My_SDG")

My_SDG$Value <- as.numeric((My_SDG$Value))

pyt <- read.xlsx(xlsxFile = "Pytania_pl.xlsx",
                 colNames = TRUE) %>%
  mutate(praw=as.logical(praw))

# save(pyt, file="pytania.RData")

i18n <- Translator$new(translation_csvs_path = "data")
i18n$set_translation_language("pl")

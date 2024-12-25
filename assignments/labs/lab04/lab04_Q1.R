# install.packages("tidyverse")
library(tidyverse)
library(jsonlite)

data.file <- "data.json"
data.url <- "https://ods.railway.gov.tw/tra-ods-web/ods/download/dataResource/8ae4cabf6973990e0169947ed32454b9"
download.file(url = data.url, destfile = data.file)

data <- fromJSON(data.file) %>% filter(staCode == "1210", str_sub(trnOpDate, -2) == "01")
data$trnOpDate <- as.Date(data$trnOpDate, format = "%Y%m%d")
data$gateInComingCnt <- as.numeric(data$gateInComingCnt)
data$gateOutGoingCnt <- as.numeric(data$gateOutGoingCnt)

p <- ggplot(data, aes(x = trnOpDate, y = gateInComingCnt, group = 1)) +
    geom_line() +
    geom_point() +
    labs(title = "Hsin Chu Station", x = "Date", y = "Gate In Coming Count") +
    theme_minimal()
ggsave("plot.png")
print(p)
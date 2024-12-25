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

df <- data.frame(
    Month = integer(),
    Incoming_changes = numeric(),
    Outgoing_changes = numeric()
)

for (i in 2:nrow(data)) {
    new_row <- data.frame(
        Month = as.integer(format(data[i, "trnOpDate"], "%m")),
        Incoming_changes = data[i, "gateInComingCnt"] - data[i - 1, "gateInComingCnt"],
        Outgoing_changes = data[i, "gateOutGoingCnt"] - data[i - 1, "gateOutGoingCnt"]
    )
    df <- rbind(df, new_row)
}

print(df)
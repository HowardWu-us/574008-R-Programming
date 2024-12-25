library(jsonlite)
library(ggplot2)
library(lubridate)

data.url <- "https://opendata.cwa.gov.tw/fileapi/v1/opendataapi/F-D0047-055?Authorization=CWA-2C779C07-D293-4EA7-BB70-856D1C82B7FA&format=JSON"
data.file <- "Hsinchu_Weather_Forecast.json"
download.file(data.url, data.file)
data <- fromJSON(data.file)

Sys.getlocale()
Sys.setlocale("LC_CTYPE", "zh_TW.UTF-8")

my.location <- data$cwaopendata$dataset$locations$location
my.weatherElement <- my.location[[which(my.location$locationName == "東區"), "weatherElement"]]

my.T <- my.weatherElement[[which(my.weatherElement$elementName == "T"), "time"]]
my.maxT <- my.weatherElement[[which(my.weatherElement$elementName == "MaxT"), "time"]]
my.minT <- my.weatherElement[[which(my.weatherElement$elementName == "MinT"), "time"]]

my.df <- data.frame(
    time = ymd_hms(my.T$startTime, tz = "Asia/Taipei"),
    T_value = my.T$elementValue$value,
    max_T_value = my.maxT$elementValue$value,
    min_T_value = my.minT$elementValue$value
)

ggplot(my.df, aes(x = time, y = T_value, group = 1)) +
    geom_line(aes(y = min_T_value)) +
    geom_line(aes(y = max_T_value))
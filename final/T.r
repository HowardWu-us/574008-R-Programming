# # 安裝並載入所需套件
# install.packages("terra", type = "source")
install.packages("ggplot2")
install.packages("sf")
install.packages("rnaturalearth")
install.packages("rnaturalearthdata")
install.packages("leaflet")

library(ggplot2)
library(sf)
library(rnaturalearth)
library(rnaturalearthdata)
library(leaflet)
library(dplyr)

# brew install gdal proj geos udunits



earthquake_data <- read.csv("Eartquakes-1990-2023.csv")
head(earthquake_data)

tail(earthquake_data)

tsunami_data <- subset(earthquake_data, tsunami == TRUE, select = -c(tsunami))

# 使用 ggplot 繪製世界地圖和海嘯位置，使用顏色來表示規模
library(ggplot2)

# 載入世界地圖
world <- ne_countries(scale = "medium", returnclass = "sf")

# 繪製地圖
ggplot(data = world) +
  geom_sf() +
  geom_point(
             data = tsunami_data,
             aes(x = longitude, y = latitude, color = magnitudo),
             size = 1,
             alpha = 0.6) +
  scale_color_gradient(name = "Magnitude", low = "purple", high = "red") +
  theme_minimal() +
  labs(
       title = "Global Tsunami Distribution",
       subtitle = "Showing the locations and magnitudes of tsunamis",
       x = "Longitude",
       y = "Latitude")


five_years_data <- subset(
  earthquake_data,
  date >= as.Date("2018-01-01") & date <= as.Date("2023-8-31") & magnitudo >= 5
)
dim(five_years_data)

# 載入世界地圖和板塊邊界
world <- ne_countries(scale = "medium", returnclass = "sf")
plates <- st_read("https://github.com/fraxen/tectonicplates/blob/master/GeoJSON/PB2002_boundaries.json?raw=true")

ggplot(data = world) +
    geom_sf() +
    geom_point(data = five_years_data, aes(x = longitude, y = latitude, color = magnitudo), size = 2, alpha = 0.6) +
    scale_color_gradient(name = "Magnitude", low = "purple", high = "red") +
    theme_minimal() +
    geom_sf(data = plates, color = "green", size = 0.5) +
    labs(
        title = "Distribution",
        subtitle = "Showing the locations and magnitudes of tsunamis",
        x = "Longitude",
        y = "Latitude"
    )


dim(earthquake_data)

earthquakes_1990_2022 <- subset(
    earthquake_data,
    date >= as.Date("1990-01-01") & date < as.Date("2023-01-01")
)
dim(earthquakes_1990_2022)

colnames(earthquakes_1990_2022)

# earthquakes_2000_2022 <- earthquakes_2000_2022 %>%
#     mutate(
#         year = as.numeric(format(date, "%Y")),
#         month = as.numeric(format(date, "%m"))
#     )

earthquakes_1990_2022_magnitude_5 <- subset(
    earthquakes_1990_2022,
    magnitudo >= 5
)
dim(earthquakes_1990_2022_magnitude_5)

summarise_yearly_frequency <- function(data) {
    data %>%
        mutate(date = as.Date(date)) %>%
        mutate(year = format(date, "%Y")) %>%
        group_by(year) %>%
        summarise(count = n())
}

yearly_frequency_full <- summarise_yearly_frequency(earthquakes_1990_2022)
yearly_frequency_magnitude_5 <- summarise_yearly_frequency(earthquakes_1990_2022_magnitude_5)

yearly_frequency_full$m5rate <- yearly_frequency_magnitude_5$count / yearly_frequency_full$count

typeof(yearly_frequency_full$m5rate)

library(ggplot2)

# 繪製折線圖
ggplot(yearly_frequency_full, aes(x = as.integer(year), y = m5rate)) +
    geom_line(color = "blue", size = 1) + # 使用 color 設定線條顏色
    labs(
        title = "Annual Earthquake Frequency",
        x = "Year",
        y = "Number of Earthquakes"
    ) +
    scale_y_continuous(
        expand = c(0, 0),
        limits = c(0, NA)
    ) + # 使用 scale_y_continuous 設定 y 軸範圍
    theme_minimal()

earthquakes_tsunami <- subset(earthquake_data, tsunami == TRUE, select=-c(tsunami))

dim(earthquakes_tsunami)

earthquakes_tsunami$magnitudo <- round(earthquakes_tsunami$magnitudo * 2) / 2
earthquakes_tsunami$distance <- as.numeric(sub(" .*", "", earthquakes_tsunami$place))

ggplot(earthquakes_tsunami, aes(x = magnitudo)) +
    geom_bar(fill = "blue", color = "black") +
    labs(
        title = "Distribution of Earthquake Magnitudes Causing Tsunamis",
        x = "Magnitude",
        y = "Count"
    ) +
    theme_minimal()

ggplot(earthquakes_tsunami, aes(x = magnitudo, y = distance)) +
    geom_point(color = "blue", size = 2, alpha = 0.6) +
    labs(
        title = "Magnitude vs Distance for Tsunami-causing Earthquakes",
        x = "Magnitude",
        y = "Distance"
    ) +
    theme_minimal()



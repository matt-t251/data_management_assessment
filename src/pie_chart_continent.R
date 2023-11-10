## INPUT: df_learners_no_duplicates (01-A.R)
## OUTPUT: graphs/PieChartofContinents.png


library('ProjectTemplate')
load.project()

# install.packages("tidyverse")
library(tidyverse)

# install.packages("countrycode")
library(countrycode)


#make a data frame of countries
df_country <- subset(df_learners_no_duplicates, select = c("detected_country"))

# Use the table() function to create a frequency table
country_counts <- table(df_country$detected_country)

# Convert the frequency table to a data frame
df_country <- as.data.frame(country_counts)

# Rename the columns for clarity
colnames(df_country) <- c("country", "count")

# remove -- (there are 873 --)
# df_country <- subset(df_country, country != "--")       

# Sort the data frame by the count in descending order
df_country <- df_country[order(df_country$count, decreasing = TRUE), ]

# keep only the top 20 which excludes any country with less than 300 users
# df_country <- head(df_country, n=20) 

# change country code to name
df_country$country <- countrycode(sourcevar = df_country$country, origin = "iso2c", destination = "country.name")

# Convert countries to continents using countrycode
df_country$continent <- countrycode(df_country$country, "country.name", "continent")

# Calculate the total count
total_count <- sum(df_country$count)

# Create a vector of colors (you can customize this as needed)
colors <- rainbow(length(unique(df_country$continent)))

# Create a pie chart with different colors for each continent
piechart = ggplot(df_country, aes(x = "", y = count/total_count, fill = continent)) +
  geom_bar(width = 1, stat = "identity") +
  coord_polar("y", start = 0) +
  theme_void() +
  scale_fill_manual(values = colors) +
  ggtitle("Piechart of learners by Continent")

ggsave("H:/Documents/FutureLearn/graphs/PieChartofContinents.png", plot = piechart, width = 6, height = 4, dpi = 300)

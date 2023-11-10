## INPUT: df_learners_no_duplicates (01-A.R)
## OUTPUT: graphs/BarChartofCountries.png

library('ProjectTemplate')
load.project()

# install.packages("tidyverse")
library(tidyverse)

# install.packages("countrycode")
library(countrycode)


# rename data frame
df_for_barchart <- subset(df_country, country != "--")       

# Sort the data frame by the count in descending order
df_for_barchart <- df_for_barchart[order(df_for_barchart$count, decreasing = TRUE), ]

# keep only the top 20 which excludes any country with less than 300 users
df_for_barchart <- head(df_for_barchart, n=20) 

# change country code to name
df_for_barchart$country <- countrycode(sourcevar = df_for_barchart$country, origin = "iso2c", destination = "country.name")

# Create the bar chart
barchart <- ggplot(df_for_barchart, aes(x = reorder(country, -count), y = count)) +
                  geom_bar(stat = "identity", fill = "blue") +
                  labs(
                    title = "Bar Chart of Learners by Country",
                    x = "Country",
                    y = "Count"
                  ) +
                  theme_minimal() +
                  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("H:/Documents/FutureLearn/graphs/BarChartofCountries.png", plot = barchart, width = 6, height = 4, dpi = 300)

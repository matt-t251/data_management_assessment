## INPUT: df_learners (02-A.R)
##        df_country  (02-C.R)
## OUTPUT: graphs/BarChartofEngagement.png

library('ProjectTemplate')
load.project()

# install.packages("tidyverse")
library(tidyverse)

# install.packages("countrycode")
library(countrycode)


# Sort the data frame by the count in descending order
df_for_barchart <- df_country[order(df_country$completion_percent, decreasing = TRUE), ]

# keep only the top performing country
df_for_barchart <- head(df_for_barchart, n=20) 

# change country code to name
df_for_barchart$country <- countrycode(sourcevar = df_for_barchart$country, origin = "iso2c", destination = "country.name")

# Create the bar chart
barchart <- ggplot(df_for_barchart, aes(x = reorder(country, -engagement_percent), y = engagement_percent)) +
  geom_bar(stat = "identity", fill = "black") +
  labs(
    title = "Bar Chart of Engagement Percentage by Country",
    x = "Country",
    y = "Engagement Percent"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("H:/Documents/FutureLearn/graphs/BarChartofEngagement.png", plot = barchart, width = 6, height = 4, dpi = 300)

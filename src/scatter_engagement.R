## INPUT: df_country (02-B.R)
## OUTPUT: graphs/scatter_plot_of_engagement.png


library('ProjectTemplate')
load.project()

# install.packages("tidyverse")
library(tidyverse)

# install.packages("countrycode")
library(countrycode)

# rename data frame
df_for_scattergraph <- df_country

# Sort the data frame by the count in descending order
# df_for_scattergraph <- df_country[order(df_country$engagement_percent, decreasing = TRUE), ]

# keep only the top performing country
# df_for_scattergraph <- head(df_for_scattergraph, n=20)

# change country code to name
# df_for_scattergraph$country <- countrycode(sourcevar = df_for_scattergraph$country, origin = "iso2c", destination = "country.name")

scatter_plot <- ggplot(df_for_scattergraph, aes(x = count, y = engagement_percent,)) +
  geom_point() +
  labs(title = "Scatter plot of percentage of learners who engaged in the course \n vs. total learners from a country",
       x = "Percentage of learners who engaged in the course (%)",
       y = "Total Learners from country",
       color = "Country")
  guides(color = FALSE)

(scatter_plot)

ggsave("H:/Documents/FutureLearn/graphs/scatter_plot_of_engagement.png", plot = scatter_plot, width = 6, height = 4, dpi = 300)

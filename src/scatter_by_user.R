## INPUT: df_country (02-B.R)
## OUTPUT: graphs/PieChartofContinents.png


library('ProjectTemplate')
load.project()

# install.packages("tidyverse")
library(tidyverse)

# install.packages("countrycode")
library(countrycode)


# Sort the data frame by the count in descending order
df_for_scattergraph <- df_country[order(df_country$completion_percent, decreasing = TRUE), ]

# keep only the top performing country
# df_for_scattergraph <- head(df_for_scattergraph, n=20)

# change country code to name
df_for_scattergraph$country <- countrycode(sourcevar = df_for_scattergraph$country, origin = "iso2c", destination = "country.name")

scatter_plot <- ggplot(df_for_scattergraph, aes(x = completion_percent, y = count,)) +
  geom_point() +
  labs(title = "Scatter plot of percentage of learners who engaged in the course vs. total learners from a country",
       x = "percentage of learners who completed the course (%)",
       y = "Total Leaners from country",
       color = "Country")
  guides(color = FALSE)

(scatter_plot)

ggsave("H:/Documents/FutureLearn/graphs/scatter_plot_of_total_count.png", plot = scatter_plot, width = 6, height = 4, dpi = 300)

## INPUT: df_learners_no_duplicates (01-A.R)
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
df_for_scattergraph <- head(df_for_scattergraph, n=20)

# change country code to name
df_for_scattergraph$country <- countrycode(sourcevar = df_for_scattergraph$country, origin = "iso2c", destination = "country.name")

scatter_plot <- ggplot(df_for_scattergraph, aes(x = completion_percent, y = count, color = country)) +
  geom_point() +
  labs(title = "Scatter Plot of Completion Percent vs. Count",
       x = "Completion Percent",
       y = "Count",
       color = "Country")

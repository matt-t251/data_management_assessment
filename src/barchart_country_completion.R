## INPUT: df_learners (02-A.R)
##        df_country  (barchart_country_involvement.R)
## OUTPUT: graphs/BarChartofCompletion.png

library('ProjectTemplate')
load.project()

# install.packages("tidyverse")
library(tidyverse)

# install.packages("countrycode")
library(countrycode)


# create a vector of countries that have competed step 3.9
countries_completed_df <- subset(df_learners, step == "3.9")
countries_completed_df <- subset(countries_completed_df, select = c("detected_country"))

# create frequency table
country_count <- table(countries_completed_df$detected_country)

# convert to data frame
countries_completed_df <- as.data.frame(country_count)

# Rename the columns for clarity
colnames(countries_completed_df) <- c("country", "count")

# change country code to name
countries_completed_df$country <- countrycode(sourcevar = countries_completed_df$country, origin = "iso2c", destination = "country.name")


# the data frame df_country has a list of 20 countries who most signed up.
# the data frame countries_completed_df has the frequency of all country appirances of who compleated the course.

# take each row of the df_country and find it's appearance in the second data frame. (if it's missing then set to 0%.)
df_country$completion_count = 0
df_country$completion_percent = 0

for (n in 1:nrow(df_country)) {
  print(n)
  country_name = df_country$country[n]
  print(country_name)
  subset_df <- countries_completed_df[countries_completed_df$country == country_name, ]
  if (nrow(subset_df) == 0) {
    df_country$completion_percent[n] = 0
  } else {
    completion_count <- subset_df$count
    if (completion_count == 0) {
      df_country$completion_percent[n] = 0
    } else {
      df_country$completion_count[n] <- completion_count
      df_country$completion_percent[n] = (df_country$completion_count[n] / df_country$count[n]) * 100 
    }
  }
}

# Create the bar chart
barchart <- ggplot(df_country, aes(x = reorder(country, -count), y = completion_percent)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(
    title = "Bar Chart of Countries",
    x = "Country",
    y = "Completion Percent"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("H:/Documents/FutureLearn/graphs/BarChartofCompletion.png", plot = barchart, width = 6, height = 4, dpi = 300)





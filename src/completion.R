## how many of each country complete step 3.9

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
colnames(countries_completed_df) <- c("Country", "Count")

# change country code to name
countries_completed_df$Country <- countrycode(sourcevar = countries_completed_df$Country, origin = "iso2c", destination = "country.name")


# the data frame country_df has a list of 20 countries who most signed up.
# the data frame countries_completed_df has the frequency of all country appirances of who compleated the course.

# take each row of the country_df and find it's appearance in the second data frame. (if it's missing then set to 0%.)
country_df$completion_count = 0
country_df$completion_percent = 0

for (n in 1:nrow(country_df)) {
  print(n)
  country_name = country_df$Country[n]
  print(country_name)
  subset_df <- countries_completed_df[countries_completed_df$Country == country_name, ]
  if (nrow(subset_df) == 0) {
    country_df$completion_percent[n] = 0
  } else {
    completion_count <- subset_df$Count
    if (completion_count == 0) {
      country_df$completion_percent[n] = 0
    } else {
      country_df$completion_count[n] <- completion_count
      country_df$completion_percent[n] = (country_df$completion_count[n] / country_df$Count[n]) * 100 
    }
  }
}

# Create the bar chart
barchart <- ggplot(country_df, aes(x = reorder(Country, -Count), y = completion_percent)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(
    title = "Bar Chart of Countries",
    x = "Country",
    y = "Completion Percent"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("H:/Documents/FutureLearn/graphs/BarChartofCompletion.png", plot = barchart, width = 6, height = 4, dpi = 300)





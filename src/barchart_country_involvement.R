## INPUT: df_learners_no_duplicates (01-A.R)
## OUTPUT: graphs/BarChartofCountries.png


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
df_country <- subset(df_country, country != "--")       

# Sort the data frame by the count in descending order
df_country <- df_country[order(df_country$count, decreasing = TRUE), ]

# keep only the top 20 which excludes any country with less than 300 users
df_country <- head(df_country, n=20) 

# change country code to name
df_country$country <- countrycode(sourcevar = df_country$country, origin = "iso2c", destination = "country.name")

# Create the bar chart
barchart <- ggplot(df_country, aes(x = reorder(country, -count), y = count)) +
                  geom_bar(stat = "identity", fill = "blue") +
                  labs(
                    title = "Bar Chart of Countries",
                    x = "Country",
                    y = "Count"
                  ) +
                  theme_minimal() +
                  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("H:/Documents/FutureLearn/graphs/BarChartofCountries.png", plot = barchart, width = 6, height = 4, dpi = 300)

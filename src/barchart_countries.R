# install.packages("tidyverse")
library(tidyverse)

# install.packages("countrycode")
library(countrycode)


#make a dataframe of countries
country_df <- subset(df_learners_no_duplicates, select = c("detected_country"))

# Use the table() function to create a frequency table
country_counts <- table(country_df$detected_country)

# Convert the frequency table to a data frame
country_df <- as.data.frame(country_counts)

# Rename the columns for clarity
colnames(country_df) <- c("Country", "Count")

# remove -- (there are 873 --)
country_df <- subset(country_df, Country != "--")       

# Sort the data frame by the count in descending order
country_df <- country_df[order(country_df$Count, decreasing = TRUE), ]

# keep only the top 20 which excludes any country with less than 300 users
country_df <- head(country_df, n=20) 

# change country code to name
country_df$Country <- countrycode(sourcevar = country_df$Country, origin = "iso2c", destination = "country.name")

# Create the bar chart
barchart <- ggplot(country_df, aes(x = reorder(Country, -Count), y = Count)) +
                  geom_bar(stat = "identity", fill = "blue") +
                  labs(
                    title = "Bar Chart of Countries",
                    x = "Country",
                    y = "Count"
                  ) +
                  theme_minimal() +
                  theme(axis.text.x = element_text(angle = 45, hjust = 1))

ggsave("H:/Documents/FutureLearn/graphs/BarChartofCountries.png", plot = barchart, width = 6, height = 4, dpi = 300)

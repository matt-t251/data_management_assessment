library('ProjectTemplate')
load.project()

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

# Sort the data frame by the count in descending order
country_df <- country_df[order(country_df$Count, decreasing = TRUE), ]

# remove -- (there are 873 --)
country_df <- subset(country_df, Country != "--")                         

# keep only the top 10
country_df <- head(country_df, n=10)

# change country code to name
country_df$Country <- countrycode(sourcevar = country_df$Country, origin = "iso2c", destination = "country.name")

# Example code for creating the bar plot with rotated x-axis labels
(barplot(country_df$Count, names.arg = country_df$Country, col = "blue",
         main = "Bar Plot of Countrys", xlab = "Country", ylab = "Count",
         ylim = c(0, 12000), las = 2))

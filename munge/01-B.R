## Pre-processing script for cycle 1 (country_involvement)
## output is data frame of countries 

# OUTPUT: df_learners_no_duplicates

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
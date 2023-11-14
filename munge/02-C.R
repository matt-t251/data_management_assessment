## Pre-processing script for cycle 2 (country_engagement)
## output is data frame of countries with count of users,number of users who engaged and percentage

#  INPUT: df_country
# OUTPUT: df_country

# create a data frame of countries that have completed a step
df_countries_engagement <- subset(df_learners, step != "")

# create frequency table
country_count <- table(df_countries_engagement$detected_country)

# convert to data frame
df_country_count <- as.data.frame(country_count)

# Rename the columns for clarity
colnames(df_country_count) <- c("country", "count")

df_country$engagement_count = 0
df_country$engagement_percent = 0

# get completion data from df_learners and add it to df_country
for (n in 1:nrow(df_country)) {
  print(n)
  country_name = as.character(df_country$country[n])
  print(country_name)
  
  df_subset <- subset(df_learners, df_learners$detected_country == country_name & step != "")
  df_country$engagement_count[n]   <- nrow(df_subset)
  df_country$engagement_percent[n] <- (df_country$engagement_count[n] / df_country$count[n]) * 100
}
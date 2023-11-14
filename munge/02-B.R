## Pre-processing script for cycle 2 (country_completion)
## output is data frame of countries with count of users, completed users and percentage

#  INPUT: df_country
# OUTPUT: df_country

# create a data frame of countries that have completed step 3.9
df_countries_completed <- subset(df_learners, step == "3.9")

# create frequency table
country_count <- table(df_countries_completed$detected_country)

# convert to data frame
df_country_count <- as.data.frame(country_count)

# Rename the columns for clarity
colnames(df_country_count) <- c("country", "count")

df_country$completion_count = 0
df_country$completion_percent = 0

# get completion data from df_learners and add it to df_country
for (n in 1:nrow(df_country)) {
  print(n)
  country_name = as.character(df_country$country[n])
  print(country_name)

  df_subset <- subset(df_learners, df_learners$detected_country == country_name & step == "3.9")
  df_country$completion_count[n]   <- nrow(df_subset)
  df_country$completion_percent[n] <- (df_country$completion_count[n] / df_country$count[n]) * 100
}
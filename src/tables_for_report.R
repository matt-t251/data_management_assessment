### calculate variables for the tables used in the report.

## response rate
# gender
df <- df_learners_no_duplicates
df <- subset(df , gender != "Unknown")
reported_gender = nrow(df)
# 3733

# country
df <- df_learners_no_duplicates
df <- subset(df , country != "Unknown")
reported_country = nrow(df)
# 3726

# age range
df <- df_learners_no_duplicates
df <- subset(df , age_range != "Unknown")
reported_age = nrow(df)
# 3620

# highest education level
df <- df_learners_no_duplicates
df <- subset(df , highest_education_level != "Unknown")
reported_education = nrow(df)
# 3715

# employment status
df <- df_learners_no_duplicates
df <- subset(df , employment_status != "Unknown")
reported_employment = nrow(df)
# 3689

# Employment area 
df <- df_learners_no_duplicates
df <- subset(df , employment_area != "Unknown")
reported_job = nrow(df)
# 2881


## number of learner:
# how many learners country was detected
df <- df_learners_no_duplicates
df <- subset(df , detected_country != "--")
country_detected = nrow(df)
# 34310

# how many learners reported their country
df <- df_learners_no_duplicates
df <- subset(df , country != "Unknown") 
country_reported = nrow(df)
# 3726

# how many learners detected and reported country are the same.
df <- df_learners_no_duplicates
df <- subset(df , country == detected_country)
correct_country = nrow(df)
# 3421

# how many learners detected and reported country aren't the same.
df <- df_learners_no_duplicates
df <- subset(df , country != detected_country)
df <- subset(df , detected_country != "--")
df <- subset(df , country != "Unknown") 
incorrct_country = nrow(df)
# 221

# how many learners country wasn't detected
df <- df_learners_no_duplicates
df <- subset(df , detected_country == "--")
country_not_detected = nrow(df)
# 873



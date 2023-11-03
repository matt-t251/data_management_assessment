# compare country column to detected column


df <- df_learners_no_duplicates
df <- subset(df , country != detected_country)
df <- subset(df , detected_country != "--")
df <- subset(df , country != "Unknown") 

# there are 221 learners who entered a different country than the one detected.

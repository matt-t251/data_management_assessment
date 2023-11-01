# create a dataframe of learners, their ID, country, and detected country from all years
appended_dataframe <- rbind(cyber.security.1_enrolments,
                            cyber.security.2_enrolments,
                            cyber.security.3_enrolments,
                            cyber.security.4_enrolments,
                            cyber.security.5_enrolments,
                            cyber.security.6_enrolments,
                            cyber.security.7_enrolments)

# organisation_admin removed
admin_removed <- subset(appended_dataframe, role != "organisation_admin")                         

# remove access columns
columns_to_keep <- c("learner_id", "enrolled_at", "role", "country", "detected_country")
df_learners <- subset(admin_removed, select = columns_to_keep) # 37257

#remove duplicate learners across entire data frame
df_learners_no_duplicates <- df_learners[!duplicated(df_learners$learner_id), ] #2052
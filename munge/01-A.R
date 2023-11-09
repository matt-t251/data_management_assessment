## Pre-processing script for cycle 1 (country_involvement)
## output is data frame of all learner IDs with their country, detected country, enrollment date, and role
## with all admins and duplicate learners removed.

# OUTPUT: df_learners_no_duplicates

if ( !exists("df_learners_no_duplicates")) {
  print("data frame missing")
  # create a dataframe of learners, their ID, country, and detected country from all years
  appended_dataframe <- rbind(cyber.security.1_enrolments,
                              cyber.security.2_enrolments,
                              cyber.security.3_enrolments,
                              cyber.security.4_enrolments,
                              cyber.security.5_enrolments,
                              cyber.security.6_enrolments,
                              cyber.security.7_enrolments)
  
  # organisation_admin removed
  df_admin_removed <- subset(appended_dataframe, role != "organisation_admin")                         
  
  # remove excess columns
  # columns_to_keep <- c("learner_id", "enrolled_at", "role", "country", "detected_country")
  # df_admin_removed <- subset(df_admin_removed, select = columns_to_keep) # 37257
  
  #remove duplicate learners across entire data frame
  df_learners_no_duplicates <- df_admin_removed[!duplicated(df_admin_removed$learner_id), ] #2052
} else {
  print("data frame already created.")
}



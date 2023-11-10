## Pre-processing script for cycle 2 (country_completion)
## output is data frame of all learner IDs with their country, detected country, enrollment date, role,
## as well as Step and step completed date.

#  INPUT: df_learners_no_duplicates
# OUTPUT: df_learners


# only 14095 users have completed a step
# took 7 minutes to process

if ( !exists("df_learners")) {
  print("data frame missing")
  
  # append the data frames
  df_learner_steps <- rbind(cyber.security.1_step.activity,
                            cyber.security.2_step.activity,
                            cyber.security.3_step.activity,
                            cyber.security.4_step.activity,
                            cyber.security.5_step.activity,
                            cyber.security.6_step.activity,
                            cyber.security.7_step.activity)
  
  # add the new columns
  df_learners              <- df_learners_no_duplicates
  df_learners$step         <- ""
  df_learners$completed_at <- ""
  
  for (n in 1:nrow(df_learners)) {
    print(n)
    
    # store a single user id
    learner_id_char <- df_learners$learner_id[n]
    
    # if the ID is in the data frame...
    if (learner_id_char %in% df_learners$learner_id) {
      
      # Find the rows where the learner_id matches in df_learners, it will return a vector of all instances.
      row_index <- which(df_learner_steps$learner_id == learner_id_char)
      
      # store the length of the vector
      vector_length <- length(row_index)
  
      # if row index has 0 elements, then user isn't in the steps data frame
      if (vector_length == 0) {
        # print("no user")
      } 
      
      # if row index has 1 element, then user didn't finish first step
      if (vector_length == 1) {
        # print("user didn't finish first step")
      }
      
      # if all the elements are empty, then they also didn't finish any steps 
      if (all(df_learner_steps$last_completed_at == "")) {
        # print("user didn't complete any step, (but started multiple)")
        break
      }
      
      # if row index has 2 or more elements, then user finished at least one step
      if (vector_length >= 2) {
        # print("user finished one or more steps")
        i = 0
        temp_bool = TRUE
        
        # while the last cell is empty, keep looping
        while (temp_bool == TRUE) {
          
          # if cell is empty, move one up
          if (df_learner_steps$last_completed_at[row_index[length(row_index) -i]] == "") {
            # print("last cell empty")
            i = i+1
            
            # if every row has been checked, move to the next user
            if (i == length(row_index)){
              # print("all cells checks, and no date available")
              temp_bool = FALSE
            }
            
            # otherwise the last step has been identified
          } else {
            # print("last cell has date")
            
            # save the date to variables
            date_completed <- df_learner_steps$last_completed_at[row_index[length(row_index) -i]]
            step_completed <- df_learner_steps$step[row_index[length(row_index) -i]]
            
            # store the date and the step reached on the dr_learners
            df_learners$completed_at[n] <- date_completed
            df_learners$step[n] <- step_completed
            temp_bool = FALSE
          }
        }
      }
    }
  }
  cache("df_learners")
} else {
  print("data frame already created.")
}


#only 14095 users have compleated a step

# append the columns from step activity to df_learners
df_learner_steps <- rbind(cyber.security.1_step.activity,
                          cyber.security.2_step.activity,
                          cyber.security.3_step.activity,
                          cyber.security.4_step.activity,
                          cyber.security.5_step.activity,
                          cyber.security.6_step.activity,
                          cyber.security.7_step.activity)

# add columns
df_learners              <- df_learners_no_duplicates
df_learners$step         <- ""
df_learners$completed_at <- ""

for (n in 1:nrow(df_learners)) {
  # print("n")
  print(n)
  # store a single user id
  learner_id_char <- df_learners$learner_id[n]
  # print("learner_id_char")
  # print(learner_id_char)
  
  # if the ID is in the data frame...
  if (learner_id_char %in% df_learners$learner_id) {
    
    # Find the rows where the learner_id matches in df_learners, it will return a vector of all instances.
    row_index <- which(df_learner_steps$learner_id == learner_id_char)
    
    # store vector length
    vector_length <- length(row_index)
    # Print the length
    # print("vector_length")
    # print(vector_length)
    
    # if row index has 0 elements, then user isn't in the steps data frame
    if (vector_length == 0) {
      # print("no user")
      # next
    } 
    
    # if row index has 1 element, then user didn't finish first step
    if (vector_length == 1) {
      # print("user didn't finish first step")
      # next
    }
    
    # if all the elements are empty, then they also din't finish any steps 
    if (all(df_learner_steps$last_completed_at == "")) {
      # print("user didn't compleate any step, (but started multiple)")
      break
    }
    
    # if row index has 2 or more elements, then user finished at least one step
    if (vector_length >= 2) {
      # print("user finished one or more steps")
      i = 0
      temp_bool = TRUE
      # while the last cell is empty, keep looping
      while (temp_bool == TRUE) {
        # print("i")
        # print(i)
        # if cell is empty, move one up
        # print(df_learner_steps$last_completed_at[row_index[length(row_index) -i]])
        if (df_learner_steps$last_completed_at[row_index[length(row_index) -i]] == "") {
          # print("last cell empty")
          i = i+1
          if (i == length(row_index)){
            # print("all cells checks, and no date available")
            temp_bool = FALSE
          }
          # break is no more cells
        } else {
          # else the loop has found a non-empty cell
          # print("last cell has date")
          # print(df_learner_steps$last_completed_at[row_index[length(row_index) -i]])
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
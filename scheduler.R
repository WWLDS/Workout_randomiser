library(taskscheduleR)
library(here)

taskscheduler_create(taskname = "work_rand", rscript = "C:/R_projects/workout_randomiser/_main.R", 
                     schedule = "MINUTE", starttime = "11:48", modifier = 100)


here("_main.R")
taskscheduler_stop("word_dict")
taskscheduler_delete("word_dict")

# taskscheduler_stop("test_run_2")
# taskscheduler_delete("test_run_2")

# tasks <- taskscheduler_ls()
# tasks
# Pkg load ---------------------------------------------------------------------
suppressPackageStartupMessages({
     library(tidyverse)
     library(lubridate)
     library(here)
     library(lintr)
     library(styler)
})
lint("_main.R")
style_file("_main.R")
day = "triceps"
# Create lists of exercises ----------------------------------------------------
quads <- c("Back squat", "Front squat", "Goblet squat", "Incline leg press", 
           "Hack squat", "Leg extension", "Weighted lunges", "Weighted step up")
hamstrings <- c("Good morning - bar", "Good morning - dumbells", 
                "Good morning - hex bar", "High foot incline leg press", 
                "Leg curls")
back <- c("Deadlift", "Deadlift", "Rows", "T-bar lift", "Pull up", "Chin up", 
          "One arm dumbell row", "Machine pulldown - long bar", 
          "Machine row - long bar", "Machine row - triangle bar", 
          "Seated horizontal pull - machine", "Seated horizontal pull - plates")
chest <- c("Bench press", "Dumbell bench press", "Dumbell Fly", 
           "Barbell bench press - alternate grip", "Cable Fly", "Machine fly", 
           "Machine perpendicular arm fly", "Machine press")
shoulders <- c("Barbell press - standing", "Barbell press - seated", 
               "Dumbell press", "Arnold press", "Side raises - seated upright", 
               "Side raises - seated bent over", "Front raises - seated", 
               "Front raises - standing", "Machine plate press", 
               "Cable side raise", "Cable front raise")
traps <- c("Dumbell shrugs", "Barbell shrugs")
biceps <- c("Curls", "Preacher", "Hammer", "Barbell", "Cable curl", 
            "Cable hammer - no accessory")
triceps <- c("Machine", "Dips", "Behind the head dumbell", "Skullcrusher", 
             "Close grip bench press")

# Create table of exercises by body part ---------------------------------------
body_parts <- list(quads, hamstrings, back, chest, shoulders, traps, biceps, 
                   triceps)
headers <- c("quads", "hamstrings", "back", "chest", "shoulders", "traps", 
             "biceps", "triceps")
table_formation <- map_dfr(body_parts, ~as_tibble(t(.))) %>%
     t() %>%
     as_tibble()
colnames(table_formation) <- headers


curls <- c("Plate", "Dumbell")
accessory_muscle <- c("Forearms", "Abs", "Obliques", "Calves") %>%
        as_tibble()
gradient <- c("Incline", "Flat", "Decline")
cable_bar_type <- c("Rope", "Triangle", "Handle", "Straight bar") %>%
        as_tibble()
bar_or_dumb <- c("Bar", "Dumbell")

rand_selection <- table_formation %>%
        select(.GlobalEnv$day) %>%
        filter(!(is.na(.))) %>%
        slice_sample(n = 3)
        
test <- sample_n(cable_bar_type,1)

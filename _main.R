# Pkg load ---------------------------------------------------------------------
suppressPackageStartupMessages({
     library(tidyverse)
     library(lubridate)
     library(here)
     library(lintr)
     library(styler)
     library(renv)
})
lint("_main.R")
style_file("_main.R")
# day = "triceps"

# Create lists of exercises ----------------------------------------------------
quads <- c("Back squat", "Front squat", "Goblet squat", "Incline leg press", 
           "Hack squat", "Leg extension", "Weighted lunges", "Weighted step up")
hamstrings <- c("Good morning - bar", "Good morning - dumbbells", 
                "Good morning - hex bar", "High foot incline leg press", 
                "Leg curls")
back <- c("Deadlift", "Deadlift", "Rows", "T-bar lift", "Pull up", "Chin up", 
          "One arm dumbbell row", "Machine pulldown - long bar", 
          "Machine row - long bar", "Machine row - triangle bar", 
          "Seated horizontal pull - machine", "Seated horizontal pull - plates")
chest <- c("Bench press", "dumbbell bench press", "dumbbell Fly", 
           "Barbell bench press - alternate grip", "Cable Fly", "Machine fly", 
           "Machine perpendicular arm fly", "Machine press")
shoulders <- c("Barbell press - standing", "Barbell press - seated", 
               "dumbbell press", "Arnold press", "Side raises - seated upright", 
               "Side raises - seated bent over", "Front raises - seated", 
               "Front raises - standing", "Machine plate press", 
               "Cable side raise", "Cable front raise")
traps <- c("dumbbell shrugs", "Barbell shrugs")
biceps <- c("Curls", "Preacher", "Hammer", "Barbell", "Cable curl", 
            "Cable hammer - no accessory")
triceps <- c("Machine", "Dips", "Behind the head dumbbell", "Skullcrusher", 
             "Close grip bench press")
curls <- c("Plate", "dumbbell")
accessory_muscle <- c("Forearms", "Abs", "Obliques", "Calves") %>%
     as_tibble()
gradient <- c("Incline", "Flat", "Decline")
cable_bar_type <- c("Rope", "Triangle", "Handle", "Straight bar") %>%
     as_tibble()
bar_or_dumb <- c("Bar", "dumbbell")

# Create table of exercises by body part ---------------------------------------
body_parts <- list(quads, hamstrings, back, chest, shoulders, traps, biceps, 
                   triceps, curls, accessory_muscle, gradient, cable_bar_type, 
                   bar_or_dumb)
table_formation <- map_dfr(body_parts, ~as_tibble(t(.))) %>%
     t() %>%
     as_tibble()

headers <- c("quads", "hamstrings", "back", "chest", "shoulders", "traps", 
             "biceps", "triceps", "curls", "accessory_muscle", "gradient", 
             "cable_bar_type", "bar_or_dumb")
colnames(table_formation) <- headers

# Randomisation ----------------------------------------------------------------
fun <- function(x,y) {
        rand_selection <- table_formation %>%
                select(x) %>%   
                filter(!(is.na(.))) %>%
                slice_sample(n = 3)
        
}
df.new = as.data.frame(lapply(table_formation, function(x) slice_sample(n=3)))
#HERE 

rand_selection <- table_formation %>%
     select(1) %>%   
     filter(!(is.na(.))) %>%
     slice_sample(n = 3)
        
test <- sample_n(cable_bar_type,1)

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

quads <- c("Back squat", "Front squat", "Goblet squat", "Incline leg press", "Hack squat", "Leg extension", "Weighted lunges", "Weighted step up")
hamstrings <- c("Good morning - bar", "Good morning - dumbells", "Good morning - hex bar", "High foot incline leg press", "Leg curls")
back <- c("Deadlift", "Deadlift", "Rows", "T-bar lift", "Pull up", "Chin up", "One arm dumbell row", "Machine pulldown - long bar", "Machine row - long bar", "Machine row - triangle bar", "Seated horizontal pull machine", "Seated horizontal pull with plates")
chest <- c("Bench press", "Dumbell bench press", "Dumbell Fly", "Barbell bench press - alternate grip", "Cable Fly", "Machine fly", "Machine perpendicular arm fly", "Machine press")
shoulders <- c("Barbell press - standing", "Barbell press - seated", "Dumbell press", "Arnold press", "Side raises - seated upright", "Side raises - seated bent over", "Front raises - seated", "Front raises - standing", "Machine plate press", "Cable side raise", "Cable front raise")
traps <- c("Dumbell shrugs", "Barbell shrugs")
biceps <- c("Curls", "Preacher", "Hammer", "Barbell", "Cable curl", "Cable hammer - no accessory")
triceps <- c("Machine", "Dips", "Behind the head dumbell", "Skullcrusher", "Close grip bench press")

body_parts <- list(quads, hamstrings, back, chest, shoulders, traps, biceps, triceps)
table_formation_one<- map_dfr(body_parts, ~as_data_frame(t(.)))
table_formation_two <- as_data_frame(t(exercises))


curls <- c("Plate", "Dumbell")
accessory_muscle
gradient
cable_bar_type
bar_or_dumb
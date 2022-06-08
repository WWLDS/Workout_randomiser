# Pkg load ---------------------------------------------------------------------
suppressPackageStartupMessages({
  library(tidyverse)
  library(lubridate)
  library(here)
  library(lintr)
  library(styler)
  library(renv)
  library(emayili)
})
lint("_main.R")
style_file("_main.R")

# Create lists of exercises ----------------------------------------------------
quads <- c(
  "Back squat", "Front squat", "Goblet squat", "Incline leg press",
  "Hack squat", "Leg extension", "Weighted lunges", "Weighted step up"
)
hamstrings <- c(
  "Good morning - bar", "Good morning - dumbbells",
  "Good morning - hex bar", "High foot incline leg press",
  "Leg curls"
)
back <- c(
  "Deadlift", "Deadlift", "Rows", "T-bar lift", "Pull up", "Chin up",
  "One arm dumbbell row", "Machine pulldown - long bar",
  "Machine row - long bar", "Machine row - triangle bar",
  "Seated horizontal pull - machine", "Seated horizontal pull - plates"
)
chest <- c(
  "Bench press", "dumbbell bench press", "dumbbell Fly",
  "Barbell bench press - alternate grip", "Cable Fly", "Machine fly",
  "Machine perpendicular arm fly", "Machine press"
)
shoulders <- c(
  "Barbell press - standing", "Barbell press - seated",
  "dumbbell press", "Arnold press", "Side raises - seated upright",
  "Side raises - seated bent over", "Front raises - seated",
  "Front raises - standing", "Machine plate press",
  "Cable side raise", "Cable front raise"
)
traps <- c("dumbbell shrugs", "Barbell shrugs", "Hexbar shrugs")
biceps <- c(
  "Curls", "Preacher", "Hammer", "Barbell", "Cable curl",
  "Cable hammer - no accessory"
)
triceps <- c(
  "Machine", "Dips", "Behind the head dumbbell", "Skullcrusher",
  "Close grip bench press"
)
curls <- c("Plate", "dumbbell")
accessory_muscle <- c("Forearms", "Abs", "Obliques", "Calves")
gradient <- c("Incline", "Flat", "Decline")
cable_bar_type <- c("Rope", "Triangle", "Handle", "Straight bar")
bar_or_dumb <- c("Bar", "dumbbell")

# Create table of exercises by body part ---------------------------------------
body_parts <- list(
  quads, hamstrings, back, chest, shoulders, traps, biceps,
  triceps, curls, accessory_muscle, gradient, cable_bar_type,
  bar_or_dumb
)
table_formation <- map_dfr(body_parts, ~ as_tibble(t(.))) %>%
  t() %>%
  as_tibble()
headers <- c(
  "Quads", "Hamstrings", "Back", "Chest", "Shoulders", "Traps",
  "Biceps", "Triceps", "Curls", "Accessory_muscle", "Gradient",
  "Cable_bar_type", "Bar_or_dumb"
)
colnames(table_formation) <- headers

# Gather variables and random sample three or one time -------------------------
table_gather <- table_formation %>%
  gather(body_part, exercise) %>%
  mutate(freq = case_when(
    grepl(
      "Quads|Hamstrings|Back|Chest|Shoulders|Biceps|Triceps",
      body_part
    ) ~ "3",
    grepl(
      "Curls|Accessory_muscle|Gradient|Cable_bar_type|Traps|Bar_or_dumb",
      body_part
    ) ~ "1"
  )) %>%
  mutate(freq = as.numeric(freq)) %>%
  filter(!(is.na(exercise))) %>%
  group_by(body_part) %>%
  sample_n(freq[2], replace = F) %>%
  arrange(desc(freq)) %>%
  select(-freq) %>%
  mutate(row = 1:n()) %>%
  spread(body_part, exercise) %>%
  select(-1)

body_table <- table_gather %>%
  select(2,4,6,9:11,13)

accessory_table <- table_gather %>%
  select(1,3,5,7,8,12) %>%
  drop_na()
  

# spread the tables? Make two tables = one with body parts and the other with
# additional stuff
# then learn how to get it to email it to me
# then schedule daily

# Pkg load ---------------------------------------------------------------------
suppressPackageStartupMessages({
  library(tidyverse)
  library(lubridate)
  library(here)
  library(lintr)
  library(styler)
  library(renv)
  library(gt)
})
# lint("_main.R")
# style_file("_main.R")

# Create lists of exercises ----------------------------------------------------
quads <- c(
  "Back squat", "Front squat", "Goblet squat", "Incline leg press",
  "Hack squat - lean back", "Hack squat - lean forward", "Leg extension - double", "Leg extension - single", "Weighted lunges", "Weighted step up"
)
hamstrings <- c(
  "Good morning", "High foot incline leg press",
  "Leg curls", "Romanian deadlift", "Back squat", "Tight bum"
)
back <- c(
  "Deadlift", "Bent over rows", "T-bar lift", "Pull up", "Chin up",
  "One arm dumbbell row", "Machine pulldown",
  "Machine row"
)
chest <- c(
  "Bench press", "Bench fly",
  "Dumbbell bench press - alt grip", "Cable Fly",
  "Pec deck", "Machine press", "Dips"
)
shoulders <- c(
  "Shoulder press", "Arnold press", "Side raises - upright",
  "Side raises - bent over", "Front raises", "Machine plate press",
  "Cable side raise", "Cable front raise", "Machine side raise", "Machine front raise"
)
traps <- c("Dumbbell shrug", "Barbell shrug", "Hexbar shrug")
biceps <- c(
  "Curls", "Preacher", "Hammer", "Barbell", "Cable curl",
  "Cable hammer"
)
triceps <- c(
  "Cable - high start", "Cable - low start", "Dips",
  "Behind the head", "Skullcrusher", "Close grip bench press"
)
accessory_muscle <- c("Abs", "Obliques", "Calves")
gradient <- c("Incline", "Flat", "Decline")
cable_bar_type <- c(
  "Rope", "Triangle", "Handle", "Straight bar",
  "Long straight bar"
)
bar_or_dumb <- c("Bar", "Dumbbell")
rest <- c("Thirty", "Forty-five", "Sixty")
reps <- c("Six", "Eight", "Ten", "Twelve")
sets <- c("Six", "Eight", "Ten")

# Create table of exercises by body part ---------------------------------------
body_parts <- list(
  quads, hamstrings, back, chest, shoulders, traps, biceps,
  triceps, curls, accessory_muscle, gradient, cable_bar_type,
  bar_or_dumb, rest, reps, sets
)
table_formation <- map_dfr(body_parts, ~ as_tibble(t(.))) %>%
  t() %>%
  as_tibble()
headers <- c(
  "Quads", "Hamstrings", "Back", "Chest", "Shoulders", "Traps",
  "Biceps", "Triceps", "Curls", "Accessory muscle", "Gradient",
  "Cable attachment", "Bar or dumbbell", "Rest", "Reps", "Sets"
)
colnames(table_formation) <- headers

# Gather variables then take random sample; output as gt object ----------------
# Function outputs next seven days of WO sessions ----
x <- 0
while (x < 8) {
  rand_workout <- table_formation %>%
    gather(body_part, exercise) %>%
    mutate(freq = case_when(
      grepl(
        "Quads|Hamstrings|Back|Chest|Shoulders|Biceps|Triceps",
        body_part
      ) ~ "3",
      grepl(
        "Curls|Accessory muscle|Gradient|Cable attachment|Traps|Bar or dumbbell|Rest|Reps|Sets",
        body_part
      ) ~ "1"
    )) %>%
    mutate(freq = as.numeric(freq)) %>%
    filter(!(is.na(exercise))) %>%
    group_by(body_part) %>%
    sample_n(freq[2], replace = F) %>%
    arrange(desc(freq)) %>%
    mutate(row = 1:n()) %>%
    pivot_wider(
      names_from = row,
      values_from = exercise
    ) %>%
    lapply(function(x) gsub("3", "Muscle group", x)) %>%
    lapply(function(y) gsub("1", "Additional variable", y)) %>%
    as_tibble() %>%
    mutate_all(~ replace(., is.na(.), "-")) %>%
    rename(
      "Subheading" = freq,
      "Variable" = body_part,
      "Exercise 1" = `1`,
      "Exercise 2" = `2`,
      "Exercise 3" = `3`
    ) %>%
    gt(
      groupname_col = "Subheading",
      rowname_col = "Variable"
    ) %>%
    opt_table_lines(extent = "none") %>%
    tab_style(
      style = list(
        cell_text(weight = "bold")
      ),
      locations = cells_row_groups()
    ) %>%
    opt_table_lines(extent = "default") %>%
    tab_options(
      column_labels.border.top.color = "white",
      column_labels.border.top.width = px(3),
      column_labels.border.bottom.color = "black",
      table_body.hlines.color = "white",
      table.border.bottom.color = "white",
      table.border.bottom.width = px(3)
    )

  # Export table into Dropbox and local folders ----------------------------------
  date <- Sys.Date()
  gtsave(rand_workout, paste("C:/Users/INGRAM_T/Dropbox/Daily_workout/", date + x,
    "_session.png",
    sep = ""
  ))
  gtsave(rand_workout, here("archive_workouts", paste(date + x, "_session.png",
    sep = ""
  )))
  print(x)
  x <- x + 1
}


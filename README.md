### workout_randomiser
Mixing up the workout (every time!)

09 JUNE 2022:
v1.0

This script outputs a random variation of exercises to always keep your sessions fresh. The script loops over seven times to output the next seven days worth of sessions. Output is exported to Dropbox for instant access via Dropbox mobile app. Append to a Task Scheduler once weekly for full automation.


#### Sessions are defined as a workout on one day and can contain one or more muscle groups:
+ Back
+ Chest
+ Shoulders
+ Biceps
+ Triceps
+ Quads
+ Hamstrings
    
#### Three exercises are randomly chosen for each muscle group.
#### One random selection from each additional variable is included for further session variation: 
+ Curls (plate or dumbell curls. Barbell included as their own feature in "Biceps")
+ Accessory muscle (abs, obliques, calves)
+ Gradient (incline, flat, decline)
+ Cable attachment
+ Traps (dumbbell, barbell, hex bar)
+ Bar or dumbbell
+ Rest (time between sets, in seconds)
    
#### The script loops over the random generation and outputs seven dated .png files from "tomorrow date" to "tomorrow date +7".
#### .png are exported locally and to my Dropbox location.
+ Dropbox was chosen so that I could instantly access the .png files from my mobile.
+ This line of code will need adjusting to match your directory.

#Chapter 3 - Data Transformation
#Version 4.4.1
#Maíra, 13.09.24

install.packages("tidyverse")
library(tidyverse)

install.packages("nycflights13")
library(nycflights13)

flights

View(flights)

glimpse(flights)

#dplyr Basics

flights |> 
  filter(dest == "IAH") |>
  group_by(year, month, day) |>
  summarize(
    arr_delay = mean(arr_delay, na.rm = TRUE)
  )

# ROWS 

# filter() -> changes which rows are present without changing their order
# arrange() -> changes the order of the rows without changing which are present
# distinct() -> finds rows with unique values

# Filter verb

#All flights that departed 2 hours late
flights |>
  filter(dep_delay > 120)

#All flights that departed on January 1

jan1 <- flights |>
  filter(month == 1 & day == 1)

#All flights that departed in January or February
flights |>
  filter(month == 1 | month == 2)

#Useful shortcut for | and == : %in%

flights |>
  filter(month %in% c(1, 2))

# Arrange verb

flights |>
  arrange(desc(dep_delay))

# Distinct verb

flights |>
  distinct(origin, dest)

# to find the number of the occurrences

flights |>
  count(origin, dest, sort = TRUE)

# EXERCISES:
# 1) Find in a single pipeline each condition:

# Had an arrival delay two or more hours
flights |>
  filter(arr_delay >= 120)

# Flew to Houston
flights |>
  filter(dest == "IAH" | dest == "HOU")

# Were operated by United(UA), American(AA) or Delta(DL)
flights |>
  filter(carrier %in% c("UA", "AA", "DL"))

#Departed in summer (July, August, September)
flights |>
  filter(month %in% c(7, 8, 9))

# Arrived more than two hours late, but didn't leave late
flights |>
  filter(arr_delay > 120 & dep_delay <= 0)

# Were delayed by at least an hour, but made up more than 30 min in flight

flights |>
  filter(dep_delay >= 60 & dep_delay - arr_delay > 30)

# 2) Sort flights to find the flights with the longest departure delays. Find the flights that left earliest in the morning.
flights |>
  arrange(desc(dep_delay)) |>
  arrange(dep_time)

# 3) Sort flights to find the fastest flights
flights |>
  arrange(desc(distance / (air_time / 60)))

# 4) Was there a flight on every day of 2013?
flights |>
  distinct(day, month, year) |>
  nrow() # Yes, 365

# 5) Which flights traveled the farthest distance?
flights |>
  arrange(desc(distance)) |>
  relocate(distance)

# And travel the least distante?
flights |>
  arrange(distance) |>
  relocate(distance)

# COLUMNS

# mutate() -> creates new columns that are derived from the existing columns
# select() -> changes which columns are present
# relocate() -> changes the position of the columns

# Mutate verb
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .before = 1
  )

# the new columns will be after the column day
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    speed = distance / air_time * 60,
    .after = day
  )

# keeping only the columns involved in the mutate verb
flights |>
  mutate(
    gain = dep_delay - arr_delay,
    hours = air_time / 60,
    gain_per_hour = gain / hours,
    .keep = "used"
  )

# remember to assign to a new object instead of overwritting the data frame

# Select verb
# columns by name
flights |>
  select(year, month, day)

#all columns between year and day (inclusive)
flights |>
  select(year:day)

#all columns except those from year to day
flights |>
  select(!year:day)

#all columns that are characters
flights |>
  select(where(is.character))

# remember: starts_with(), ends_with(), contains(), num_range(), etc

# check out janitor::clean(names) -> automated cleaning

# Relocate verb -> move variables around

flights |>
  relocate(time_hour, air_time)

flights |>
  relocate(year:dep_time, .after = time_hour)

flights |>
  relocate(starts_with("arr"), .before = dep_time)

# EXERCISES

# 1) Compare dep_time, sched_dep_time, and dep_delay. How would you expect those three numbers to be related?

flights |>
  relocate(dep_time, sched_dep_time, dep_delay)

# The relation between these 3 numbers is: dep_time = sched_dep_time + dep_delay

# 2) Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights.

# 3) What happens if you specify the name of the same variable multiple times in a select() call?

flights |> 
  select(arr_time, arr_time, arr_time)
# It will only be shown once

# 4) What does the any_of() function do? Why might it be helpful in conjunction with this vector?
variables <- c("year", "month", "day", "dep_delay", "arr_delay")
flights |>
  select(any_of(variables))

# 5) How do the select helpers deal with upper- and lowercase by default? How can you change that default?
flights |>
  select(contains("TIME"))
# The helper contains() ignore upper and lowercases.
# To change this default we can:

flights |>
  select(contains("TIME", ignore.case = FALSE))

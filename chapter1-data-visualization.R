#Studying -> R for Data Science
#Version 4.4.1
#Maíra, 10.09.24

#Typing the name of the dataframe in the console to print review of its contents
penguins

#or

glimpse(penguins)

#CREATING GGPLOT

ggplot(data = penguins,
       mapping = aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(mapping = aes(color = species, shape = species)) +
  geom_smooth(method = "lm") +
  labs(
    title = "Body mass and flipper length",
    subtitle = "Dimensions for Adelie, Chinstrap and Gentoo Penguins",
    x = "Flipper lenght (mm)", y = "Body mass (g)",
    color = "Species", shape = "Species"
  ) +
  scale_color_colorblind()

#Exercises
# 1) How many rows and columns are in penguins?

# R: There are 344 rows and 8 columns

# 2) What does the bill_depth_mm variable in the penguins data frame describe?

# R: It shows the bill depth of the penguins in milimeters 

# 3) Make a scatter plot of bill_depth_mm versus bill_lenght_mm.

ggplot(
  data = penguins,
  aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point(mapping = aes(colour = species, shape = species)) +
  labs(
    title = "Bill lenght and bill depth",
    x = "Bill lenght (mm)",
    y = "Bill depth (mm)"
  )

# 4) What happens if you make a scatterplot of species versus bill_depth_mm? What might be a better choice be a better choice of geom?

ggplot(
  data = penguins,
  aes(x = species, y = bill_depth_mm)
) +
  geom_boxplot()

# 6) What does the ra.nm argument do in the geom.point()? What is the default value?

# R: This argument remove the missing values of a dataframe without a warning

# 7) Create a scatterplot where you set the argument above to TRUE and add a caption.

ggplot(
  data = penguins,
  aes(x = bill_length_mm, y = bill_depth_mm)
) +
  geom_point(
    mapping = aes(colour = species, shape = species), na.rm = TRUE) +
  labs(caption = "Data came from the palmerpenguins package")

# 8) Re-create the visualization below

ggplot(
  data = penguins,
  aes(x = flipper_length_mm, y = body_mass_g)
) +
  geom_point(
    aes(colour = bill_depth_mm),
    na.rm = TRUE
  ) +
  geom_smooth()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g, color = island)) +
  geom_point() +
  geom_smooth(se = FALSE)

# 10) Will the two graphs below look different?

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_smooth()

ggplot(
  data = penguins,
  mapping = aes(x = flipper_length_mm, y = body_mass_g)) +
  geom_point() +
  geom_smooth(
    data = penguins,
    mapping = aes(x = flipper_length_mm, y = body_mass_g))

# R: No.

#GGPLOT CALLS

# Categorical Variable
ggplot(penguins, aes(x = fct_infreq(species))) + 
  geom_bar()

# Numerical Variable (or Quantitative)
# -> Can take on a wide range of numerical values
# -> Can be: continuous or discrete

# Histogram: commonly used for distributions of continuous variables
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 200)

# Density: Smoothed-out version of the histogram
ggplot(penguins, aes(x = body_mass_g)) +
  geom_density()

#Exercises
# 1) Make a bar plot of species of penguins, where you assign species to the y aesthetic. How is this plot different?

ggplot(penguins, aes(y = fct_infreq(species))) +
  geom_bar()

# R: The bars are horizontal

# 2) How are the following two plots different? Which aesthetic, color or fill, is more useful for changing the color of bars?

ggplot(penguins, aes(x = species)) +
  geom_bar(color = "red")

ggplot(penguins, aes(x = species)) +
  geom_bar(fill = "red")

# R: The fill aesthetic is more useful for changing the colors

# 3) What does the bins argument in geom_histogram do?
# R: It define the number of bars in the histogram plot

# ) Make a histogram of the carat variable in diamonds dataset. Experiment different binwidth

ggplot(diamonds, aes(x = carat)) + 
  geom_histogram(binwidth = 0.50)

ggplot(diamonds, aes(x = carat)) + 
  geom_histogram(binwidth = 0.05)

# VISUALIZING RELATIONSHIPS
# A numerical and a categorical variable

ggplot(penguins, aes(x = species, y = body_mass_g))+
  geom_boxplot()

ggplot(penguins, aes(x = body_mass_g, color = species, fill = species))+
  geom_density(alpha = 0.5)

#Two Categorical Variables
# Showing the frequencies of each species on each island
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar()

#Relative frequency plot (more useful for comparing species distributions) 
ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

#Two Numerical Variables
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(aes(color = species, shape = island))
#This plot is difficult to make sense of

ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g)) + 
  geom_point(aes(color = species, shape = species)) +
  facet_wrap(~island)

#faceting is useful because it splits the data into subsets and create a separate plot for each subset

# Exercises

# 1) Which variables in mpg (dataframe) are categorical and which are numerical?
# Categorical = manufacturer, model, trans, drv, fl, class
# Numerical = displ, cyl, year, cty, hwy

# 2) Make a scatterplot of hwy vs displ using mpg data frame. 

ggplot(mpg, aes(x = hwy, y = displ, color = cty)) +
  geom_point()

ggplot(mpg, aes(x = hwy, y = displ, size = cty)) +
  geom_point()

ggplot(mpg, aes(x = hwy, y = displ, color = cty, size = cty)) +
  geom_point()

ggplot(mpg, aes(x = hwy, y = displ, color = cty, size = cty, shape = drv)) +
  geom_point()

# 4) What happens if you map the same variable to multiple aesthetics?

# R: The code will generate an useless plot

# 5)  Make a scatterplot of bill_depth_mm versus bill_lenght_mm and color the point by species

ggplot(penguins, aes(x = bill_depth_mm, y = bill_length_mm, color = species)) + geom_point() +
  facet_wrap(~species)

# 7) Create the following stacked bar plots. Which question can you answer with the first one? Which question can you answer with the second one?

ggplot(penguins, aes(x = island, fill = species)) +
  geom_bar(position = "fill")

# First plot question: What is the species distribution on each island? 

ggplot(penguins, aes(x = species, fill = island)) +
  geom_bar(position = "fill")

# Second plot question: Which islands are home to each species?

# SAVING THE PLOTS
ggplot(penguins, aes(x = flipper_length_mm, y = body_mass_g, color = species)) +
  geom_point()
ggsave(filename = "penguin-plot.png")

# End of the first chapter
# Sample script for generating UpSet plots for the final project of
# BIOL350 and BIOL659 at Texas A&M University.
# Author: J. Gamboa
# email: jargamboa@tamu.edu
# 2023


# Load required packages
library(UpSetR)
library(readr)

# Read in the sample data. When you read the data you will notice 22 rows and 3
# columns. There is no ID column since it isn't needed to generate an UpSet plot.
# However, you may interpret the row number to correspond to an individual ID
# each column can then be considered to contain all the IDs which a given
# species has in common with this ID list (for example, if you were identifying
# homologous proteins between two species).

proteomes_df = read.delim(file = "input_upset_plot_sample.tsv", 
                          header = FALSE, sep = "\t")
colnames(proteomes_df) <- c("Human", "Chicken", "Zebrafish")

# Display the resulting data frame. You will notice that some columns have NA
# values. This will not affect the generation of the plot but illustrates how
# when you have proteomes of different sizes if you were to plot the intersections
# you may end up with a similar situation.
print(proteomes_df)

# transform your dataframe to a list for the 'upset' function to work below
proteomes_list <- lapply(proteomes_df, as.double)

# Generate your UpSet plot.
# The mb.ratio argument can be modified so that you can change what proportion
# of your upset plot corresponds to the intersection size plot and the set size/
# diagram section respectively. The ratios must equal to 1.0.
upset(fromList(proteomes_list), 
      order.by = "freq", keep.order = TRUE,
      mb.ratio = c(0.70, 0.30))


# Now let's load a different sample dataset where the (dummy) IDs are actually 
# associated with each row and the resulting data frame has cells filled with 
# zeroes where a value is absent (a so called, sparse matrix).
# The values in the cells correspond to the row number associated with the ID
# for that row.
proteomes_df_2 = read.delim(file = "input_upset_plot_2.tsv", 
                            header = FALSE, row.names=1, sep = "\t")

colnames(proteomes_df_2) <- c("Human", "Chicken", "Zebrafish")

# Display the dataset. In this case as indicated there are no NAs, instead
# these have been replaced with 0s
print(proteomes_df_2)

proteomes_list2 <- lapply(proteomes_df_2, as.double)

upset(fromList(proteomes_list2),
      order.by = "freq", keep.order = TRUE,
      mb.ratio = c(0.70, 0.30))

upset(fromList(proteomes_list2), sets = c("Human", "Zebrafish"),
      order.by = "freq", keep.order = TRUE,
      mb.ratio = c(0.70, 0.30))



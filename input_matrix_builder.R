# Sample script for generating input matrices to be used for UpSet plots
# BIOL350 and BIOL659 at Texas A&M University.
# Author: J. Gamboa
# email: jargamboa@tamu.edu
# April 2023

# Set your working directory to be the same location as the input file. 
# Otherwise modify the path to the input file so it can be loaded to the
# protein_df dataframe.

library(readr)

protein_df = read.delim(file = "protein_df.tsv", header = TRUE,
                        sep = "\t")

# Initialize an empty matrix to store the results of the row comparison
result_matrix <- matrix(ncol=2, nrow=0, 
                        dimnames=list(NULL, c("organism1", "organism2")))

# Loop through the rows of the protein dataframe
for (i in 1:nrow(protein_df)) {
  # Check if column 2 is equal to column 3
  if (protein_df[i,2] == protein_df[i,3]) {
    # If they are equal, store the corresponding value of column 1
    # in the result matrix
    result_matrix <- rbind(result_matrix, c(protein_df[i,1], protein_df[i,1]))
  } else {
    # If they are not equal, store 0 in the second column of the result matrix
    result_matrix <- rbind(result_matrix, c(protein_df[i,1], 0))
  }
}

# Print the result matrix
print(result_matrix)

# Save the result matrix as a CSV file
write.csv(result_matrix, file = "result_matrix.csv", 
          row.names = FALSE)

# Save the result matrix as a TSV file if preferred.
write.table(result_matrix, file = "result_matrix.tsv", 
            sep = "\t", row.names = FALSE)
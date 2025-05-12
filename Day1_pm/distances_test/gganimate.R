library(phyloseq)
library(ggplot2)
library(tidyr)
library(microbiome)
library(gganimate)
library(dplyr)

tab_sam = read.csv("/Users/yepesgar/Downloads/SIB_IMDAMM/Day1_pm/script/data/test_sheet.csv")
data_biom <- import_biom("/Users/yepesgar/Downloads/SIB_IMDAMM/Day1_pm/script/data/merged.biom")
data_biom@tax_table@.Data <- substring(data_biom@tax_table@.Data, 4)
colnames(data_biom@tax_table@.Data)<- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus", "Species")

tax_table_df <- as.data.frame(tax_table(data_biom))

# Modify the species column to include genus
tax_table_df$Species <- paste(tax_table_df$Genus, tax_table_df$Species, sep = " ")

# Update the taxonomy table in the phyloseq object
tax_table(data_biom) <- as.matrix(tax_table_df)

# Phyloseq object with only Bacteria
data_biom_bact <- subset_taxa(data_biom, Kingdom == "Bacteria")

samples_df <- tab_sam %>% 
  tibble::column_to_rownames("Name") 
samples = sample_data(samples_df)
otu_inf = data_biom_bact@otu_table
phy_inf = data_biom_bact@tax_table
merged <- phyloseq(otu_inf,phy_inf,samples)

phylum_data = tax_glom(merged, "Phylum")
threshold <- 500
phylum_data_filt <- filter_taxa(phylum_data, function(x) sum(x) > threshold, prune = TRUE)

data_biom_clr <- microbiome::transform(phylum_data_filt, "clr")

# Extract CLR-transformed OTU table
otu_clr <- as(otu_table(data_biom_clr), "matrix")

# If taxa are rows instead of columns, transpose
if (taxa_are_rows(data_biom_clr)) {
  otu_clr <- t(otu_clr)
}

# Compute row sums (across features per sample)
clr_row_sums <- rowSums(otu_clr)

# Show a few results
head(clr_row_sums)

# Check if they are (close to) zero
summary(clr_row_sums)

#######
# Define your distance metrics and ordination methods
physeq <- merged

distance_metrics <- c("bray", "jaccard", "manhattan")  # Pick ones supported by your dataset
ordination_methods <- c("PCoA", "NMDS")

# Create a list to hold ordination results
ordination_results <- list()

# Loop over combinations and store ordination + metadata
for (dist in distance_metrics) {
  for (method in ordination_methods) {
    ord <- ordinate(physeq, method = method, distance = dist)
    df <- plot_ordination(physeq, ord, justDF = TRUE)
    
    # Add metadata for animation
    df$Distance <- dist
    df$Method <- method
    
    ordination_results[[paste(dist, method, sep = "_")]] <- df
  }
}

# Combine all ordination data
ordination_df <- bind_rows(ordination_results)

ordination_df <- ordination_df %>%
  mutate(
    Dim1 = ifelse(Method == "PCoA", Axis.1, NMDS1),
    Dim2 = ifelse(Method == "PCoA", Axis.2, NMDS2)
  )

ordination_df <- ordination_df[,!names(ordination_df) %in% c("Axis.1", "Axis.2", "NMDS1", "NMDS2")]

# Plot with gganimate
p <- ggplot(ordination_df, aes(Dim1, Dim2, color = Group)) +
  geom_point(size = 8, alpha = 0.8) +
  facet_wrap(~Method, scales = "free") +
  theme(axis.text = element_text(size = 18), axis.title = element_text(size = 18),
        legend.text = element_text(size = 16), strip.text.x = element_text(size = 16),
        plot.title = element_text(size = 20),
        legend.title = element_text(size=16),
        panel.border = element_blank(),
        panel.grid.major = element_blank(),
        panel.grid.minor = element_blank(),
        axis.line = element_line(colour = "black"),
        panel.background = element_blank())+
  labs(title = 'Ordination using {closest_state}', x = "Dimension 1", y = "Dimension 2") +
  transition_states(Distance, transition_length = 2, state_length = 1) +
  ease_aes('sine-in-out')

# Render animation
animate(p, width = 1200, height = 600, duration = 10, fps = 10)


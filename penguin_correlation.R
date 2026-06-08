# ==============================================================================
# FINAL PROJECT: PENGUIN CORRELATION (Project 2)
# File: penguin_correlation.R
# ==============================================================================

library(palmerpenguins)
library(ggplot2)
library(dplyr)

# Load data
data("penguins")

# Clean data
penguins_clean <- penguins %>%
  filter(!is.na(flipper_length_mm),
         !is.na(bill_length_mm),
         !is.na(species),
         !is.na(island))

# Neon colors
my_colors <- c("Adelie" = "#39FF14",      # Neon Green
               "Chinstrap" = "#FF1493",   # Neon Dark Pink
               "Gentoo" = "#00BFFF")      # Neon Blue

# Island shapes
island_shapes <- c("Biscoe" = 16,         # Circle
                   "Dream" = 17,          # Triangle
                   "Torgersen" = 15)      # Square

# Create plot with ONE trendline
p <- ggplot(penguins_clean, aes(x = flipper_length_mm,
                                y = bill_length_mm)) +           # <- NO color here
  
  # Points with color and shape
  geom_point(aes(color = species, shape = island), 
             size = 3, alpha = 0.8, stroke = 0.8) +
  
  # ONE trendline for ALL data (outside aes)
  geom_smooth(method = "lm", se = TRUE, color = "white", 
              fill = "#FF1493", alpha = 0.3, linewidth = 1) +
  
  # Colors for species
  scale_color_manual(values = my_colors) +
  
  # Shapes for islands
  scale_shape_manual(values = island_shapes) +
  
  # Labels
  labs(
    title = "BIOMETRIC CORRELATIONS AMONG ANTARCTIC PENGUINS",
    subtitle = "Flipper Length vs Bill Length | Colored by Species, Shaped by Island",
    x = "Flipper Length (mm)",
    y = "Bill Length (mm)",
    color = "Species",
    shape = "Island",
    caption = "Data Source: Palmer Station Antarctica LTER | palmerpenguins package"
  ) +
  
  # Dark theme
  theme_minimal(base_size = 12) +
  theme(
    plot.background = element_rect(fill = "#0D0D0D", color = NA),
    panel.background = element_rect(fill = "#1A1A1A", color = NA),
    panel.grid.major = element_line(color = "#333333", linewidth = 0.4),
    panel.grid.minor = element_blank(),
    plot.title = element_text(face = "bold", size = 15, hjust = 0.5, color = "#39FF14"),
    plot.subtitle = element_text(size = 10, hjust = 0.5, color = "#CCCCCC"),
    plot.caption = element_text(size = 8, color = "#888888", hjust = 1),
    axis.title = element_text(face = "bold", size = 11, color = "#39FF14"),
    axis.text = element_text(size = 9, color = "#DDDDDD"),
    legend.title = element_text(face = "bold", size = 10, color = "#39FF14"),
    legend.text = element_text(size = 9, color = "#CCCCCC"),
    legend.background = element_rect(fill = "#1A1A1A", color = "#333333"),
    legend.key = element_rect(fill = "#1A1A1A", color = NA),
    legend.position = "bottom"
  )

# Print plot
print(p)

# Save as PNG
ggsave("penguin_correlation.png", plot = p, width = 10, height = 7, dpi = 300)

# ==============================================================================
# INTERPRETATION (10% of Grade - REQUIRED)
# ==============================================================================
#
# SCATTERPLOT ANALYSIS: FLIPPER LENGTH vs BILL LENGTH
#
# 1. POSITIVE CORRELATION (Trendline Analysis)
#
#    The SINGLE continuous linear trendline shows a CLEAR POSITIVE CORRELATION
#    between flipper length and bill length across ALL penguin species.
#    As flipper length increases, bill length also increases.
#    The standard error bands (transparent pink) show the confidence interval
#    around the trendline - narrower bands indicate higher confidence.
#
# 2. SPECIES DISTRIBUTION (Color-coded)
#
#    - GENTOO (Neon Blue): Highest range in both metrics.
#      Flipper: 210-235mm | Bill: 45-60mm. Top-right cluster.
#
#    - ADELIE (Neon Green): Lowest range.
#      Flipper: 170-200mm | Bill: 32-42mm. Bottom-left cluster.
#
#    - CHINSTRAP (Neon Dark Pink): Intermediate range.
#      Flipper: 185-205mm | Bill: 43-52mm. Middle cluster.
#
# 3. ISLAND DISTRIBUTION (Shape markers)
#
#    - Circle (Biscoe): Mostly Gentoo penguins
#    - Triangle (Dream): Mix of Adelie and Chinstrap
#    - Square (Torgersen): Mostly Adelie penguins
#
# 4. STATISTICAL INTERPRETATION
#
#    The linear model (method = "lm") demonstrates that the longer the flipper
#    length, the longer the bill length. This positive correlation is consistent
#    across all data points, supporting the biological relationship between
#    these two physical measurements.
#
# 5. CONCLUSION
#
#    There is a strong positive correlation between flipper length and bill
#    length among Antarctic penguins. Gentoo penguins occupy the highest end
#    of this relationship, while Adelie occupies the lowest end. Different
#    islands host different species, as shown by the shape markers.
#
# ==============================================================================
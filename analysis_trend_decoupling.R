# ==============================================================================
# Project: Bovine AMR Longitudinal Analysis (Project PHOENIX)
# Script: analysis_trend_decoupling.R
# Author: Makiko Fujita
# Date: Jan 2026
# Description: 
#   Longitudinal analysis (2006-2024) of antimicrobial resistance trends in 
#   bovine E. coli. This script tests the "Decoupling Hypothesis" by comparing 
#   correlation coefficients between Colistin and alternative antibiotics 
#   before and after a hypothesized mechanism shift (e.g., chromosomal integration).
# ==============================================================================

# 1. Setup and Libraries
library(dplyr)
library(ggplot2)
library(tidyr)

# Configuration Constants
DATA_FILE_PATH <- "data/trend_2006_2024.csv"
SPLIT_YEAR     <- 2017  # Hypothesized boundary for mechanism shift

# 2. Data Loading & Validation
if(!file.exists(DATA_FILE_PATH)) {
  stop(paste("Error: Data file not found at", DATA_FILE_PATH))
}

# Load data (Standard CSV)
df_trend <- read.csv(DATA_FILE_PATH, stringsAsFactors = FALSE)

# Label periods based on the split year
df_trend <- df_trend %>%
  mutate(Period = ifelse(Year < SPLIT_YEAR, 
                         "Phase I (Plasmid-driven?)", 
                         "Phase II (Chromosomal Integration?)"))

message(paste("Data loaded successfully:", nrow(df_trend), "years of records."))

# 3. Analysis Function: Segmented Correlation Analysis
calc_cor_shift <- function(data, target_col, target_name) {
  
  # A. Overall Correlation (All Years)
  res_all <- cor.test(data[[target_col]], data$Colistin)
  
  # B. Phase I Correlation (Before Split Year)
  data_early <- subset(data, Year < SPLIT_YEAR)
  if(nrow(data_early) > 2) {
    res_early <- cor.test(data_early[[target_col]], data_early$Colistin)
    r_early   <- round(res_early$estimate, 2)
  } else {
    r_early   <- "NA (Insufficient Data)"
  }
  
  # C. Phase II Correlation (After Split Year)
  data_late <- subset(data, Year >= SPLIT_YEAR)
  if(nrow(data_late) > 2) {
    res_late <- cor.test(data_late[[target_col]], data_late$Colistin)
    r_late   <- round(res_late$estimate, 2)
  } else {
    r_late   <- "NA (Insufficient Data)"
  }
  
  # D. Output Results to Console
  message("-------------------------------------------------------")
  message(paste("Analysis Target:", target_name, "vs Colistin"))
  message("-------------------------------------------------------")
  message(paste("  Overall (2006-2024): r =", round(res_all$estimate, 2), 
                "(p =", format.pval(res_all$p.value, digits=2), ")"))
  
  message(paste("  Phase I (2006-", SPLIT_YEAR-1, "): r = ", r_early, 
                " [Potential Co-selection Era]", sep=""))
  
  message(paste("  Phase II (", SPLIT_YEAR, "-2024): r = ", r_late, 
                " [Potential Decoupling/Chromosomal Era]", sep=""))
  message("\n")
}

# 4. Execution of Analysis
message("Starting Decoupling Analysis...\n")

calc_cor_shift(df_trend, "Mix", "TMP-SMX (Mix)")
calc_cor_shift(df_trend, "TMP", "Trimethoprim")
calc_cor_shift(df_trend, "Sulfa", "Sulfamides")

# 5. Visualization
# Reshape data for ggplot (Wide to Long format)
df_long <- df_trend %>%
  pivot_longer(cols = c("Colistin", "Mix", "TMP", "Sulfa"),
               names_to = "Antibiotic", values_to = "Rate")

# Create Trend Plot
p <- ggplot(df_long, aes(x = Year, y = Rate, color = Antibiotic)) +
  geom_line(size = 1.2) +
  geom_point(size = 3) +
  
  # Vertical line indicating the potential shift year
  geom_vline(xintercept = SPLIT_YEAR - 0.5, linetype = "dashed", color = "gray50") +
  annotate("text", x = SPLIT_YEAR - 0.5, y = max(df_long$Rate), 
           label = "Hypothetical Mechanism Shift", angle = 90, vjust = -1, color = "gray50") +
  
  # Custom Color Palette
  scale_color_manual(values = c(
    "Colistin" = "#e74c3c",  
    "Mix"      = "#e67e22",  
    "TMP"      = "#3498db",  
    "Sulfa"    = "#9b59b6"   
  )) +
  
  # Labels and Theme
  labs(
    title = "Decoupling of Resistance Trends (2006-2024)",
    subtitle = "Evaluation of the Chromosomal Integration Hypothesis",
    y = "Resistance Rate (%)",
    x = "Year",
    caption = paste("Data Source: RESAPATH National Average | Split Year:", SPLIT_YEAR)
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(face = "bold", size = 14),
    legend.position = "bottom",
    axis.text = element_text(size = 10)
  )

# 6. Save Plot
print(p)
output_filename <- "plots/trend_decoupling_analysis.png"
ggsave(output_filename, plot = p, width = 10, height = 6, bg = "white")

message(paste("Analysis completed. Plot saved to:", output_filename))

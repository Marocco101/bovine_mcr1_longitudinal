# Project: Longitudinal Analysis of Colistin Resistance Decoupling (2006-2024)

## Overview

This repository contains a longitudinal analysis (2006-2024) of antimicrobial resistance trends in bovine *E. coli* in France. 

## Objective

The primary objective is to test the **"Decoupling Hypothesis"**: the theory that Colistin resistance has transitioned from a plasmid-mediated mechanism (co-selected by other antibiotics) to a stabilized and chromosomally integrated mechanism that is independent of external selection pressure.

## Data Source

* **Source:** RESAPATH (Réseau d'épidémiosurveillance de l'antibiorésistance des bactéries pathogènes animales)
* **Dataset:** National aggregated resistance trends (Évolution nationale).
* **Target Population:** Bovine (Cattle), including adults and calves.
* **Target Pathogen:** *Escherichia coli* (Clinical isolates from diseased animals).
* **Period:** 2006 – 2024 (19 years).
* **Antibiotics Analyzed:**
    * Colistin
    * Trimethoprim-Sulfamethoxazole (TMP-SMX / Cotrimoxazole)
    * Trimethoprim
    * Sulfonamides
* **Metric:** Proportion of non-susceptible isolates (Resistance Rate %).
* **URL:** [RESAPATH Official Website](https://resapath.anses.fr/)

## Methodology
To test the Decoupling Hypothesis, we employed a segmented time-series correlation analysis.

### 1. Data Pre-processing
* **Data Aggregation:** Annual resistance rates (%) for Bovine *E. coli* were compiled into a structured dataset.
* **Target Variables:**
    * Dependent Variable: Colistin Resistance Rate.
    * Independent Variables: Resistance Rates of co-selecting agents (TMP-SMX, Trimethoprim, Sulfamides).

### 2. Statistical Analysis
We performed **Pearson's Correlation Analysis** to evaluate the strength and direction of the linear relationship between antibiotic usages.

* **Metric:** Pearson's correlation coefficient ($r$) and Coefficient of Determination ($R^2$).
* **Significance Level:** $p$-value < 0.05 was considered statistically significant.

### 3. Hypothesis-Driven Segmentation (Structural Break Test)
To investigate the potential shift in resistance mechanisms, the timeframe (2006-2024) was segmented into two distinct phases based on the inflection point of resistance trends:

* **Phase I (2006-2016): The "Co-selection" Era**
    * Period characterized by parallel trends between Colistin and Sulfonamide-based antibiotics.
    * Hypothesis: Resistance is driven by plasmid-mediated co-selection.
* **Phase II (2017-2024): The "Decoupling" Era**
    * Period characterized by the stabilization of Colistin resistance despite fluctuations in other antibiotics.
    * Hypothesis: Resistance is maintained by chromosomal integration (independent of external pressure).

### 4. Computational Tools
* **Language:** R (Statistical Computing).
* **Packages:**
    * `dplyr` for data manipulation.
    * `ggplot2` for trend visualization.

## Results (Summary)

## Key Findings: Evidence of Mechanism Shift

Our segmented correlation analysis reveals a significant structural break in the relationship between **TMP-SMX (Trimethoprim-Sulfamethoxazole)** resistance trends and **Colistin** resistance trends around 2017.

### Statistical Summary Table (Pearson's Correlation Coefficient $r$)

| Antibiotic | Overall (2006-2024) | Phase I (2006-2016) | Phase II (2017-2024) | Interpretation |
| :--- | :---: | :---: | :---: | :--- |
| **TMP-SMX (Mix)** | r = -0.15 (p=0.53) | **r = 0.85** (Strong) | r = 0.51 (Moderate) | **Clear Decoupling.** Shift from strong co-selection to weakened association. |
| **Trimethoprim** | r = -0.42 (p=0.07) | r = 0.20 (Weak) | r = 0.34 (Weak) | Consistently weak correlation. |
| **Sulfamides** | **r = 0.51** (p=0.03*) | r = 0.44 (Moderate) | r = 0.30 (Weak) | Historically significant driver, but influence is fading. |

#### 1. Phase I: The "Plasmid Era" (2006-2016)
* **Correlation ($r$): 0.85** (Strong Positive)
* **Interpretation:** During this period, Colistin resistance was strongly linked to TMP-SMX resistance. This suggests a classic **plasmid-mediated co-selection** mechanism, where the use of sulfonamides likely maintained Colistin resistance genes.

#### 2. Phase II: The "Decoupling Era" (2017-2024)
* **Correlation ($r$): 0.51** (Weakened)
* **Interpretation:** The correlation significantly dropped between 2017-2024. This **"decoupling"** indicates that Colistin resistance is no longer primarily driven by the co-selection pressure of alternative antibiotics.
* **Implication:** This supports the hypothesis that resistance determinants may have stabilized via **chromosomal integration** or other autonomous mechanisms, rendering them less sensitive to ecological interventions.

### Critical Insight: The TMP-SMX Decoupling (R-squared Analysis)

To quantify the impact of the mechanism shift, we analyzed the Coefficient of Determination ($R^2$).

* **Phase I (Plasmid Era, 2006-2016):**
    * **$r = 0.85 \rightarrow R^2 = 0.72$**
    * **Interpretation:** TMP-SMX resistance trends explained **72%** of the variance in Colistin resistance. This high dependency confirms that resistance was driven mainly by co-selection pressure.

* **Phase II (Decoupling Era, 2017-2024):**
    * **$r = 0.51 \rightarrow R^2 = 0.26$**
    * **Interpretation:** The explanatory power dropped drastically to **26%**.
    * **Conclusion:** This implies that **74%** of the Colistin resistance dynamics in recent years **cannot be explained by the resistance trends of co-selecting agents**. This "unexplained variance" strongly supports the hypothesis of stabilization via **chromosomal integration**, which maintains resistance independently of external pressure.

## Visual Analysis

### Decoupling of Resistance Trends
The following plot illustrates the divergence of resistance trends. Note the shift from parallel trends (Phase I) to independent fluctuations (Phase II).

![Trend Decoupling Analysis](trend_decoupling_analysis.jpg)

---

## Discussion

### The "Decoupling" Phenomenon: A Sign of Stabilized Resistance
The most significant finding of this longitudinal analysis is the structural break in the correlation between Colistin and TMP-SMX resistance around 2017. 

During the initial phase (2006-2016), the high coefficient of determination ($R^2 = 0.72$) indicates that Colistin resistance was primarily an 'accidental passenger', maintained by the selective pressure of sulfonamides acting on multidrug resistance plasmids. However, the dramatic decrease in explanatory power in the recent phase ($R^2 = 0.26$, 2017-2024) indicates a fundamental shift. 

**Why did the correlation break?**
The fact that 74% of the variance is now 'unexplained' by antibiotic trends strongly supports the hypothesis that the resistance mechanism has evolved. We propose that the *mcr-1* gene has transitioned from a high-fitness-cost, plasmid-borne state to a **stabilized, chromosomally integrated state** (likely via the Tn*6330* transposon). Once integrated, the gene becomes vertically inherited and highly stable, persisting independently of external antibiotic pressure.

### The "Ecological Blind Spot"
This decoupling reveals a critical limitation in current surveillance strategies. If resistance determinants have indeed stabilized on the chromosome, standard interventions such as reducing the usage of co-selecting agents may be less effective. The resistance has likely become "hard-wired" into the bacterial population.

---

## Conclusion

This preliminary ecological study provides compelling statistical evidence that the mechanisms driving Colistin resistance in French bovine *E. coli* have shifted from a "Plasmid Era" to a "Decoupling Era." 

**To confirm this hypothesis, macroscopic trend analysis is no longer sufficient.**

My PhD thesis proposal aims to bridge this gap by applying **Whole Genome Sequencing (WGS)** to historical and contemporary isolates. By characterizing the genetic context of *mcr-1* (plasmid vs. chromosome) and its flanking regions (IS*Apl1*), we aim to provide the high-resolution evidence needed to update surveillance strategies for this persistent threat.

---
*Author: Makiko Fujita-Suzanne*

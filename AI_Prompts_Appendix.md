# AI Assistance Declaration and Prompt Appendix
Tool: ChatGPT, GPT-6. Date: 2026-10-31.
Purpose: ideation, cleaning-plan suggestions, syntax drafting and documentation. The student must manually verify all results.

## Actual prompts discussed
1. Seed: “I have a sales dataset in R with missing customer IDs, inconsistent region names, and outliers in revenue. What are common data cleaning steps I should perform using dplyr?”
   Key response: Inspect missingness, duplicates, category formatting, and extreme numeric values before applying justified rules.
2. Refinement: “Here is a sample of my data (first 10 rows). Suggest R code using dplyr to fix these issues.”
   Key response: Use `distinct()`, `filter()`, `mutate()`, `trimws()`, and `table()`; first check the real column names.
3. Critique: “Please explain what each line of your suggested R code does, and how I can confirm it worked correctly.”
   Key response: Compare `nrow()`, `summary()`, `colSums(is.na())`, `table()` and duplicate counts.
4. Debugging: “The assignment mentions CustomerID, Region, and Revenue but the supplied CSV contains OrderID, Product, Quantity, Price, Customer. How should I revise the cleaning pipeline?”
   Key response: Do not fabricate columns; use actual fields, and optionally derive Revenue from Quantity * Price.
5. Refinement: “Simplify this mutate() chain for readability.”
   Key response: Standardize Product and Customer in one `mutate()` and derive Revenue.
6. Validation: “Does this cleaning pipeline follow tidyverse best practices? Suggest improvements.”
   Key response: Quarantine conflicting OrderIDs, make outlier rules explicit, and assert invariants.

These are AI-assisted drafting prompts and response summaries, not evidence of code execution.

# AI Assistance Declaration
# I used ChatGPT (GPT-6, 2026-10-31) to brainstorm and draft R syntax.
# Prompts and key responses are in AI_Prompts_Appendix.md.
# I must verify outputs myself in RStudio and independently in Sheets.
# All final calculations are my responsibility.
#
# BDA400 Assignment 4 | Tejeswari Ramoju
# Source: sales_data_dirty.csv (synthetic course dataset)
# Actual columns: OrderID, Product, Quantity, Price, Customer
# NOTE: There are NO CustomerID, Region, or Revenue columns in the source.
# Run with working directory set to the folder containing the CSV.

if (!requireNamespace("dplyr", quietly = TRUE))
  stop("Please install dplyr: install.packages('dplyr')")
library(dplyr)

raw <- read.csv("sales_data_dirty.csv", stringsAsFactors = FALSE)
required <- c("OrderID", "Product", "Quantity", "Price", "Customer")
stopifnot(identical(names(raw), required))

# Step 1: Inspect raw data using the required exploration functions.
cat("=== BEFORE CLEANING ===\n")
cat("Rows:", nrow(raw), "\n")
print(summary(raw))
glimpse(raw)
print(table(raw$Product, useNA = "ifany"))
print(table(raw$Customer, useNA = "ifany"))
cat("Missing per column:\n"); print(colSums(is.na(raw)))
cat("Exact duplicate rows:", sum(duplicated(raw)), "\n")
cat("Repeated OrderIDs:", sum(duplicated(raw$OrderID)), "\n")
cat("Quantity <= 0:", sum(raw$Quantity <= 0, na.rm = TRUE), "\n")
cat("Quantity > 100:", sum(raw$Quantity > 100, na.rm = TRUE), "\n")

# Step 2: Remove exact duplicates, then quarantine conflicting order IDs.
unique_rows <- distinct(raw)
conflicting_ids <- unique_rows %>%
  count(OrderID) %>% filter(n > 1) %>% pull(OrderID)
conflicts <- unique_rows %>% filter(OrderID %in% conflicting_ids)
write.csv(conflicts, "conflicting_orders_review.csv", row.names = FALSE)

# Cleaning rules: do not invent missing products or quantities.
# Positive quantity and price are required for a completed sale.
# Quantity > 100 is an ASSUMED business threshold, not a statistical fact.
# Trim whitespace and normalize case for Product and Customer.
clean <- unique_rows %>%
  filter(!OrderID %in% conflicting_ids) %>%
  filter(!is.na(Product), !is.na(Quantity)) %>%
  filter(Quantity > 0, Quantity <= 100, Price > 0) %>%
  mutate(Product = tools::toTitleCase(tolower(trimws(Product))),
         Customer = tools::toTitleCase(tolower(trimws(Customer))),
         Revenue = Quantity * Price) %>%
  arrange(OrderID)

write.csv(clean, "sales_data_cleaned.csv", row.names = FALSE)

# Step 2 verification: compare before/after and test invariants.
cat("\n=== AFTER CLEANING ===\n")
cat("Rows:", nrow(clean), "\n")
print(summary(clean))
glimpse(clean)
print(table(clean$Product, useNA = "ifany"))
print(table(clean$Customer, useNA = "ifany"))
cat("Missing per column:\n"); print(colSums(is.na(clean)))
cat("Exact duplicate rows:", sum(duplicated(clean)), "\n")
cat("Repeated OrderIDs:", sum(duplicated(clean$OrderID)), "\n")
cat("Excluded conflicting IDs:", paste(conflicting_ids, collapse = ", "), "\n")
stopifnot(nrow(clean) <= nrow(raw), !anyNA(clean),
          !anyDuplicated(clean$OrderID),
          all(clean$Quantity > 0 & clean$Quantity <= 100),
          all(clean$Price > 0),
          all(clean$Revenue == clean$Quantity * clean$Price))
cat("All R assertions passed.\n")

# Export a genuine R console transcript for submission.
# This reruns the script under capture.output() when sourced by the runner
# below; do NOT claim the log exists until you execute the R script.

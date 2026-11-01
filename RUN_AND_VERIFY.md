# Run and verify before LMS submission
1. Open RStudio, set the working directory to this folder.
2. Install dplyr if necessary: `install.packages("dplyr")`.
3. Run `source("Clean_sales_data.R", echo=TRUE)` and review results.
4. For authentic R console evidence, run:
   `capture.output(source("Clean_sales_data.R", echo=TRUE), file="RStudio_Actual_Output_Log.txt")`
5. Open the generated log and confirm there were no errors. Capture a screenshot if preferred.
6. Independently cross-check counts and a sample of rows in Google Sheets, then self/peer spot-check.
7. Evaluate whether the assumed Quantity > 100 threshold makes sense.
8. Write the 100–150-word reflection yourself in the supplied .txt file.
9. Replace the preview with authentic RStudio evidence or keep both clearly labeled.
10. Rezip this folder.

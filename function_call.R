# Source the files in the correct order to ensure dependencies are met.
source("source/auto_feature_binning_main.R")

# Now, call the main orchestration function with the test dataframe.
binned_results <- auto_feature_binning(
  df = test_df,
  target_col = "price",
  date_col = "order_date",
  output_dir = 'output',
  log_file_name = "binning_log.txt",
  summary_csv_name = "feature_summary.csv",
  html_report_name = "binning_report.html",
  sql_file_name = "binned_features.sql",
  clip_the_metric = TRUE,
  datetime_freq = 'weeks', #days, weeks or NULL
  smalls_threshold_pct = 0.5,
  top_value_pct = 90,
  top_n_cat = 10,
  unique_val_threshold = 10,
  generate_plots = TRUE,
  rpart_cp = 0.001
)

# Access the outputs from the list
final_df <- binned_results$df
binned_column_names <- binned_results$binned_cols
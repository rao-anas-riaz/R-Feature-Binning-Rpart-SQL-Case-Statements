# Automated Feature Binning & SQL Generation Pipeline for R

<p align="center">
  <img src="https://img.shields.io/badge/Language-R-blue.svg" alt="Language R">
</p>

A powerful, end-to-end R pipeline that transforms raw data into robust, production-ready binned features. It automates the entire feature engineering workflow: from data analysis and supervised binning to generating deployable SQL `CASE` statements and interactive stability reports. Go from raw data to actionable, stable features in a single command.

***

## Table of Contents
* [Why This Pipeline is a Game-Changer](#why-this-pipeline-is-a-game-changer)
* [Ultra-Detailed Workflow Diagram](#ultra-detailed-workflow-diagram)
* [The Architecture: Core Functions & Logic](#️the-architecture-core-functions-and-logic)
* [Parameter Deep Dive](#️parameter-deep-dive)
* [Understanding the Outputs](#understanding-the-outputs)
* [Getting Started: A Practical Guide](#getting-started-a-practical-guide)
* [Dependencies](#dependencies)

***

## Why This Pipeline is a Game Changer

This isn't just a binning script; it's a comprehensive feature engineering and MLOps accelerator. It automates the complex, iterative, and critical process of creating features that are not only predictive but also stable and ready for production deployment.

### For Data Scientists & ML Engineers
* **Massively Accelerate Feature Engineering:** The most time-consuming part of modeling is often creating meaningful features. This pipeline automates the entire process of supervised binning, allowing you to generate dozens of high-quality features in minutes, not days.
* **Capture Non-Linearity Effortlessly:** By using a decision tree (`rpart`) for binning, the pipeline automatically discovers non-linear relationships between your features and the target variable. It finds the optimal splits in the data that you might miss with manual binning or bucketing.
* **Build More Robust Models:**
    * **Reduces Overfitting:** Binning converts noisy, high-cardinality features into a smaller set of more stable bins, making your models less likely to overfit.
    * **Handles Outliers Automatically:** Extreme values are naturally grouped into the first or last bin, mitigating their influence without requiring separate outlier treatment.
    * **Improves Interpretability:** A model built on 5-10 binned groups for a feature is far easier to explain to stakeholders than a model with hundreds of raw categories or complex continuous coefficients.
* **Proactive Model Monitoring Foundation:** The generated stability plots are a powerful tool for detecting data and concept drift. You can see precisely when a feature's distribution shifts or its predictive relationship with the target degrades, signaling that your model may need retraining.

### For Data & Analytics Engineers
* **Bridge the Gap to Production:** The single biggest challenge in MLOps is often translating a model's logic from a notebook (R/Python) into production-ready SQL. This pipeline solves that by **automatically generating the exact `CASE` statements** needed to replicate the feature logic in any standard SQL database.
* **Standardize Feature Creation:** Ensures that every feature is created using a consistent, reproducible, and version-controllable process. This eliminates the "it works on my machine" problem and enforces best practices across the team.
* **ETL & Data Pipeline Validation:** The detailed `feature_summary.csv` and stability reports can be used to validate data quality and distributions at various points in your data pipelines, ensuring data integrity from source to model.

### For Team Leads & Analytics Managers
* **Increase Team Velocity & ROI:** By automating a major analytics bottleneck, this pipeline frees up your highly skilled data scientists to focus on higher-value tasks like model selection, tuning, and solving new business problems, dramatically shortening project timelines.
* **Demystify Feature Engineering:** The interactive HTML report and clear SQL logic make the feature creation process transparent and understandable, reducing the "black box" nature of modeling and fostering better collaboration between technical teams and business stakeholders.
* **Enhance Reproducibility and Governance:** Provides a fully logged, auditable trail of how features were created, which is critical for governance, compliance, and debugging production models.

***

## Ultra Detailed Workflow Diagram

The pipeline executes a sophisticated, multi-phase process. This diagram details every logical step from raw data to final outputs.

```
+--------------------------------------------------------------------------+
| PHASE 1: SETUP & INITIALIZATION                                          |
|  [auto_feature_binning_main.R]                                           |
|                                                                          |
|  +-> Set up global logging to console and file.                          |
|  +-> Create output directory.                                            |
|  +-> Validate and load all required R libraries.                         |
|  L-> Source all helper function scripts.                                 |
+--------------------------------------------------------------------------+
                                |
                                V
+--------------------------------------------------------------------------+
| PHASE 2: DATA PREPARATION & ANALYSIS                                     |
|  [auto_feature_binning_main.R] -> Orchestrates                           |
|                                                                          |
|  +-> Convert input to data.table and standardize column names.           |
|  +-> (Optional) Clip target variable at 1%/99% to reduce outlier skew.   |
|  +-> Call [detect_data_types.R] -> Infer true data type for each column. |
|  +-> Identify and convert secondary datetime columns to numeric          |
|  |   (e.g., 'weeks_since_signup_date').                                  |
|  L-> Call [summarize_feature.R] -> For every column, calculate:          |
|      |   - Null percentages (Logical, Character, Empty String)           |
|      |   - Cardinality (unique value count)                              |
|      |   - Top N categories and their percentages                        |
|                                                                          |
|  [Output Artifact: feature_summary.csv]                                  |
+--------------------------------------------------------------------------+
                                |
                                V
+--------------------------------------------------------------------------+
| PHASE 3: FEATURE CLASSIFICATION FOR BINNING                              |
|  [auto_feature_binning_main.R]                                           |
|                                                                          |
|  +-> Use feature_summary.csv to classify each feature into one of        |
|  |   three binning strategies based on user-defined thresholds:          |
|  |                                                                       |
|  +-- Binomial Strategy: If top category > top_value_pct (e.g., 90%).     |
|  |      |                                                                |
|  |      L-> Assign to binomial_features list.                            |
|  |                                                                       |
|  +-- Numeric Strategy: If data_type is integer/numeric AND not Binomial. |
|  |      |                                                                |
|  |      L-> Assign to numeric_features list.                             |
|  |                                                                       |
|  L-- Character Strategy: If data_type is character AND not Binomial.     |
|         |                                                                |
|         L-> Assign to character_features list.                           |
+--------------------------------------------------------------------------+
                                |
                                V
+--------------------------------------------------------------------------+
| PHASE 4: BINNING EXECUTION (The Core Engine)                             |
|                                                                          |
|  +-> [bin_binomial_features.R] -> For each feature in its list:          |
|  |   |  - Find the top category.                                         |
|  |   |  - Bin 1: Top category.                                           |
|  |   L- Bin 2: All other non-null categories.                            |
|  |                                                                       |
|  +-> [bin_numeric_features.R] -> For each feature in its list:           |
|  |   |  - Train an rpart decision tree (target ~ feature_value).         |
|  |   |  - Each leaf node of the tree becomes a distinct bin.             |
|  |   L- Extract tree split points for SQL generation.                    |
|  |                                                                       |
|  L-> [bin_character_features.R] -> For each feature in its list:         |
|      |  - Step 1: Group rare categories (< smalls_threshold_pct)         |
|      |    into a single 'smalls' category.                               |
|      |  - Step 2: Calculate mean target for all other categories.        |
|      |  - Step 3: Train an rpart tree on the mean target values.         |
|      L- Each leaf node groups categories with similar target behavior.   |
+--------------------------------------------------------------------------+
                                |
                                V
+--------------------------------------------------------------------------+
| PHASE 5: CONSOLIDATION & REPORTING                                       |
|                                                                          |
|  +-> [auto_feature_binning_main.R] -> Consolidate SQL CASE statements    |
|  |   from all three binning functions.                                   |
|  |   [Output Artifact: binned_features.sql]                              |
|  |                                                                       |
|  L-> [generate_stability_plots.R] -> For each new binned_* column:       |
|      |  - Generate Volume Stability Plot (distribution over time).       |
|      |  - Generate Mean Target Plot (predictive power over time).        |
|      |  - Generate Rank Stability Plot (relative performance over time). |
|      L- Assemble all plots into a single interactive HTML file.          |
|         [Output Artifact: binning_report.html]                           |
+--------------------------------------------------------------------------+
                                |
                                V
+--------------------------------------------------------------------------+
| PHASE 8: FINAL OUTPUTS                                                   |
|                                                                          |
|  +-> [Output File: feature_summary.csv]                                  |
|  +-> [Output File: binned_feature_stability_report.html]                 |
|  +-> [Output File: data_profiler_log.txt]                                |
|  L-> [Output File: binned_feature_case_statements.sql]                   |
|                                                                          |
+--------------------------------------------------------------------------+
```
***

## The Architecture Core Functions and Logic

The pipeline's power stems from its modular design, where each script is a specialized engine for a specific task.

* `auto_feature_binning_main.R`
    The **Master Orchestrator**. This is the main script you call. It's the brain of the operation, responsible for setup, parameter validation, and invoking all other functions in the correct sequence. It manages the state of the main dataframe as it's passed from one processing step to the next.

* `detect_data_types.R` & `summarize_feature.R`
    The **Analysis & Profiling Engine**. This duo works together to build a deep understanding of the raw data. `detect_data_types` goes beyond basic classes to infer the true nature of columns, while `summarize_feature` computes the critical statistics (nulls, cardinality, distributions) that drive the entire classification and binning process.

* `bin_numeric_features.R`
    The **Numeric Binning Engine**. This script applies the supervised decision tree (`rpart`) directly to numeric features. Its sole purpose is to find the optimal breakpoints in a continuous or integer variable that best predict the target, effectively performing a non-linear transformation.

* `bin_character_features.R`
    The **Categorical Binning Engine**. This is the most sophisticated module. It implements a robust, two-stage strategy to handle the complexity of categorical variables: first by reducing noise from rare categories ("smalls"), and second by using target encoding as a bridge to apply a powerful decision tree model for intelligent grouping.

* `bin_binomial_features.R`
    The **High-Skew Engine**. This specialized, simpler function is designed for stability. It handles features that are nearly constant by creating a simple but highly stable "dominant vs. other" feature, preventing the main `rpart` algorithms from creating trivial or unstable splits.

* `generate_stability_plots.R`
    The **Drift Detection & Visualization Factory**. This script is called after binning is complete. For every newly created feature, it aggregates data over time and uses `plotly` to build the three crucial stability plots. It's the key to understanding if your new features are reliable for future use.

***

## Parameter Deep Dive

The main `auto_feature_binning` function is highly tunable. Mastering these parameters allows you to precisely control the binning process.

| Parameter              | Description & Pro-Tips                                                                                                                                                                                                                                                         | Default Value |
| ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ | ------------- |
| `df`                   | The input `data.frame` or `data.table`.                                                                                                                                                                                                                                        |  **Required** |
| `target_col`           | The name of the numeric target variable. **This is the core of "supervised" binning.** The entire `rpart` process uses this variable to guide how bins are created.                                                                                                            |  **Required** |
| `date_col`             | The name of the primary date column. **How it affects output:** This is essential for generating the time-series stability plots. Without it, the stability report cannot be created.                                                                                          |  **Required** |
| `smalls_threshold_pct` | The volume percentage below which a category is grouped into "smalls" in character binning. **Pro-Tip:** This also influences the `minbucket` size for the `rpart` tree, acting as a key regularization parameter to prevent overfitting.                                      | `0.5`         |
| `top_value_pct`        | The percentage a feature's top category must exceed to be classified as "binomial". **Pro-Tip:** The default of `90` is good for most cases. Lower it to `80-85` if you want to more aggressively apply the simple binomial strategy.                                          | `90`          |
| `unique_val_threshold` | Features with fewer unique values than this threshold will be skipped. **Pro-Tip:** This prevents the script from binning already low-cardinality features like booleans or day-of-week.                                                                                       | `10`          |
| `rpart_cp`             | The Complexity Parameter (`cp`) for the `rpart` tree. **This is the most sensitive tuning parameter.** A smaller value (e.g., `0.001`) will encourage the tree to make more splits, creating more granular bins. A larger value (e.g., `0.01`) will create fewer, broader bins.| `0.002`       |
| `clip_the_metric`      | If `TRUE`, clips the target variable at the 1st and 99th percentiles. **Pro-Tip:** Keep this as `TRUE` unless you have a specific reason not to. It makes the `rpart` algorithm much more stable by preventing extreme outliers in the target from dominating the splits.      | `TRUE`        |
| `datetime_freq`        | Converts other datetime columns into numeric "time since" features before binning. Options: `'weeks'`, `'days'`, or `NULL`. **Pro-Tip:** `'weeks'` is often a great choice as it smooths out daily noise.                                                                      | `'weeks'`     |
| `output_dir`           | The folder where all output files will be saved.                                                                                                                                                                                                                               | `getwd()`     |
| `generate_plots`       | Master switch to generate the HTML stability report. **Pro-Tip:** Set to `FALSE` if you are running in a non-interactive environment or only need the SQL code and the updated dataframe.                                                                                      | `TRUE`        |

***

## Understanding the Outputs

The script generates four mission-critical files in your specified `output_dir`:

1.  **`binning_report.html`**
    The star of the show. A single, self-contained, interactive HTML file that can be shared with anyone.
    * It contains a separate section for every single feature that was binned.
    * Each section contains three interactive `plotly` charts, sharing a common time axis:
        * **Volume Stability:** A 100% stacked area chart showing the percentage of each bin over time. *Use this to spot population drift.*
        * **Mean Target Stability:** A line plot showing the average target value for each bin over time. *Use this to spot concept drift where a bin's meaning changes.*
        * **Rank Stability:** A line plot showing the performance rank of each bin over time. *Use this to see if your best-performing bins are consistently the best.*

2.  **`binned_features.sql`**
    Your ticket to production. This file contains a SQL `CASE` statement for every binned feature. This is not an approximation, it is the exact logic required to replicate the feature in a database environment. It is formatted and ready to be copy-pasted into an ETL script or a database view.

3.  **`feature_summary.csv`**
    The data dictionary on demand. A detailed CSV containing a full statistical profile of every column in the *original* data. This is invaluable for initial data exploration and for documenting your data assets.

4.  **`binning_log.txt`**
    Your audit and debugging trail. A verbose, timestamped log of the entire pipeline's execution. It records all parameters used, decisions made (e.g., how many features were classified as numeric), and any warnings or errors encountered.

***

## Getting Started: A Practical Guide

1.  **File Structure**: Place all the downloaded `.R` script files into a sub-directory named `source`. Your main script should be in the parent directory.

    ```
    /my_ml_project
        |- run_binning.R  (Your script)
        └- /source
            |- auto_feature_binning_main.R
            |- bin_numeric_features.R
            |- ... (all other .R files)
    ```

2.  **Run Script**: In your `run_binning.R` file, load your data, source the main profiler script, and call the main function with your parameters.

    ```R
    # run_binning.R

    # 1. Load required libraries and your dataset
    library(data.table)
    # Using the test data generator from the previous step
    source("path/to/your/test_data_generator.R") 
    my_data <- df_test # Assume df_test is the generated data.table

    # 2. Source the main binning script (it will source all its helpers)
    source("source/auto_feature_binning_main.R")

    # 3. Run the pipeline!
    
    # --- Simple Example ---
    # Run with default settings on the test data
    results_default <- auto_feature_binning(
      df = my_data,
      target_col = "price",
      date_col = "order_date",
      output_dir = "binning_output_default"
    )

    # --- Advanced Example with Tuning ---
    # Create more granular bins and be more sensitive to small categories
    results_tuned <- auto_feature_binning(
      df = my_data,
      target_col = "price",
      date_col = "order_date",
      output_dir = "binning_output_tuned",
      smalls_threshold_pct = 1,  # Group categories below 1% into smalls
      rpart_cp = 0.0005,         # Encourage more splits for finer bins
      top_value_pct = 95         # Be less aggressive with binomial classification
    )

    # The function returns a list with the updated dataframe and binned column names
    final_df_tuned <- results_tuned$df
    ```
    After running, explore the `binning_output...` folders to find your HTML report, SQL file, and other outputs.

### Showcase: A Look at the Output

To demonstrate the tool's capabilities, a sample report generated from a synthetic dataset is included. The report highlights the script's ability to handle various data types and after catering for common data quality issues, generate the binned features.

**Interactive Report (HTML)**

This is an interactive HTML report which contains the stability plots for each binned feature.

* [**View Sample Report**](https://rao-anas-riaz.github.io/R-Feature-Binning-Rpart-SQL-Case-Statements/report_outputs/binning_report.html)

**Summary Statistics (CSV)**

A companion CSV file is generated with all the summarized data. This is useful for anyone who needs to programmatically access the profiling results.

* [**View Sample Summary**](https://github.com/rao-anas-riaz/R-Feature-Binning-Rpart-SQL-Case-Statements/blob/main/report_outputs/feature_summary.csv)

**Case Statements for binned features (SQL)**

This file contains a SQL `CASE` statement for every binned feature. This is not an approximation, it is the exact logic required to replicate the feature in a database environment.

* [**View Sample SQL Case Statements**](https://github.com/rao-anas-riaz/R-Feature-Binning-Rpart-SQL-Case-Statements/blob/main/report_outputs/binned_features.sql)

## Dependencies
The script will automatically check for and offer to install the following required R packages:
- `data.table`
- `dplyr`
- `ggplot2`
- `plotly`
- `lubridate`
- `stringr`
- `htmltools`
- `htmlwidgets`
- `rpart`
- `rpart.plot`

### License
This project is made available for informational purposes only. The intellectual property and source code remain the exclusive property of the author. No part of the source code may be copied, distributed, or modified without explicit permission.





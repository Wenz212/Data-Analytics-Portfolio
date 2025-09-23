Laptop Price Analysis & Predictive Modeling

This project analyzes laptop specifications to understand key drivers of pricing and builds predictive models to estimate laptop prices.  
End-to-end workflow: data cleaning → EDA → feature engineering → regression baselines → regularization with Ridge + cross-validation → model selection.

**Tech Stack**: Python (pandas, NumPy, scikit-learn), Matplotlib, Seaborn 

Tech stack: Python (pandas, NumPy, scikit-learn, Matplotlib, Seaborn) 

Business Objective:

- “How can we predict a reasonable price for new laptop models?”</strong></li>
- “Given limited resources, which specifications deserve the most investment to maximize consumer willingness to pay?”


  
Objectives: 

Main topic - This project investigates which laptop specifications most strongly influence pricing, and develops predictive models to estimate laptop prices with improved generalization through regularization.
- Clean and preprocess raw laptop data.
- Explore feature–price relationships across CPU, RAM, storage, GPU, OS, and categories.
- Build regression models (Linear, Polynomial, Ridge).
- Evaluate performance using MSE and R², addressing underfitting and overfitting.
- Communicate actionable insights with clear visuals.



Dataset:

The dataset contains laptop specifications (CPU frequency, RAM, storage, GPU, OS, category) and price labels.  
Originally adapted from an educational source, reformatted for independent analysis.


Workflow:

1. Data Wrangling
   - Remove helper columns; fix types and units (e.g., cm→inch, kg→lb).
   - Impute missing values by variable role: mean for continuous (`Weight`), mode for near-discrete (`Screen_Size_inch`).
   - Normalize scalars where needed and one-hot encode screen panel types.
A clean, well-typed table for reliable EDA and modelin.

2. Exploratory Data Analysis (EDA)
  - Univariate distributions and price binning to see the coverage.
     - **Correlation and regression plots** to rank signal:
       - Stronger positive links: **`RAM_GB` (~0.55)**, **`CPU_core` (~0.46)**, **`CPU_frequency` (~0.37)**.
       - Moderate: `Storage_GB_SSD` (~0.24), `GPU`/`Category` (~0.29).
       - Weak/negative: `screen size` (-0.11), `weight` (-0.05), `OS` (-0.22).  
     - Pivot/heatmaps (e.g., `GPU × CPU_core → mean Price`) to visualize price ladders.
Confirms where price signal lives(CPU_frequency) and guards against “feature cargo-culting”

3. Baseline - Model Development
   - Single linear on `CPU_frequency`: R² ≈ 0.13, MSE ≈ 284,583 → *underfits*.
   - Multiple linear on key specs: R² ≈ 0.51, MSE ≈ 161,681 → substantial gain.
   - Polynomial (CPU only) degrees 3/5: **R² ≈ 0.27/0.30**, **MSE ↓ to ~229k** → captures curvature but still limited (single-feature).
Among the baseline models, multiple linear regression provides the best balance of fit and interpretability, confirming that laptop pricing depends on multiple specifications rather than a single feature. However, the model still shows signs of bias/variance tradeoff, motivating the use of polynomial expansion and regularization (Ridge).


4. Model Evaluation & Refinement(solve under/overfitting)
   - Cross-validation** on the single-feature model shows unstable, often negative R² → confirms poor generalization.
   - Ridge Regression** on *polynomial features of all key specs (degree=2):
     - Train/test R² tracked across α; test R² peaks around 0.42–0.424.
     - GridSearchCV confirms the optimum α, reproducing test R² ≈ 0.422.
Ridge regression on polynomial features successfully reduced overfitting and improved generalization compared to plain polynomial regression. While the overall R² (~0.42) is moderate, it is stable across folds, indicating that the model captures key non-linear effects without excessive variance. This highlights the value of regularization in balancing model complexity and predictive reliability for real-world pricing tasks.

Results:
The refined Ridge regression model demonstrated stronger predictive power than simpler baselines, confirming that laptop pricing cannot be captured by a single specification alone. Regularization allowed the model to generalize better while still reflecting the dominant influence of CPU frequency and RAM. The analysis suggests that performance-related specifications are the primary drivers of laptop prices, while storage, GPU, and OS play secondary roles. This project highlights the practical need for balancing interpretability and accuracy in real-world pricing models—insights that can inform both product positioning and data-driven pricing strategies.


Key Insights:
- Spec importance: Laptop prices are strongly driven by RAM (r ≈ 0.55), CPU cores (r ≈ 0.46), and CPU frequency (r ≈ 0.37). Screen size (–0.11) and weight (–0.05) have negligible or negative influence → performance specs matter far more than physical design.
- Storage & GPU: SSD capacity (r ≈ 0.24) and GPU presence (~0.29) moderately raise price but are secondary to CPU/RAM.
- OS effect: Operating system shows a negative correlation (~–0.22), meaning consumers won’t pay a premium for software differences; hardware dominates pricing.
- Model performance:
	- Single-variable regression on CPU frequency underfits (R² ≈ 0.13).
	- Multiple regression with CPU, RAM, and storage improves fit (R² ≈ 0.51).
	- Polynomial features capture non-linear effects but risk overfitting.
	- Ridge regression with tuned α balances bias–variance tradeoff, achieving validation R² ≈ 0.42.


Business Implications
- Product positioning:
	- Manufacturers should differentiate premium laptops with higher RAM and multi-core CPUs, as these directly justify higher price points.
	- Lightweight design and screen size can be secondary marketing features, not primary pricing drivers.
- Pricing strategy:
	- Mid-market laptops with moderate CPU/RAM offer the best performance-to-price ratio, ideal for budget-conscious buyers.
	- Premium models should emphasize RAM upgrades + high-frequency CPUs to capture price-sensitive but performance-oriented customers.
- Inventory & bundling:
	- Retailers should prioritize configurations with 8–16GB RAM and ≥4 CPU cores, aligning stock with demand signals to maximize revenue per unit.
- Market insight:
	- Negative OS correlation suggests OEMs should bundle OS at minimal markup, while reserving pricing premiums for hardware upgrades.


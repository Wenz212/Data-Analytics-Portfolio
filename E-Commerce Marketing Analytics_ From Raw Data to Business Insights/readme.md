# 🛍️ E-Commerce Marketing Analytics  
**From Data to Business Insights**  
*A full-funnel and retention-driven analysis of coupon marketing performance in an online retail context.*

---
## Dashboard banner preview
<img width="1536" height="1024" alt="image" src="https://github.com/user-attachments/assets/3050360a-7383-4f49-9d77-cc92f692f41e" />

## 1. Business Context & Objective
### 🎯 Core Question  
> **How do discount coupons affect customer spending behavior and long-term engagement, and how can we maximize revenue without undermining margins?**

The project transforms raw transactional data into strategic insights to support **marketing optimization** and **customer lifecycle management**.  
It integrates **A/B testing logic**, **funnel conversion analysis**, **cohort retention tracking**, and **econometric modeling** to evaluate both short-term and long-term effects.

**Specific business objectives:**
1. Quantify the **incremental revenue impact** of coupon use.  
2. Identify **conversion frictions** across the promotional funnel.  
3. Evaluate **retention decay patterns** and opportunities for reactivation.  
4. Translate findings into **actionable growth strategies**.

---

## 2. Dataset & Structure
**Source:** [Marketing Insights for E-commerce Company (Kaggle)](https://www.kaggle.com/datasets/rishikumarrajvansh/marketing-insights-for-e-commerce-company?resource=download)  
The dataset simulates a full marketing ecosystem including product, customer, and transactional information.

**Entities**
| Table | Grain | Key Variables |
|--------|--------|----------------|
| `fact_sales` | Order-level | Transaction_ID, CustomerID, Product_Category, Discount_pct, tax_amount, net_amount, Coupon_Status (`Not Used`, `Clicked`, `Used`), AB_Groups |
| `dim_customer` | Customer-level | Gender, Location, Tenure_Months, spending and frequency bins |
| `dim_product` | Product-level | Product_Category, avg_discount_pct, avg_tax_rate |

**Granularities applied**
- **Order-level models:** cluster standard errors at `CustomerID`
- **Customer-level summaries:** use HC3 robust SEs (no clustering)
- **Cohorts:** grouped by first purchase month → `cohort_index` for months since acquisition

---

## 3. Analytical Framework

### 🧩 Design Logic
| Component | Description |
|------------|-------------|
| **Treatment Group** | Orders where `Coupon_Status = 'Used'` |
| **Control Group** | Orders without coupon usage |
| **Randomization Proxy** | Simulated through historical coupon exposure (emails, banners) |
| **Period Covered** | Jan–Dec 2019 |
| **Segmentation** | Customer value groups: Low / Mid / High / VIP |

---

## 4. Key Metrics & KPIs
| **Metric** | **Business Meaning** | **Formula** |
|-------------|----------------------|--------------|
| **Total Sales (YTD)** | Core revenue driver | `sum(net_amount)` |
| **AOV (Average Order Value)** | Revenue per transaction | `mean(net_amount)` |
| **Coupon Usage Rate** | Adoption of promotions | `n_used / n_orders` |
| **CTR (Click-Through Rate)** | Coupon engagement | `clicked / shown` |
| **Use Rate** | Coupon redemption efficiency | `used / shown` |
| **Use_given_Click** | Conversion after interest | `used / clicked` |
| **Retention (Cohort)** | Activity over months since first purchase | Avg. orders per customer per month |

---

## 5. Methods & Statistical Approach
This analysis employs both **descriptive analytics** (funnel, retention, cohort) and **causal inference** (regression modeling).

| **Method** | **Purpose** | **Implementation** |
|-------------|-------------|--------------------|
| **Welch’s T-test** | Compare group means under unequal variances | Test coupon vs. no-coupon AOV & revenue |
| **Mann–Whitney U test** | Validate robustness without normality | Confirms distributional shift |
| **Bootstrap CI (95%)** | Estimate mean difference CI non-parametrically | 10,000 resamples per group |
| **Cluster-Robust OLS** | Estimate coupon effect on order value | SEs clustered by `CustomerID` |
| **Cohort Analysis** | Measure monthly retention per acquisition cohort | Pivot by `cohort_month` × `cohort_index` |
| **Funnel Conversion Analysis** | Diagnose leakage from impressions to usage | CTR, Use Rate, Use_given_Click |
| **Correlation Matrix (KPI)** | Examine dependency between sales, AOV, and coupon rate | Pearson r across months |

---

## 6. Results & Insights

### 6.1 A/B Statistical Tests
**Finding:** Coupons significantly increase total sales but slightly reduce per-order value.  
- **Welch’s T-test:** significant difference in total sales (p < 0.001)  
- **Mann–Whitney U test:** confirms direction (p < 0.01)  
- **Bootstrap CI:** 95% confidence interval for mean difference excludes 0  

✅ **Conclusion:** Coupons boost transaction volume, not per-transaction margin.  

---

### 6.2 Regression Analysis (Cluster-Robust OLS)
Model specification:
\[
\log(1 + net\_amount) = \beta_0 + \beta_1 \text{used\_coupon} + \beta_2 \text{discount\_amount} + \beta_3 \text{tax\_amount} + \text{FE(Location × Gender)} + \varepsilon
\]

| Variable | Coefficient | Significance | Business Interpretation |
|-----------|--------------|---------------|--------------------------|
| `used_coupon` | **–0.196** | ***p < 0.001*** | Coupons reduce average order value (expected margin tradeoff). |
| `discount_amount` | **+0.013** | **p < 0.01** | Reasonable discounts stimulate higher basket sizes. |
| `tax_amount` | **+0.015** | **p < 0.01** | Proxy for expensive orders — validates elasticity pattern. |
| `Tenure_Months` | –0.001 | n.s. | Customer seniority alone does not affect spending. |

**R² = 0.195**, meaning roughly 20% of spending variance is explained by marketing and basket composition.  
Cluster-robust SEs validate model stability under customer-level correlation.

---

### 6.3 Funnel & Conversion Insights
| **Stage** | **Metric** | **Observation** |
|------------|-------------|----------------|
| Shown → Clicked | **CTR ≈ 0.8–1.0** | High engagement; coupon messages attract attention. |
| Clicked → Used | **Use Rate ≈ 0.3–0.4** | Conversion lag suggests checkout friction or lack of perceived value. |
| Segment Effect | **High/VIP users convert better** | Indicates coupons reinforce loyalty within premium groups. |

💡 *Interpretation:* Awareness campaigns are effective, but conversion friction reduces realized impact.

---

### 6.4 Cohort Retention (Repeat Purchase Behavior)
- Average orders per cohort drop sharply after **month 3**, confirming short-term engagement.  
- Early cohorts show higher initial intensity; later (Q3–Q4) cohorts retain slightly better.  
- Indicates **short-lived promotion lift**, not sustained behavioral change.

📈 *Retention window ≈ 3 months* → Ideal reactivation timing.

---

### 6.5 KPI Correlation Dashboard
| Metric Pair | Correlation (r) | Insight |
|--------------|----------------|----------|
| Total Sales ↔ AOV | **0.73** | Revenue mainly scales with average basket value. |
| Total Sales ↔ Coupon Usage | **0.23** | Coupons weakly correlated with total revenue — volume, not margin, drives sales. |
| AOV ↔ Coupon Usage | **0.26** | Coupons may increase small-basket frequency rather than premium sales. |

---

## 7. Validation & Diagnostic Checks
- ✅ **Balance Test:** No significant difference in location or tenure between control and treatment (p > 0.8).  
- ✅ **Robustness:** Mann–Whitney and Bootstrap replicate the same direction of effects.  
- ✅ **Fixed Effects:** `Location × Gender` fixed effects absorb multicollinearity.  
- ✅ **Cluster Robustness:** Controls for within-customer dependency (Eicker–Huber–White sandwich estimator).

---

## 8. Strategic Implications & Recommendations

| **Key Finding** | **Business Implication** | **Recommended Action** |
|------------------|--------------------------|--------------------------|
| Coupons lift order count but reduce order value | Margin erosion risk | Use **tiered discounts** — higher for new users, lower for repeat ones |
| Retention drops after Month 3 | Promotions are short-term drivers | Implement **reactivation campaigns** around Day 60–90 |
| High CTR but low redemption | Checkout friction / UX issue | Simplify redemption flow or **auto-apply coupons** |
| 89% Low-value customers | Revenue skewed to long-tail buyers | Introduce **membership tiers** or **spend thresholds** to grow loyalty |
| Category sensitivity varies | Misaligned discount depth | Apply **category-specific elasticity rules** (10%, 15%, 20%) |
| High-value customers convert efficiently | High ROI audience | Allocate **premium incentives** (exclusive access, early deals) |

---

## 9. Tools, Techniques & Deliverables
**Languages / Tools:** Python 3.12, Jupyter Notebook  
**Libraries:** pandas, numpy, scipy, statsmodels, seaborn, matplotlib  
**Techniques:**  
- Inferential tests (Welch, Mann–Whitney, Bootstrap)  
- Cluster-robust econometrics  
- Funnel and retention visualization  
- KPI dashboarding and correlation matrix  

**Deliverables:**  
- `ecommerce_analysis.ipynb` — complete reproducible notebook  
- `ecommerce_analysis.pdf` — formatted report  
- **Cohort heatmaps**, **Funnel charts**, **Regression tables**, **KPI dashboards**

---

## 10. Business Summary (Executive Takeaway)
> Coupons are **effective short-term volume drivers** but **inefficient profit levers**.  
> The promotion mechanism increases engagement and repeat orders briefly (≈3 months) but requires **post-promotion reactivation** to sustain customer value.


**Strategic next steps:**
- Optimize **discount tiers by segment** and **category elasticity**.  
- Launch **reactivation flows at Month 2–3**.  
- Enhance **UX for coupon redemption** to convert interest into sales.  
- Shift focus from broad discounting to **targeted incentives + loyalty programs**.  
- Integrate these KPIs into Tableau for continuous performance tracking.

---

## 11. Author
**Wen Zhang (Wenz212)**  
M.S. Economics | Marketing & Data Analytics  
📊 Specializing in causal analysis, behavioral insight, and data-driven marketing strategy  
🔗 [GitHub](https://github.com/Wenz212) · [LinkedIn](https://www.linkedin.com/in/wen-zhang-35b44a324)

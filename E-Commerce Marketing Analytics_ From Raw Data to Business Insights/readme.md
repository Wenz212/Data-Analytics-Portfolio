# E-Commerce Marketing Analytics  
**From Data to Business Insights**  
*A data-driven business analysis of coupon effectiveness and customer retention for an online retailer.*

---

## Dataset Source
The dataset used in this project originates from **[Marketing Insights for E-commerce Company (Kaggle)](https://www.kaggle.com/datasets/rishikumarrajvansh/marketing-insights-for-e-commerce-company?resource=download)**.  
It includes detailed customer, product, and transactional data — covering **coupon usage, tax amount, product category, gender, and location** — providing a realistic simulation of marketing analytics in an e-commerce environment.

---

## Objective
To answer the business question:  
> **“How do discount coupons influence customer spending behavior, and what strategies can increase long-term revenue without eroding margins?”**

Specifically, this analysis aims to:
- Quantify the **impact of coupon usage** on order value and sales volume.  
- Understand **customer funnel behavior** (view → click → redemption).  
- Evaluate **retention patterns** and **customer lifetime potential**.  
- Translate findings into **strategic business recommendations** for targeted marketing.

---

## Design
| Element | Description |
|----------|-------------|
| **Treatment Definition** | Customers who used coupons (`Coupon_Status = 'Used'`) are defined as the **treatment group**; others serve as control. |
| **Randomization Logic** | Data simulates natural A/B exposure via historical coupon offers by email and website banners. |
| **Duration** | Full year of sales data (Jan–Dec 2019). |
| **Observation Level** | Order-level transactions, clustered by `CustomerID`. |
| **Segmentation** | Customers categorized into Low / Mid / High / VIP segments based on total spending distribution. |

---

## Metrics
| **Type** | **Metric** | **Description** | **Formula** |
|-----------|-------------|-----------------|--------------|
| **Primary KPI** | **Net Revenue per Order** | Core profit driver | `net_amount` |
| **Secondary KPIs** | **AOV (Average Order Value)** | `mean(net_amount)` |
|  | **Coupon Usage Rate** | % of orders using a coupon | `n_used / n_total` |
|  | **CTR (Click-Through Rate)** | Customer engagement with coupons | `clicked / shown` |
|  | **Retention (Cohort-based)** | Average orders per customer by cohort month | Aggregated from transaction data |

---

## Methodology
| **Technique** | **Purpose** |
|----------------|-------------|
| **Welch’s T-test / Mann–Whitney U test** | Compare treatment vs control mean differences under heteroskedasticity. |
| **Cluster-Robust OLS** | Estimate the effect of coupon use on log(order value), clustering SEs by `CustomerID`. |
| **Cohort Analysis** | Track repurchase rate and engagement across customer acquisition months. |
| **Funnel Analysis** | Measure drop-off rates between “shown → clicked → used” stages. |
| **Bootstrap CI** | Non-parametric estimation for mean difference confidence intervals. |

---

## Results Summary

### **Coupon Effect (OLS, clustered by CustomerID)**
\[
\log(1 + \text{net\_amount}) = \beta_0 + \beta_1 \text{used\_coupon} + \beta_2 \text{discount\_amount} + \beta_3 \text{tax\_amount} + \text{FE(Location × Gender)} + \varepsilon
\]

| Variable | Coefficient | Significance | Interpretation |
|-----------|--------------|---------------|----------------|
| **used_coupon** | –0.196 | ***p < 0.001*** | Coupon usage slightly reduces order value (expected from discounts). |
| **discount_amount** | +0.013 | **p < 0.01** | Moderate discounts increase spending — suggesting positive elasticity. |
| **tax_amount** | +0.015 | **p < 0.01** | Proxy for higher-priced purchases. |
| **Tenure_Months** | –0.001 | n.s. | Customer experience length not a strong predictor. |

**R² = 0.195** — model explains ~20% of variation in log(order value).  
**Cluster-robust SE** confirms robustness against within-customer heterogeneity.

---

### **Funnel Insights**
| Stage | Metric | Observation |
|--------|---------|--------------|
| Shown → Clicked | **CTR ≈ 0.8–1.0** | Customers are highly responsive to coupon visibility. |
| Clicked → Used | **Use Rate ≈ 0.3–0.4** | Conversion remains low; friction likely in checkout or redemption. |
| High-Value Segments | **Use_given_Click ↑** | VIP and High segments use coupons more efficiently. |

---

### **Retention Analysis (Cohort Heatmap)**
- Cohorts show strong order concentration in the **first purchase month**, then decline sharply after **Month 3**.  
- Later cohorts (Q3–Q4) perform slightly better, possibly due to improved marketing campaigns.

---

## Validation
- **Balance Test:** No significant difference in tenure or location between A/B groups (p > 0.8).  
- **Sensitivity Checks:** Results hold across parametric (t-test) and non-parametric (bootstrap / Mann–Whitney) methods.  
- **Multicollinearity:** Variance inflation checked; interaction fixed effects (Gender × Location) mitigate bias.

---

## Business Implications & Recommendations

| **Finding** | **Business Implication** | **Actionable Strategy** |
|--------------|--------------------------|--------------------------|
| Coupons reduce order value slightly but raise conversion | Overuse of coupons erodes margin | Apply tiered discounting — smaller for repeat buyers, higher for first-time users |
| Retention drops after 3 months | Customers disengage quickly post-purchase | Launch post-purchase reactivation campaigns (email, credits) around Month 2 |
| High CTR but low redemption | Awareness > conversion gap | Simplify coupon redemption flow or bundle with loyalty points |
| Low-value customers dominate (≈89%) | Heavy dependency on infrequent buyers | Introduce **membership tiers** or **free shipping thresholds** to increase spend frequency |
| Sales driven more by volume than coupon efficiency | Growth relies on traffic, not discounting | Focus investment on targeted ad spend or referral programs instead of generic discounts |

---

## Tools Used
- **Python:** pandas, numpy, statsmodels, scipy, seaborn, matplotlib  
- **Statistical Techniques:** Welch T-test, Cluster-robust OLS, Bootstrap CI, Cohort Analysis  
- **Visualization:** Funnel chart, Correlation heatmap, Cohort retention, KPI dashboard  
- **Environment:** Jupyter Notebook (Python 3.12)

---

## Author
**Wen Zhang (Wenz212)**  
Master’s in Economics | Data Analytics Portfolio  
🔗 [GitHub](https://github.com/Wenz212) | [LinkedIn](https://www.linkedin.com/in/wenz212)

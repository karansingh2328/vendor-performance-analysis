# Vendor Performance Analysis

## Project Overview

This project analyzes vendor performance using SQL, Python, and Power BI. The goal was to identify the vendors driving revenue and profit, detect loss-making suppliers, evaluate operational efficiency, and provide business recommendations based on data-driven insights.

---

## Business Problem

The company works with multiple vendors and needs to understand:

* Which vendors generate the highest revenue?
* Which vendors generate the highest profit?
* Which vendors are causing losses?
* How concentrated is profit among vendors?
* Which vendors have the longest delivery lead times?

---

## Tools & Technologies

* SQL
* Python

  * Pandas
  * NumPy
  * Matplotlib
* Power BI

---

## Dataset Information

### Sales Dataset

* Over 12.8 million transaction records
* Contains sales quantity, revenue, product, and vendor information

### Purchases Dataset

* Over 2.3 million purchase records
* Contains purchase costs, quantities, vendor details, and invoice information

### Vendors Analyzed

* 127 unique vendors

---

## Data Cleaning

* Handled missing values in the purchases dataset
* Verified and removed duplicate records where necessary
* Standardized vendor-level analysis data
* Created calculated metrics such as Profit, Profit Margin %, and Lead Time

---

## Key Findings

* 127 vendors were analyzed.
* 114 vendors were profitable.
* 13 vendors generated losses.
* The top 20% of vendors generated approximately 88.48% of total profit.
* Diageo North America Inc was the largest contributor to revenue and profit.
* Flavor Essence Inc achieved one of the highest profit margins (~98.8%).
* Flavor Essence Inc also recorded the longest average lead time (~13 days).
* High sales revenue did not always translate into high profitability.

---

## Business Insights

### Top Revenue Vendors

* Diageo North America Inc
* Martignetti Companies
* Pernod Ricard USA

### Top Profit Drivers

* Diageo North America Inc
* Martignetti Companies
* Pernod Ricard USA
* Jim Beam Brands Company
* Bacardi USA Inc

### Vendors Requiring Attention

* Vineyard Brands LLC
* Black Cove Beverages
* Ira Goldman and Williams, LLP
* Highland Wine Merchants LLC
* Adamba Imports Intl Inc

---

## Power BI Dashboard

The Power BI dashboard provides:

* Executive KPI Summary
* Top Vendors by Revenue
* Top Vendors by Profit
* Vendor Lead Time Analysis
* Vendor Efficiency Analysis
* Worst Performing Vendors
* Interactive Filtering by Vendor and Product

Dashboard screenshots are available in the **visuals** folder.

---

## Project Structure

vendor-performance-analysis/

├── data/

├── notebook/

├── sql/

├── powerbi/

├── visuals/

├── README.md

└── .gitignore

---

## Business Recommendations

* Focus on high-profit vendors that generate the majority of company profit.
* Investigate vendors operating at a loss.
* Review purchasing and pricing strategies for underperforming suppliers.
* Improve inventory planning for vendors with long delivery lead times.
* Strengthen relationships with strategic vendors contributing the highest revenue and profit.

---

## Conclusion

This project demonstrates how SQL, Python, and Power BI can be combined to perform end-to-end business analysis. The findings highlight key profitability drivers, operational bottlenecks, and supplier performance trends that can support better vendor management and more informed business decisions.

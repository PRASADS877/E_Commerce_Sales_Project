# E_Commerce_Sales_Project
Built an end-to-end SQL project analyzing e-commerce data to identify key business problems and optimize performance metrics.

## 📌 Project Overview

This project focuses on analyzing e-commerce sales data using PostgreSQL. It covers the complete data analysis workflow including data cleaning, transformation, KPI creation, and business insights generation.

The objective is to identify key business problems, evaluate performance metrics, and provide actionable recommendations to improve revenue and profitability.

---

## 🧰 Tools & Technologies

* PostgreSQL
* SQL (Data Cleaning, Analysis, Aggregations)
* Excel (for dataset handling - optional)
* Power BI (optional for visualization)

---

## 📂 Dataset Description

The dataset contains transactional-level e-commerce data with the following key fields:

* Order & Customer: `order_id`, `customer_id`
* Product Details: `product_id`, `category`, `price`, `discount`
* Sales Metrics: `quantity`, `total_amount`, `shipping_cost`, `profit_margin`
* Customer Info: `customer_age`, `customer_gender`
* Logistics: `order_date`, `delivery_time_days`, `region`
* Status: `returned`, `payment_method`

---

## 🧹 Data Cleaning & Transformation

Performed the following steps to prepare the dataset:

* Renamed `total_amount` → `item_amount`
* Created `revenue = item_amount + shipping_cost`
* Extracted `year`, `month`, and `quarter` from order date
* Converted discount into percentage (`discount_pct`)
* Created `is_loss` flag for negative profit orders
* Removed extra spaces and standardized text fields
* Checked for duplicate records

---

## 📊 Key Performance Indicators (KPIs)

* Total Revenue
* Total Orders
* Total Profit
* Average Order Value (AOV)
* Return Rate (%)
* Average Delivery Time
* Revenue per Customer
* Average Discount %

---

## 🔍 Data Analysis & Business Questions

### Revenue Analysis

* Total revenue generated
* Top-performing product categories

### Regional Analysis

* Best-performing regions
* Revenue distribution across regions

### Delivery Performance

* Average delivery time
* Impact of delivery delay on returns

### Return Analysis

* Overall return rate
* Categories with highest returns

### Profitability Analysis

* Most profitable categories
* Loss-making orders
* Impact of discounts on profit

### Customer Analysis

* Top customers by revenue
* Sales by gender and age group

### Payment Analysis

* Most frequently used payment method

### Time-Based Trends

* Monthly revenue trends
* Seasonal patterns

---

## 📈 Key Insights

* Certain categories contribute the majority of revenue
* High return rates observed in specific product categories
* Longer delivery times are associated with higher returns
* Significant number of loss-making orders due to high discounts
* A small group of customers contributes a large share of revenue
* Regional performance varies significantly

---

## 💡 Business Recommendations

* Reduce delivery time to minimize returns
* Optimize discount strategy to improve profitability
* Focus marketing efforts on high-performing regions
* Improve quality control for high-return categories
* Target high-value customers with personalized offers

## 🎯 Conclusion

This project demonstrates the ability to transform raw data into meaningful insights using SQL. It highlights key business problems and provides data-driven recommendations to improve operational efficiency and profitability.

---

## 📌 Future Enhancements

* Build interactive dashboard using Power BI
* Perform customer segmentation (RFM analysis)
* Add cohort and retention analysis
* Use SQL window functions for advanced insights

---

## 🙌 Author

**PRASAD S**
Aspiring Data Analyst | SQL | Data Visualization

---

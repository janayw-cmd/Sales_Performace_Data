# Airline Sales Analytics Dashboard

## Project Overview
This project analyzes airline ticket sales data across regions, sales channels, and airlines. Using Excel for data cleaning, SQL for modeling and Power BI for visualization, the dashboard highlights revenue trends, cancellations, discount impacts, and add‑on contributions.

The goal: transform raw booking data into actionable business insights for decision‑makers.

# Data Cleaning Process (Excel)
The raw airline sales dataset contained intentional data issues to simulate real‑world challenges. I used Excel to clean and standardize the data before analysis.
## Issues Identified
- Mixed capitalization in text fields
- Missing discounts
- Negative ticket sales
- Zero ticket sales
- Revenue inconsistencies
- Add‑on inconsistencies
- Mixed sales channels
- Non‑standard date formatting
##Cleaning Steps
- Standardized Text Fields
- Applied consistent capitalization for Airline, Route, Class, and SalesChannel.
- Handled Discounts
- Replaced missing discount values with 0 (no discount).
- Ensured all discount values were numeric and within valid ranges.
- Fixed Ticket Sales
- Converted negative ticket counts into a separate Cancellation category.
- Replaced zero ticket sales with NULL or flagged them for review.
- Corrected Revenue
- Recalculated TotalSales using:
\mathrm{TotalSales}=\mathrm{TicketsSold}\times \mathrm{TicketPrice}\times (1-\mathrm{Discount})- Removed currency labels (USD, R) and stored values as pure numbers.
- Added a CurrencyCode column for clarity.
- Add‑on Consistency
- Standardized BaggageAddon and SeatSelectionAddon values to TRUE/FALSE.
- Sales Channel Normalization
- Unified mixed entries (e.g., “Online”, “online”, “ONL”) into consistent categories.
- Date Formatting
- Converted all BookingDate values into ISO format (YYYY-MM-DD).

# SQL Analysis
After cleaning the dataset in Excel, I imported the data into SQL Server for structured analysis. I wrote queries to answer key business questions and validate the cleaned dataset.

## Queries Implemented;

-- Total Revenue by Airline
SELECT Airline,
       SUM(TRY_CAST(TotalSales AS FLOAT)) AS TotalRevenue
FROM dbo.Airline_Sales_Cleaned
GROUP BY Airline
ORDER BY TotalRevenue DESC;


Business Question: Which airline generates the most revenue?

-- Average Ticket Price by Class
SELECT Class,
       AVG(TicketPrice) AS AvgTicketPrice
FROM dbo.Airline_Sales_Cleaned
GROUP BY Class;


Business Question: What is the average ticket price across different classes?

-- Sales by Region and Channel
SELECT Region,
       SalesChannel,
       SUM(TRY_CAST(TotalSales AS FLOAT)) AS TotalSales
FROM dbo.Airline_Sales_Cleaned
GROUP BY Region, SalesChannel
ORDER BY Region, TotalSales DESC;


Business Question: Which regions and sales channels perform best?

-- Cancellation Impact (Negative Tickets)
SELECT Airline,
       SUM(CASE WHEN TicketsSold < 0 THEN TicketsSold ELSE 0 END) AS CancelledTickets,
       SUM(CASE WHEN TicketsSold < 0 THEN CAST(TotalSales AS FLOAT) ELSE 0 END) AS LostRevenue
FROM dbo.Airline_Sales_Cleaned
GROUP BY Airline;

Business Question: How do cancellations affect ticket sales and revenue?

# Dashboard Features
- Total Sales KPI: Overall revenue across all airlines.
- Regional & Channel Performance Matrix: Compare sales by region and channel.
- Airline Revenue Bar Chart: Identify top‑performing airlines.
- Tickets Sold by Airline: Operational volume comparison.
- Revenue Breakdown by Add‑ons (Pie Chart): Contribution of baggage and seat selection.
- Discount vs. Sales Scatter Plot: Impact of discount strategies on revenue.

<img width="1242" height="698" alt="Airline Sales Performance" src="https://github.com/user-attachments/assets/8d88caf5-5547-43a6-8a13-a9f4ff91d664" />

# Business Questions Answered

## Through Excel cleaning, SQL queries, and Power BI dashboards, this project addressed key operational and strategic questions:

- Which airline generates the most revenue?
→ Identified Skyjet as the top performer in both revenue and tickets sold.
- Which regions and sales channels perform best?
→ Revealed Mobile App channels outperform agents in most regions.
- What is the average ticket price by class?
→ Compared Economy, Business, and First Class pricing.
- How do discounts impact sales performance?
→ Analyzed the relationship between discount rates and total sales.
- What’s the impact of cancellations (negative tickets)?
→ Quantified lost revenue and cancellation counts per airline.
- How much do baggage and seat add‑ons contribute to total revenue?
→ Showed ancillary revenue streams from add‑on services.
- What are the overall sales trends?
→ Tracked total sales across time with KPIs and line charts.

# Reflection: How It Could Be Better
## While the project successfully delivered insights, there are opportunities to strengthen it further:

## Schema Normalization
- Create separate lookup tables for Airlines, Routes, and Calendar dates.
- Enables cleaner joins and more scalable analysis.

## Advanced DAX Measures
- Add KPIs like Cancellation Rate, Revenue per Ticket, % of Add‑on Revenue.
- Enhance tooltips and provide deeper insights.





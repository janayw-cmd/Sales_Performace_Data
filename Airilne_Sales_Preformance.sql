-- Total Revenue by Airline

SELECT Airline,
       SUM(TRY_CAST(TotalSales AS FLOAT)) AS TotalRevenue
FROM dbo.Airline_Sales_Cleaned
GROUP BY Airline
ORDER BY TotalRevenue DESC;

-- Average Ticket Price by Class

SELECT Class,
       AVG(TicketPrice) AS AvgTicketPrice
FROM dbo.Airline_Sales_Cleaned
GROUP BY Class;

-- Sales by Region and Channel

SELECT Region,
       SalesChannel,
       SUM(TRY_CAST(TotalSales AS FLOAT)) AS TotalSales
FROM dbo.Airline_Sales_Cleaned
GROUP BY Region, SalesChannel
ORDER BY Region, TotalSales DESC;

-- Cancellation Impact (Negative Tickets)

SELECT Airline,
       SUM(CASE WHEN TicketsSold < 0 THEN TicketsSold ELSE 0 END) AS CancelledTickets,
       SUM(CASE WHEN TicketsSold < 0 THEN CAST(TotalSales AS FLOAT) ELSE 0 END) AS LostRevenue
FROM dbo.Airline_Sales_Cleaned
GROUP BY Airline;

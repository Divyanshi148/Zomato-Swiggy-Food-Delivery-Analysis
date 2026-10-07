CREATE DATABASE FoodDeliveryAnalyticsDB;
GO

USE FoodDeliveryAnalyticsDB;
GO

CREATE TABLE Customers
(
    CustomerID INT PRIMARY KEY,
    CustomerName VARCHAR(100),
    City VARCHAR(50),
    Area VARCHAR(100),
    State VARCHAR(50),
    SignupDate DATE,
    CustomerSegment VARCHAR(30)
);

CREATE TABLE Restaurants
(
    RestaurantID INT PRIMARY KEY,
    RestaurantName VARCHAR(150),
    City VARCHAR(50),
    Area VARCHAR(100),
    Cuisine VARCHAR(50),
    Rating DECIMAL(3,1),
    AverageCostForTwo INT,
    AvgDeliveryTimeMin INT,
    IsActive VARCHAR(10)
);

CREATE TABLE MenuItems
(
    MenuItemID INT PRIMARY KEY,
    RestaurantID INT,
    ItemName VARCHAR(150),
    Category VARCHAR(50),
    Price DECIMAL(10,2),
    IsVeg VARCHAR(10),
    IsAvailable VARCHAR(10),

    FOREIGN KEY (RestaurantID)
    REFERENCES Restaurants(RestaurantID)
);

CREATE TABLE DeliveryPartners
(
    DeliveryPartnerID INT PRIMARY KEY,
    PartnerName VARCHAR(100),
    City VARCHAR(50),
    JoinDate DATE,
    Rating DECIMAL(3,1),
    PartnerStatus VARCHAR(20)
);

CREATE TABLE Orders
(
    OrderID BIGINT PRIMARY KEY,
    CustomerID INT,
    RestaurantID INT,
    OrderDateTime DATETIME2,
    OrderStatus VARCHAR(30),
    PaymentMethod VARCHAR(30),

    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID),

    FOREIGN KEY (RestaurantID)
    REFERENCES Restaurants(RestaurantID)
);

CREATE TABLE OrderItems
(
    OrderItemID BIGINT PRIMARY KEY,
    OrderID BIGINT,
    MenuItemID INT,
    Quantity INT,

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),

    FOREIGN KEY (MenuItemID)
    REFERENCES MenuItems(MenuItemID)
);

CREATE TABLE Payments
(
    PaymentID VARCHAR(40) PRIMARY KEY,
    OrderID BIGINT,
    ItemSubtotal DECIMAL(14,2),
    DiscountAmount DECIMAL(14,2),
    DeliveryFee DECIMAL(14,2),
    TaxAmount DECIMAL(14,2),
    FinalAmount DECIMAL(14,2),
    PaymentStatus VARCHAR(20),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID)
);

CREATE TABLE Deliveries
(
    DeliveryID VARCHAR(40) PRIMARY KEY,
    OrderID BIGINT,
    DeliveryPartnerID INT,
    DistanceKM DECIMAL(8,2),
    PickupTime DATETIME2,
    DeliveryTime DATETIME2 NULL,
    DeliveryStatus VARCHAR(30),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),

    FOREIGN KEY (DeliveryPartnerID)
    REFERENCES DeliveryPartners(DeliveryPartnerID)
);

CREATE TABLE Reviews
(
    ReviewID BIGINT PRIMARY KEY,
    OrderID BIGINT,
    CustomerID INT,
    RestaurantID INT,
    Rating INT,
    ReviewDate DATE,
    ReviewText VARCHAR(250),

    FOREIGN KEY (OrderID)
    REFERENCES Orders(OrderID),

    FOREIGN KEY (CustomerID)
    REFERENCES Customers(CustomerID),

    FOREIGN KEY (RestaurantID)
    REFERENCES Restaurants(RestaurantID)
);

CREATE TABLE RestaurantOffers
(
    OfferID INT PRIMARY KEY,
    RestaurantID INT,
    OfferName VARCHAR(100),
    MinimumOrderValue INT,
    StartDate DATE,
    EndDate DATE,
    OfferStatus VARCHAR(20),

    FOREIGN KEY (RestaurantID)
    REFERENCES Restaurants(RestaurantID)
);
BULK INSERT Customers
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset (2)\customers.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT Restaurants
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\restaurants.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT MenuItems
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\menu_items.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT DeliveryPartners
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\delivery_partners.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT Orders
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\orders.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT OrderItems
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\order_items.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT Payments
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\payments.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT Deliveries
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\deliveries.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT Reviews
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\reviews.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);
BULK INSERT RestaurantOffers
FROM "C:\Users\LENOVO\Downloads\zomato_swiggy_food_delivery_sql_dataset\restaurant_offers.csv"
WITH
(
    FIRSTROW = 2,
    FORMAT = 'CSV',
    FIELDQUOTE = '"',
    ROWTERMINATOR = '0x0a',
    TABLOCK
);

SELECT COUNT(*) AS TotalCustomers
FROM Customers;

SELECT COUNT(*) AS TotalRestaurants
FROM Restaurants;

SELECT COUNT(*) AS TotalMenuItems
FROM MenuItems;

SELECT COUNT(*) AS TotalOrders
FROM Orders;

SELECT COUNT(*) AS TotalOrderItems
FROM OrderItems;

SELECT COUNT(*) AS TotalPayments
FROM Payments;

SELECT COUNT(*) AS TotalDeliveries
FROM Deliveries;

SELECT COUNT(*) AS TotalReviews
FROM Reviews;

SELECT
    OrderStatus,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY OrderStatus
ORDER BY TotalOrders DESC;

SELECT
    City,
    COUNT(*) AS RestaurantCount
FROM Restaurants
GROUP BY City
ORDER BY RestaurantCount DESC;

SELECT
    AVG(Rating) AS AverageRating
FROM Restaurants;

SELECT
    RestaurantName,
    City,
    Cuisine,
    Rating
FROM Restaurants
WHERE Rating >= 4.5
ORDER BY Rating DESC;

SELECT
    c.CustomerName,
    o.OrderID,
    o.OrderDateTime,
    o.OrderStatus
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID;

SELECT
    c.CustomerName,
    r.RestaurantName,
    o.OrderID,
    o.OrderDateTime,
    o.OrderStatus
FROM Orders AS o
INNER JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
INNER JOIN Restaurants AS r
    ON o.RestaurantID = r.RestaurantID;

SELECT
    c.CustomerName,
    r.RestaurantName,
    m.ItemName,
    oi.Quantity,
    m.Price
FROM Orders AS o
INNER JOIN Customers AS c
    ON o.CustomerID = c.CustomerID
INNER JOIN Restaurants AS r
    ON o.RestaurantID = r.RestaurantID
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID
INNER JOIN MenuItems AS m
    ON oi.MenuItemID = m.MenuItemID;

SELECT
    SUM(oi.Quantity * m.Price) AS TotalRevenue
FROM OrderItems AS oi
INNER JOIN MenuItems AS m
    ON oi.MenuItemID = m.MenuItemID;

SELECT
    r.RestaurantName,
    SUM(oi.Quantity * m.Price) AS TotalRevenue
FROM Restaurants AS r
INNER JOIN MenuItems AS m
    ON r.RestaurantID = m.RestaurantID
INNER JOIN OrderItems AS oi
    ON m.MenuItemID = oi.MenuItemID
GROUP BY r.RestaurantName
ORDER BY TotalRevenue DESC;

SELECT
    r.Cuisine,
    SUM(oi.Quantity * m.Price) AS TotalRevenue
FROM Restaurants AS r
INNER JOIN MenuItems AS m
    ON r.RestaurantID = m.RestaurantID
INNER JOIN OrderItems AS oi
    ON m.MenuItemID = oi.MenuItemID
GROUP BY r.Cuisine
ORDER BY TotalRevenue DESC;

SELECT
    c.CustomerID,
    c.CustomerName,
    SUM(oi.Quantity * m.Price) AS TotalSpent
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID
INNER JOIN MenuItems AS m
    ON oi.MenuItemID = m.MenuItemID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY TotalSpent DESC;

SELECT TOP 10
    c.CustomerID,
    c.CustomerName,
    SUM(oi.Quantity * m.Price) AS TotalSpent
FROM Customers AS c
INNER JOIN Orders AS o
    ON c.CustomerID = o.CustomerID
INNER JOIN OrderItems AS oi
    ON o.OrderID = oi.OrderID
INNER JOIN MenuItems AS m
    ON oi.MenuItemID = m.MenuItemID
GROUP BY
    c.CustomerID,
    c.CustomerName
ORDER BY TotalSpent DESC;

SELECT
    CustomerID,
    CustomerName,
    TotalSpent
FROM
(
    SELECT
        c.CustomerID,
        c.CustomerName,
        SUM(oi.Quantity * m.Price) AS TotalSpent
    FROM Customers AS c
    INNER JOIN Orders AS o
        ON c.CustomerID = o.CustomerID
    INNER JOIN OrderItems AS oi
        ON o.OrderID = oi.OrderID
    INNER JOIN MenuItems AS m
        ON oi.MenuItemID = m.MenuItemID
    GROUP BY
        c.CustomerID,
        c.CustomerName
) AS CustomerSales
WHERE TotalSpent >
(
    SELECT AVG(TotalSpent)
    FROM
    (
        SELECT
            SUM(oi.Quantity * m.Price) AS TotalSpent
        FROM Orders AS o
        INNER JOIN OrderItems AS oi
            ON o.OrderID = oi.OrderID
        INNER JOIN MenuItems AS m
            ON oi.MenuItemID = m.MenuItemID
        GROUP BY o.CustomerID
    ) AS AverageSales
);

WITH RestaurantRevenue AS
(
    SELECT
        r.RestaurantID,
        r.RestaurantName,
        SUM(oi.Quantity * m.Price) AS TotalRevenue
    FROM Restaurants AS r
    INNER JOIN MenuItems AS m
        ON r.RestaurantID = m.RestaurantID
    INNER JOIN OrderItems AS oi
        ON m.MenuItemID = oi.MenuItemID
    GROUP BY
        r.RestaurantID,
        r.RestaurantName
)
SELECT TOP 10
    RestaurantID,
    RestaurantName,
    TotalRevenue
FROM RestaurantRevenue
ORDER BY TotalRevenue DESC;


WITH RestaurantRevenue AS
(
    SELECT
        r.RestaurantID,
        r.RestaurantName,
        SUM(oi.Quantity * m.Price) AS TotalRevenue
    FROM Restaurants AS r
    INNER JOIN MenuItems AS m
        ON r.RestaurantID = m.RestaurantID
    INNER JOIN OrderItems AS oi
        ON m.MenuItemID = oi.MenuItemID
    GROUP BY
        r.RestaurantID,
        r.RestaurantName
)
SELECT
    RestaurantID,
    RestaurantName,
    TotalRevenue,
    RANK() OVER
    (
        ORDER BY TotalRevenue DESC
    ) AS RevenueRank
FROM RestaurantRevenue
ORDER BY RevenueRank;

WITH RestaurantRevenue AS
(
    SELECT
        r.RestaurantID,
        r.RestaurantName,
        r.City,
        SUM(oi.Quantity * m.Price) AS TotalRevenue
    FROM Restaurants AS r
    INNER JOIN MenuItems AS m
        ON r.RestaurantID = m.RestaurantID
    INNER JOIN OrderItems AS oi
        ON m.MenuItemID = oi.MenuItemID
    GROUP BY
        r.RestaurantID,
        r.RestaurantName,
        r.City
),
RankedRestaurants AS
(
    SELECT
        *,
        ROW_NUMBER() OVER
        (
            PARTITION BY City
            ORDER BY TotalRevenue DESC
        ) AS CityRank
    FROM RestaurantRevenue
)
SELECT
    RestaurantID,
    RestaurantName,
    City,
    TotalRevenue,
    CityRank
FROM RankedRestaurants
WHERE CityRank <= 3
ORDER BY City, CityRank;

SELECT
    COUNT(CASE
        WHEN OrderStatus = 'Cancelled' THEN 1
    END) * 100.0 / COUNT(*) AS CancellationRate
FROM Orders;

SELECT
    r.RestaurantName,

    COUNT(*) AS TotalOrders,

    COUNT(CASE
        WHEN o.OrderStatus = 'Cancelled' THEN 1
    END) AS CancelledOrders,

    COUNT(CASE
        WHEN o.OrderStatus = 'Cancelled' THEN 1
    END) * 100.0 / COUNT(*) AS CancellationRate

FROM Restaurants AS r
INNER JOIN Orders AS o
    ON r.RestaurantID = o.RestaurantID

GROUP BY r.RestaurantName
ORDER BY CancellationRate DESC;

SELECT
    AVG(
        DATEDIFF(
            MINUTE,
            PickupTime,
            DeliveryTime
        )
    ) AS AverageDeliveryTimeMinutes
FROM Deliveries
WHERE DeliveryTime IS NOT NULL;

SELECT
    dp.PartnerName,
    dp.City,
    COUNT(d.DeliveryID) AS TotalDeliveries,

    AVG(
        DATEDIFF(
            MINUTE,
            d.PickupTime,
            d.DeliveryTime
        )
    ) AS AvgDeliveryTime

FROM DeliveryPartners AS dp

INNER JOIN Deliveries AS d
    ON dp.DeliveryPartnerID = d.DeliveryPartnerID

WHERE d.DeliveryTime IS NOT NULL

GROUP BY
    dp.PartnerName,
    dp.City

ORDER BY AvgDeliveryTime;

SELECT
    c.CustomerID,
    c.CustomerName,
    COUNT(o.OrderID) AS TotalOrders,
    CASE
        WHEN COUNT(o.OrderID) >= 20 THEN 'High Frequency'
        WHEN COUNT(o.OrderID) >= 10 THEN 'Medium Frequency'
        ELSE 'Low Frequency'
    END AS CustomerType
FROM Customers c
LEFT JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName;

SELECT
    DATEPART(HOUR, OrderDateTime) AS OrderHour,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY DATEPART(HOUR, OrderDateTime)
ORDER BY OrderHour;

SELECT
    DATENAME(WEEKDAY, OrderDateTime) AS DayName,
    COUNT(*) AS TotalOrders
FROM Orders
GROUP BY DATENAME(WEEKDAY, OrderDateTime)
ORDER BY TotalOrders DESC;

SELECT
    YEAR(o.OrderDateTime) AS OrderYear,
    MONTH(o.OrderDateTime) AS OrderMonth,
    SUM(p.FinalAmount) AS Revenue
FROM Orders o
JOIN Payments p
    ON o.OrderID = p.OrderID
WHERE p.PaymentStatus = 'Paid'
GROUP BY
    YEAR(o.OrderDateTime),
    MONTH(o.OrderDateTime)
ORDER BY
    OrderYear,
    OrderMonth;

SELECT
    RestaurantName,
    ISNULL(Rating, 0) AS Rating
FROM Restaurants;


SELECT
    CustomerName,
    UPPER(CustomerName) AS UpperName,
    LOWER(CustomerName) AS LowerName,
    LEN(CustomerName) AS NameLength
FROM Customers;

CREATE VIEW vw_RestaurantRevenue
AS
SELECT
    r.RestaurantID,
    r.RestaurantName,
    SUM(oi.Quantity * m.Price) AS TotalRevenue
FROM Restaurants r
JOIN MenuItems m
    ON r.RestaurantID = m.RestaurantID
JOIN OrderItems oi
    ON m.MenuItemID = oi.MenuItemID
GROUP BY
    r.RestaurantID,
    r.RestaurantName;
SELECT *
FROM vw_RestaurantRevenue
ORDER BY TotalRevenue DESC;

CREATE PROCEDURE GetRestaurantRevenue
    @RestaurantID INT
AS
BEGIN

    SELECT
        r.RestaurantName,
        SUM(oi.Quantity * m.Price) AS TotalRevenue
    FROM Restaurants r
    JOIN MenuItems m
        ON r.RestaurantID = m.RestaurantID
    JOIN OrderItems oi
        ON m.MenuItemID = oi.MenuItemID
    WHERE r.RestaurantID = @RestaurantID
    GROUP BY r.RestaurantName;

END;
EXEC GetRestaurantRevenue @RestaurantID = 101;

SELECT City
FROM Customers

UNION

SELECT City
FROM Restaurants;

SELECT *
FROM
(
    SELECT
        City,
        OrderStatus,
        OrderID
    FROM Orders o
    JOIN Customers c
        ON o.CustomerID = c.CustomerID
) AS SourceTable
PIVOT
(
    COUNT(OrderID)
    FOR OrderStatus IN
    (
        [Delivered],
        [Cancelled],
        [Pending]
    )
) AS PivotTable;

WITH RestaurantRevenue AS
(
    SELECT
        r.RestaurantID,
        r.RestaurantName,
        SUM(oi.Quantity * m.Price) AS Revenue
    FROM Restaurants r
    JOIN MenuItems m
        ON r.RestaurantID = m.RestaurantID
    JOIN OrderItems oi
        ON m.MenuItemID = oi.MenuItemID
    GROUP BY
        r.RestaurantID,
        r.RestaurantName
)
SELECT
    RestaurantName,
    Revenue,
    Revenue * 100.0 /
        SUM(Revenue) OVER() AS RevenuePercentage
FROM RestaurantRevenue
ORDER BY Revenue DESC;

WITH MonthlyRevenue AS
(
    SELECT
        YEAR(o.OrderDateTime) AS OrderYear,
        MONTH(o.OrderDateTime) AS OrderMonth,
        SUM(p.FinalAmount) AS Revenue
    FROM Orders o
    JOIN Payments p
        ON o.OrderID = p.OrderID
    WHERE p.PaymentStatus = 'Paid'
    GROUP BY
        YEAR(o.OrderDateTime),
        MONTH(o.OrderDateTime)
)
SELECT
    OrderYear,
    OrderMonth,
    Revenue,
    SUM(Revenue) OVER
    (
        ORDER BY OrderYear, OrderMonth
    ) AS RunningRevenue
FROM MonthlyRevenue;

WITH MonthlyRevenue AS
(
    SELECT
        YEAR(o.OrderDateTime) AS OrderYear,
        MONTH(o.OrderDateTime) AS OrderMonth,
        SUM(p.FinalAmount) AS Revenue
    FROM Orders o
    JOIN Payments p
        ON o.OrderID = p.OrderID
    WHERE p.PaymentStatus = 'Paid'
    GROUP BY
        YEAR(o.OrderDateTime),
        MONTH(o.OrderDateTime)
)
SELECT
    OrderYear,
    OrderMonth,
    Revenue,

    LAG(Revenue) OVER
    (
        ORDER BY OrderYear, OrderMonth
    ) AS PreviousMonthRevenue

FROM MonthlyRevenue;

SELECT
    c.CustomerID,
    c.CustomerName,
    MAX(o.OrderDateTime) AS LastOrderDate
FROM Customers c
JOIN Orders o
    ON c.CustomerID = o.CustomerID
GROUP BY
    c.CustomerID,
    c.CustomerName
HAVING
    MAX(o.OrderDateTime) < DATEADD(DAY, -90, GETDATE());

-- Duplicate customers
SELECT
    CustomerID,
    COUNT(*) AS DuplicateCount
FROM Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;
SELECT *
FROM MenuItems
WHERE Price <= 0;
SELECT *
FROM Restaurants
WHERE Rating < 0
   OR Rating > 5;
SELECT o.*
FROM Orders o
LEFT JOIN Customers c
    ON o.CustomerID = c.CustomerID
WHERE c.CustomerID IS NULL;

SELECT

    COUNT(DISTINCT o.OrderID) AS TotalOrders,

    COUNT(DISTINCT o.CustomerID) AS ActiveCustomers,

    COUNT(DISTINCT o.RestaurantID) AS ActiveRestaurants,

    SUM(
        CASE
            WHEN p.PaymentStatus = 'Paid'
            THEN p.FinalAmount
            ELSE 0
        END
    ) AS TotalRevenue,

    SUM(
        CASE
            WHEN p.PaymentStatus = 'Paid'
            THEN p.FinalAmount
            ELSE 0
        END
    ) * 1.0 /
    NULLIF(
        COUNT(
            CASE
                WHEN p.PaymentStatus = 'Paid'
                THEN o.OrderID
            END
        ), 0
    ) AS AverageOrderValue,

    COUNT(
        CASE
            WHEN o.OrderStatus = 'Delivered'
            THEN 1
        END
    ) AS DeliveredOrders,

    COUNT(
        CASE
            WHEN o.OrderStatus = 'Cancelled'
            THEN 1
        END
    ) AS CancelledOrders,

    COUNT(
        CASE
            WHEN o.OrderStatus = 'Cancelled'
            THEN 1
        END
    ) * 100.0 / COUNT(*) AS CancellationRate,

    AVG(
        CASE
            WHEN d.DeliveryTime IS NOT NULL
            THEN DATEDIFF(
                MINUTE,
                d.PickupTime,
                d.DeliveryTime
            )
        END
    ) AS AverageDeliveryTime

FROM Orders o

LEFT JOIN Payments p
    ON o.OrderID = p.OrderID

LEFT JOIN Deliveries d
    ON o.OrderID = d.OrderID;
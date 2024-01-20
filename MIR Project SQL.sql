DESKTOP-U2KOCE9

******CUSTOMER DEMOGRAPHY

SELECT 
A.OnlineOrderFlag, A.[OrderDate], A.[SalesOrderID],
B.*

FROM [Sales].[SalesOrderHeader] AS A
LEFT JOIN [AdventureWorksDW2012].[dbo].[DimCustomer] AS B ON A.CustomerID = B.[CustomerKey]

where A.OnlineOrderFlag = 1 

********************************

Select
Distinct B.[CustomerID],
C.[BusinessEntityID],
A.[DateFirstPurchase], A.[BirthDate], A.[MaritalStatus], A.[YearlyIncome], A.[Gender], A.[TotalChildren], A.[Education],
A.[Occupation], A.[HomeOwnerFlag], A.[NumberCarsOwned],
D.[SalesOrderID], 

CASE
	WHEN A.[YearlyIncome]= '0-25000' THEN 'Low_Income'
	WHEN A.[YearlyIncome] ='25001-50000' THEN 'Mid_Income'
	WHEN A.[YearlyIncome] ='50000-75000' THEN 'Mid_Income'
	WHEN A.[YearlyIncome] ='75001-100000' THEN 'High_Income' 
	ELSE 'High_Income'
	END AS 'Income_Band'

FROM
[Sales].[Customer] AS B
LEFT JOIN [Person].[Person] AS C ON B.[PersonID] = C.[BusinessEntityID]
LEFT JOIN [Sales].[vPersonDemographics] AS A ON C.[BusinessEntityID] = A.[BusinessEntityID]
LEFT JOIN [Sales].[SalesOrderHeader] AS D ON D.[CustomerID] = B.[CustomerID]

WHERE
CONVERT(DATE, [BirthDate]) IS NOT NULL


.....POWERBI LIST PRICE IS WITHOUT DISCOUNT, UNIT PRICE IS WITH DISCOUNT

SELECT
A.[SalesOrderID], A.[OrderQty], A.[LineTotal] AS Revenue, A.[ProductID], A.[UnitPrice], A.[UnitPriceDiscount], A.[UnitPrice]-(A.[UnitPrice]*A.[UnitPriceDiscount]) AS UnitPriceafterDisc,
B.[OnlineOrderFlag], CONVERT(DATE, B.[OrderDate]) AS OrderDate,
C.[StandardCost], C.[ListPrice], C.[DaysToManufacture], C.[Name] AS NameofProduct,
D.[Name] AS Region, 
E.[Name] AS SubcategoryName, 
F.[Name] AS Categoryname,
A.[LineTotal]-(C.[StandardCost]*A.[OrderQty]) AS Profit,
C.[StandardCost]*A.[OrderQty] as Totalcost,

CASE
	WHEN B.[OnlineOrderFlag]= '0' THEN 'Reseller'
	else 'Online'
	End as 'Channel'

FROM
[Sales].[SalesOrderDetail] AS A
LEFT JOIN [Sales].[SalesOrderHeader] AS B ON A.[SalesOrderID] = B.[SalesOrderID]
LEFT JOIN [Production].[Product] AS C ON A.[ProductID] = C.[ProductID]
LEFT JOIN [Sales].[SalesTerritory] AS D ON B.[TerritoryID] = D.[TerritoryID]
LEFT JOIN [Production].[ProductSubcategory] AS E ON C.[ProductSubcategoryID] = E.[ProductSubcategoryID]
LEFT JOIN [Production].[ProductCategory] AS F ON E.[ProductCategoryID] =  F.[ProductCategoryID]




select*

from
[Production].[ProductCategory]



copied********

SELECT
A.[SalesOrderID], A.[OrderQty], A.[LineTotal] AS Revenue, A.[ProductID], A.[UnitPrice], A.[UnitPriceDiscount], A.[UnitPrice]-(A.[UnitPrice]*A.[UnitPriceDiscount]) AS UnitPriceafterDisc,
B.[OnlineOrderFlag], CONVERT(DATE, B.[OrderDate]) AS OrderDate,
C.[StandardCost], C.[ListPrice], C.[DaysToManufacture], C.[Name] AS NameofProduct,
D.[Name] AS Region, 
E.[Name] AS SubcategoryName, 
A.[LineTotal]-(C.[StandardCost]*A.[OrderQty]) AS Profit


FROM
[Sales].[SalesOrderDetail] AS A
LEFT JOIN [Sales].[SalesOrderHeader] AS B ON A.[SalesOrderID] = B.[SalesOrderID]
LEFT JOIN [Production].[Product] AS C ON A.[ProductID] = C.[ProductID]
LEFT JOIN [Sales].[SalesTerritory] AS D ON B.[TerritoryID] = D.[TerritoryID]
LEFT JOIN [Production].[ProductSubcategory] AS E ON C.[ProductSubcategoryID] = E.[ProductSubcategoryID]
LEFT JOIN [Production].[ProductCategory] AS F ON E.[ProductCategoryID] =  F.[ProductCategoryID]


where B.OnlineOrderFlag = 1 

FORECAST ONE ##################################

SELECT
CONVERT(DATE, B.[OrderDate]) AS OrderDate,
A.[LineTotal] AS Revenue,
B.[OnlineOrderFlag], 
D.[Name] AS Region


FROM
[Sales].[SalesOrderDetail] AS A
LEFT JOIN [Sales].[SalesOrderHeader] AS B ON A.[SalesOrderID] = B.[SalesOrderID]
LEFT JOIN [Sales].[SalesTerritory] AS D ON B.[TerritoryID] = D.[TerritoryID]

FORECAST TWO########################################
SELECT
CONVERT(DATE, B.[OrderDate]) AS OrderDate,
A.[LineTotal] AS Revenue,
B.[OnlineOrderFlag], 
D.[Name] AS Region


FROM
[Sales].[SalesOrderDetail] AS A
LEFT JOIN [Sales].[SalesOrderHeader] AS B ON A.[SalesOrderID] = B.[SalesOrderID]
LEFT JOIN [Sales].[SalesTerritory] AS D ON B.[TerritoryID] = D.[TerritoryID]


################################################################
SALES REASON________for advert improve sales

SELECT
G.[SalesOrderID], G.[SalesReasonID],
A.[OrderQty], A.[LineTotal] AS Revenue, A.[ProductID],[UnitPrice],
H.[Name] AS Reason

FROM
[Sales].[SalesOrderHeaderSalesReason] AS G
LEFT JOIN [Sales].[SalesOrderDetail] AS A ON G.[SalesOrderID] = A.[SalesOrderID]
LEFT JOIN [Sales].[SalesReason] AS H ON G.[SalesReasonID] = H.[SalesReasonID]



*******************************************************

PRODUCT SCRAP & manufacturing***************

SELECT
A.[ProductID], A.[Name] AS NameofProduct, A.[StandardCost], A.[DaysToManufacture],
 B.[OrderQty] AS QTY_to_Produce, B.[StockedQty] AS Actual_QTY_Produced, B.[ScrappedQty], B.[StartDate] as Production_StartDate ,  B.[DueDate] as Production_DueDate, B.[EndDate] as Production_EndDate,
C.[Name] AS ScrapReason

FROM
[Production].[Product] AS A 
LEFT JOIN [Production].[WorkOrder] AS B ON A.[ProductID] =B.[ProductID]
LEFT JOIN [Production].[ScrapReason] AS C ON B.[ScrapReasonID] = C.[ScrapReasonID]

WHERE 
B.[ScrapReasonID] IS NOT NULL

************************
PURCHASE-SHIPPING-VENDOR------SUPPLY

SELECT
F.[PurchaseOrderID],F.[OrderQty], F.[DueDate], F.[UnitPrice], F.[LineTotal], F.[ReceivedQty], F.[RejectedQty], F.[StockedQty],
G.[OrderDate], G.[ShipDate], G.[TotalDue] as TotalCostOfShipping,
C.[StandardCost], C.[ListPrice], C.[DaysToManufacture], C.[Name] AS NameofProduct,
I.[Name] AS ShipName, I.[ShipRate],
J.[Name] AS VendorName 

FROM
[Purchasing].[PurchaseOrderDetail] AS F
LEFT JOIN [Purchasing].[PurchaseOrderHeader] AS G ON F.[PurchaseOrderID] = G.[PurchaseOrderID]
LEFT JOIN [Production].[Product] AS C ON F.[ProductID] = C.[ProductID] 
LEFT JOIN [Purchasing].[ShipMethod] AS I ON G.[ShipMethodID] = I.[ShipMethodID]
LEFT JOIN [Purchasing].[Vendor] AS J ON G.[VendorID] = J.[BusinessEntityID]

*******************************



ENCOMPASSING   ##########################################################
SELECT 
A.[SalesOrderDetailID]
,A.[SalesOrderID]
,A.[OrderQty]
,A.[UnitPrice]
,A.[OrderQty]*A.[UnitPrice] AS Revenue
,A.[UnitPriceDiscount]
,B.[OrderDate]
,CASE WHEN B.[OnlineOrderFlag] = 1 THEN 'Online' ELSE 'Reseller' END AS Sales_Channel
,B.[OnlineOrderFlag]
,B.[CustomerID]
,C.[Name] AS ProductName
,C.StandardCost
,C.[ListPrice]
,C.[DaysToManufacture]
,A.[OrderQty]*C.StandardCost AS Total_Cost
,(A.[OrderQty]*A.[UnitPrice]) - (A.[OrderQty]*C.StandardCost) AS Profit
,C.[ListPrice] - A.[UnitPrice] AS Price_belowLS /**THIS HELPS US IDENTIFY PRODUCTS SOLD BELOW LISTPRICE*/
,D.[Name] AS ProductSubcatname
,E.[Name] AS Productcatname
,F.*
FROM [Sales].[SalesOrderDetail] AS A
LEFT JOIN [Sales].[SalesOrderHeader] AS B
ON A.SalesOrderID = B.SalesOrderID
LEFT JOIN [Production].[Product] AS C
ON A.[ProductID] = C.ProductID
LEFT JOIN [Production].[ProductSubcategory] AS D
ON C.[ProductSubcategoryID] = D.[ProductSubcategoryID]
LEFT JOIN [Production].[ProductCategory] AS E
ON D.[ProductCategoryID] = E.[ProductCategoryID]
LEFT JOIN (SELECT 
A.[SalesOrderID]
,max(CASE WHEN B.[Name] = 'Price' THEN 1 ELSE 0 END) AS SalesReason_Price
,max(CASE WHEN B.[Name] = 'Quality' THEN 1 ELSE 0 END) AS SalesReason_Quality
,max(CASE WHEN B.[Name] = 'Review' THEN 1 ELSE 0 END) AS SalesReason_Review
,max(CASE WHEN B.[Name] = 'Other' THEN 1 ELSE 0 END) AS SalesReason_Other
,max(CASE WHEN B.[Name] = 'Television  Advertisement' THEN 1 ELSE 0 END) AS SalesReason_TV
,max(CASE WHEN B.[Name] = 'Manufacturer' THEN 1 ELSE 0 END) AS SalesReason_Manufacturer
,max(CASE WHEN B.[Name] = 'On Promotion' THEN 1 ELSE 0 END) AS SalesReason_Promotion
FROM [Sales].[SalesOrderHeaderSalesReason] AS A
LEFT JOIN [Sales].[SalesReason] AS B
ON A.SalesReasonID = B.SalesReasonID
group by A.[SalesOrderID]) F
ON A.SalesOrderID = F.SalesOrderID;

EDITED MBA#######################

SELECT 
A.[SalesOrderID]
,A.[OrderQty]
,B.[OrderDate]
,B.[OnlineOrderFlag]
,CASE WHEN B.[OnlineOrderFlag] = 1 THEN 'Online' ELSE 'Reseller' END AS Sales_Channel
,D.[Name] AS ProductSubcatname
,E.[Name] AS Region 

FROM [Sales].[SalesOrderDetail] AS A
LEFT JOIN [Sales].[SalesOrderHeader] AS B
ON A.SalesOrderID = B.SalesOrderID
LEFT JOIN [Production].[Product] AS C
ON A.[ProductID] = C.ProductID
LEFT JOIN [Production].[ProductSubcategory] AS D
ON C.[ProductSubcategoryID] = D.[ProductSubcategoryID]
LEFT JOIN [Sales].[SalesTerritory] AS E ON B.[TerritoryID] = E.[TerritoryID]

where B.OnlineOrderFlag = 1


TIMESERIES################################

SELECT 
A.[OrderQty]*A.[UnitPrice] AS Revenue
,B.[OrderDate]
,CASE WHEN B.[OnlineOrderFlag] = 1 THEN 'Online' ELSE 'Reseller' END AS Sales_Channel
,E.[Name] AS Region 

FROM [Sales].[SalesOrderDetail] AS A
LEFT JOIN [Sales].[SalesOrderHeader] AS B
ON A.SalesOrderID = B.SalesOrderID
LEFT JOIN [Sales].[SalesTerritory] AS E ON B.[TerritoryID] = E.[TerritoryID]


SELECT 
A.[OrderQty]*A.[UnitPrice] AS Revenue
,B.[OrderDate]
,CASE WHEN B.[OnlineOrderFlag] = 1 THEN 'Online' ELSE 'Reseller' END AS Sales_Channel
,E.[Name] AS Region 

FROM [Sales].[SalesOrderDetail] AS A
LEFT JOIN [Sales].[SalesOrderHeader] AS B
ON A.SalesOrderID = B.SalesOrderID
LEFT JOIN [Sales].[SalesTerritory] AS E ON B.[TerritoryID] = E.[TerritoryID]
WHERE E.[Name] = 'Germany'
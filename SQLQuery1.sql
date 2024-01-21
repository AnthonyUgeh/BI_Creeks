FOR TABLEAU AND RECOMMENDATION ENGINE
SELECT
A.[ProductKey], A.[CustomerKey], A.[OrderDate], A.[OrderQuantity], A.[SalesAmount] AS Revenue, A.[TotalProductCost],  (A.[SalesAmount]-A.[TotalProductCost]) AS Profit,
B.[MaritalStatus], B.[YearlyIncome], B.[BirthDate], B.[Gender], B.[DateFirstPurchase], B.[EnglishEducation] AS CustEducation, B.[EnglishOccupation] as CustOccupation,
D.[EnglishProductSubcategoryName] AS ProdSubCategory,
E.[EnglishProductCategoryName] as ProdCategory,
F.[SalesTerritoryRegion] AS Region

FROM
[dbo].[FactInternetSales] AS A
LEFT JOIN [dbo].[DimCustomer] AS B ON A.[CustomerKey] = B.[CustomerKey]
LEFT JOIN [dbo].[DimProduct] AS C ON A.[ProductKey] = C.[ProductKey]
LEFT JOIN [dbo].[DimProductSubcategory] AS D ON C.[ProductSubcategoryKey] = D.[ProductSubcategoryKey]
LEFT JOIN [dbo].[DimProductCategory] AS E ON D.[ProductCategoryKey] = E.[ProductCategoryKey]
LEFT JOIN [dbo].[DimSalesTerritory] AS F ON A.[SalesTerritoryKey] = F.[SalesTerritoryKey]

WHERE
A.[OrderDate] > '2010-12-31'


SELECT
A.[ProductKey], A.[CustomerKey], A.[OrderDate], A.[OrderQuantity], A.[UnitPrice], A.[TotalProductCost],
B.[MaritalStatus], B.[YearlyIncome], B.[BirthDate], B.[Gender], B.[DateFirstPurchase], B.[EnglishEducation], B.[EnglishOccupation],
D.[EnglishProductSubcategoryName] AS ProdSubCategory,
E.[EnglishProductCategoryName] as ProdCategory,


CASE
	WHEN B.[YearlyIncome]= '0-25000.00' THEN 'Low_Income'
	WHEN B.[YearlyIncome] ='25001.00-50000.00' THEN 'Mid_Income'
	WHEN B.[YearlyIncome] ='50000.00-75000.00' THEN 'Mid_Income'
	WHEN B.[YearlyIncome] ='75001.00-100000.00' THEN 'High_Income' 
	ELSE 'High_Income'
	END AS 'Income_Band'

FROM
[dbo].[FactInternetSales] AS A
LEFT JOIN [dbo].[DimCustomer] AS B ON A.[CustomerKey] = B.[CustomerKey]
LEFT JOIN [dbo].[DimProduct] AS C ON A.[ProductKey] = C.[ProductKey]
LEFT JOIN [dbo].[DimProductSubcategory] AS D ON C.[ProductSubcategoryKey] = D.[ProductSubcategoryKey]
LEFT JOIN [dbo].[DimProductCategory] AS E ON D.[ProductCategoryKey] = E.[ProductCategoryKey]


CHURNING QUERY(YES OR 1)

SELECT
A.[CustomerKey], A.[SalesOrderNumber], A.[OrderDate], A.[OrderQuantity], A.[SalesAmount], 
B.[MaritalStatus], B.[YearlyIncome], B.[BirthDate], B.[Gender], B.[DateFirstPurchase], B.[EnglishEducation] AS CustEducation, B.[EnglishOccupation] as CustOccupation,
D.[EnglishProductSubcategoryName] AS ProdSubCategory,
E.[EnglishProductCategoryName] as ProdCategory,
F.[SalesTerritoryRegion] AS Region

FROM
[dbo].[FactInternetSales] AS A
LEFT JOIN [dbo].[DimCustomer] AS B ON A.[CustomerKey] = B.[CustomerKey]
LEFT JOIN [dbo].[DimProduct] AS C ON A.[ProductKey] = C.[ProductKey]
LEFT JOIN [dbo].[DimProductSubcategory] AS D ON C.[ProductSubcategoryKey] = D.[ProductSubcategoryKey]
LEFT JOIN [dbo].[DimProductCategory] AS E ON D.[ProductCategoryKey] = E.[ProductCategoryKey]
LEFT JOIN [dbo].[DimSalesTerritory] AS F ON A.[SalesTerritoryKey] = F.[SalesTerritoryKey]

WHERE
A.[OrderDate] between '2010-12-29' and '2013-05-28'


CHURNING QUERY(N0 OR 0)

SELECT
A.[CustomerKey], A.[SalesOrderNumber], A.[OrderDate], A.[OrderQuantity], A.[SalesAmount], 
B.[MaritalStatus], B.[YearlyIncome], B.[BirthDate], B.[Gender], B.[DateFirstPurchase], B.[EnglishEducation] AS CustEducation, B.[EnglishOccupation] as CustOccupation,
D.[EnglishProductSubcategoryName] AS ProdSubCategory,
E.[EnglishProductCategoryName] as ProdCategory,
F.[SalesTerritoryRegion] AS Region

FROM
[dbo].[FactInternetSales] AS A
LEFT JOIN [dbo].[DimCustomer] AS B ON A.[CustomerKey] = B.[CustomerKey]
LEFT JOIN [dbo].[DimProduct] AS C ON A.[ProductKey] = C.[ProductKey]
LEFT JOIN [dbo].[DimProductSubcategory] AS D ON C.[ProductSubcategoryKey] = D.[ProductSubcategoryKey]
LEFT JOIN [dbo].[DimProductCategory] AS E ON D.[ProductCategoryKey] = E.[ProductCategoryKey]
LEFT JOIN [dbo].[DimSalesTerritory] AS F ON A.[SalesTerritoryKey] = F.[SalesTerritoryKey]

WHERE
A.[OrderDate] >='2013-05-29'

Yes & N0
SELECT
A.[CustomerKey], A.[SalesOrderNumber], A.[OrderDate], A.[OrderQuantity], A.[SalesAmount], 
B.[MaritalStatus], B.[YearlyIncome], B.[BirthDate], B.[Gender], B.[DateFirstPurchase], B.[EnglishEducation] AS CustEducation, B.[EnglishOccupation] as CustOccupation,
D.[EnglishProductSubcategoryName] AS ProdSubCategory,
E.[EnglishProductCategoryName] as ProdCategory,
F.[SalesTerritoryRegion] AS Region

FROM
[dbo].[FactInternetSales] AS A
LEFT JOIN [dbo].[DimCustomer] AS B ON A.[CustomerKey] = B.[CustomerKey]
LEFT JOIN [dbo].[DimProduct] AS C ON A.[ProductKey] = C.[ProductKey]
LEFT JOIN [dbo].[DimProductSubcategory] AS D ON C.[ProductSubcategoryKey] = D.[ProductSubcategoryKey]
LEFT JOIN [dbo].[DimProductCategory] AS E ON D.[ProductCategoryKey] = E.[ProductCategoryKey]
LEFT JOIN [dbo].[DimSalesTerritory] AS F ON A.[SalesTerritoryKey] = F.[SalesTerritoryKey]

WHERE
A.[OrderDate] between '2010-12-29' and '2014-01-28'




SELECT MIN ([OrderDate]) AS "Max Date" 
FROM
[dbo].[FactInternetSales]



SELECT MAX ([OrderDate]) AS "Max Date" 
FROM
[dbo].[FactInternetSales]

###############################################################
Churn sales details

SELECT
[CustomerKey], [ProductKey],[SalesOrderNumber], [OrderDate], [OrderQuantity], [SalesAmount], [SalesTerritoryKey]

FROM
[dbo].[FactInternetSales]


churn customer details

SELECT
[CustomerKey],[BirthDate],[MaritalStatus],[Gender],[YearlyIncome],[TotalChildren],[EnglishEducation],[EnglishOccupation],
[HouseOwnerFlag],[NumberCarsOwned],[DateFirstPurchase]
FROM
[dbo].[DimCustomer]


Churn Product details

SELECT
[ProductKey], [EnglishProductName] AS Product

FROM
[dbo].[DimProduct]


 where
 [ProductKey] >213
@#######################################################################

SELECT*

FROM
[dbo].[DimCustomer]

SELECT*
FROM
[dbo].[FactInternetSales]


SELECT*
FROM
[dbo].[DimProduct]

SELECT 
    id_category, COUNT(id_category)
FROM
    category
GROUP BY id_category
HAVING COUNT(id_prod) > 1;

SELECT 
     id_prod, COUNT(id_prod)
FROM
    product
GROUP BY  id_prod 
HAVING COUNT(id_prod) > 1;


 SELECT 
     id_region, COUNT(id_region)
FROM
    region
GROUP BY  id_region 
HAVING COUNT(id_region) > 1;


SELECT 
     id_state, COUNT(id_state)
FROM
    states
GROUP BY  id_state 
HAVING COUNT(id_state) > 1;


SELECT 
     id_vendita, COUNT(id_vendita)
FROM
    sales
GROUP BY  id_vendita 
HAVING COUNT(id_vendita) > 1;

USE toysgroup;

SELECT 
    sales.id_vendita,
    sales.data_vendita,
    product.nome_prod,
    category.categoria,
    region.nome_regione,
    states.states,
    CASE 
        WHEN DATEDIFF(CURDATE(), sales.data_vendita) > 180 THEN TRUE
        ELSE FALSE
    END AS is_older_than_180_days
FROM
    sales
        INNER JOIN product ON sales.prodotto = product.id_prod
        INNER JOIN category ON product.categoria = category.id_category
        INNER JOIN region ON sales.regione = region.id_region
        INNER JOIN states ON region.id_region = states.regione;
        
WITH LastYear AS (
    SELECT YEAR(MAX(data_vendita)) AS last_year
    FROM Sales
),

AverageSalesLastYear AS (
    SELECT AVG(quantità) AS average_quantity
    FROM Sales
    JOIN LastYear ON YEAR(Sales.data_vendita) = LastYear.last_year
),

TotalSalesPerProduct AS (
    SELECT prodotto, SUM(quantità) AS total_quantity
    FROM Sales
    GROUP BY prodotto
)

SELECT 
    Product.id_prod AS codice_prodotto,
    TotalSalesPerProduct.total_quantity AS totale_venduto
FROM 
    TotalSalesPerProduct
JOIN 
    AverageSalesLastYear
    ON TotalSalesPerProduct.total_quantity > AverageSalesLastYear.average_quantity
JOIN 
    Product ON Product.id_prod = TotalSalesPerProduct.prodotto;


SELECT 
    Product.id_prod AS codice_prodotto,
    Product.nome_prod,
    YEAR(Sales.data_vendita) AS anno,
    SUM(Sales.quantità * Product.costo_prod) AS fatturato_totale
FROM 
    Sales
JOIN 
    Product ON Sales.prodotto = Product.id_prod
GROUP BY 
    Product.id_prod, YEAR(Sales.data_vendita)
HAVING 
    fatturato_totale > 0
ORDER BY 
    anno, codice_prodotto;


SELECT 
    States.states AS stato,
    YEAR(Sales.data_vendita) AS anno,
    SUM(Sales.quantità * Product.costo_prod) AS fatturato_totale
FROM 
    Sales
JOIN 
    Product ON Sales.prodotto = Product.id_prod
JOIN 
    Region ON Sales.regione = Region.id_region
JOIN 
    States ON Region.id_region = States.regione
GROUP BY 
    States.states, YEAR(Sales.data_vendita)
ORDER BY 
    anno ASC, fatturato_totale DESC;


SELECT 
    Category.categoria,
    SUM(Sales.quantità) AS totale_quantità
FROM 
    Sales
JOIN 
    Product ON Sales.prodotto = Product.id_prod
JOIN 
    Category ON Product.categoria = Category.id_category
GROUP BY 
    Category.categoria
ORDER BY 
    totale_quantità DESC
LIMIT 1;


SELECT 
    Product.id_prod,
    Product.nome_prod
FROM 
    Product
LEFT JOIN 
    Sales ON Product.id_prod = Sales.prodotto
WHERE 
    Sales.id_vendita IS NULL;


CREATE VIEW Product_Denormalized AS
SELECT 
    Product.id_prod AS codice_prodotto,
    Product.nome_prod AS nome_prodotto,
    Category.categoria AS nome_categoria
FROM 
    Product
JOIN 
    Category ON Product.categoria = Category.id_category;


CREATE VIEW Geographic_Info AS
SELECT 
    Region.id_region AS codice_regione,
    Region.nome_regione,
    States.id_state AS codice_stato,
    States.states AS nome_stato
FROM 
    Region
JOIN 
    States ON Region.id_region = States.regione;

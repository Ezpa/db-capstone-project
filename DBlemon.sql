USE littlelemondbB;

CREATE View OrdersView As Select OrderID, Quantity, TotalCost
FROM Orders
WHERE Quantity > 2;

SELECT * FROM OrdersView;

SELECT C.CustomerID, C.Name, Orders.OrderID, Orders.TotalCost, Menu.MenuID, Menu.Courses, Menu.Starters
FROM  `customer details` AS C 
INNER JOIN Orders ON (C.OrderID = Orders.OrderID)
INNER JOIN Menu ON (Orders.MenuID = Menu.MenuID)
WHERE Orders.TotalCost > 150
ORDER BY Orders.TotalCost ASC;



SELECT CONCAT(Cuisines, Starters) AS MenuName
FROM Menu
WHERE MenuID = ANY (SELECT Quantity FROM Orders WHERE Quantity > 2);





-- --------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE GetMaxQuantity()
BEGIN
    SELECT MAX(quantity) as max_quantity FROM Orders;
END //

DELIMITER ;

CALL GetMaxQuantity();

-- -------------------------------------------------------------------------------------------

PREPARE GetOrderDetail FROM 'SELECT OrderID, Quantity, TotalCost FROM Orders WHERE OrderID = ?';
SET @OrderID = 1;
EXECUTE GetOrderDetail USING @OrderID;

-- ------------------------------------------------------------------------------------------

DELIMITER //

CREATE PROCEDURE CancelOrder(IN Order_ID INT)
BEGIN
	DELETE FROM orders WHERE OrderID = order_id;
    SELECT CONCAT('Order with ID ', Order_ID, ' has been cancelled.') as message;
END //

DELIMITER ;	

CALL CancelOrder(4);

DROP PROCEDURE CancelOrder;
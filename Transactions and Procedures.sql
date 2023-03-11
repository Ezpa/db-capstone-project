
-- INSERTS ADDED
SELECT * FROM bookings;

-- ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TASK 2


SELECT * FROM bookings;

Delimiter //
CREATE PROCEDURE CheckBooking(IN BookingDate DATE, IN TableNumber INT)
BEGIN
    IF EXISTS (
        SELECT * FROM bookings
        WHERE Date = BookingDate AND Table_Number = TableNumber
    ) THEN
        SELECT CONCAT('Table ', TableNumber, ' already booked') AS BookingStatus;
    ELSE
        SELECT CONCAT('Table ', TableNumber, ' available for booking') AS BookingStatus;
    END IF;
END //
DELIMITER ;

Drop PROCEDURE CheckBooking;
CALL CheckBooking("2022-11-12", 3);


-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TASK 3

DELIMITER //
CREATE PROCEDURE AddValidBooking(IN BookingDate DATE, IN TableNumber INT)
BEGIN
    DECLARE booking_count INT;
    
    START TRANSACTION;
    
    SET booking_count = (
        SELECT COUNT(*)
        FROM bookings
        WHERE Date = BookingDate AND Table_Number = TableNumber
    );
    
    IF booking_count > 0 THEN
        ROLLBACK;
    ELSE
        INSERT INTO bookings (Date, Table_Number)
        VALUES (BookingDate, TableNumber);

        COMMIT;
    END IF;
END //
DELIMITER ;

DROP PROCEDURE AddValidBooking;
CALL AddValidBooking("2022-12-17", 6);



-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- Create SQL queries to add and update bookings
-- TASK 1



DELIMITER //
CREATE PROCEDURE AddBooking(IN bookingID INT, IN CustomerID INT, IN Table_Number INT, IN Date DATE)
BEGIN

		INSERT INTO bookings (bookingID, CustomerID, Date, Table_Number)
		VALUES (bookingid, Customerid, Date, Table_Number);

		SELECT 'New Booking Added' AS Confirmation;

END //
DELIMITER ;

DROP PROCEDURE AddBooking;
CALL AddBooking(9, 3, 4, "2022-12-30");



-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

-- TASK 2


DELIMITER //
CREATE PROCEDURE UpdateBooking(IN bookingID INT, IN Date DATE)
BEGIN
	UPDATE bookings set Date = DATE WHERE bookingID = DATE;
	SELECT CONCAT('Booking ', bookingID, ' updated') AS Confirmation; 
END //
DELIMITER ;

DROP PROCEDURE UpateBooking;
CALL UpdateBooking(9, "2022-12-17");



-- --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- TASK 3



DELIMITER //
CREATE PROCEDURE CancelBooking(IN bookingID int)
BEGIN

    DECLARE ID INT;
	DELETE FROM bookings WHERE ID = bookingID;
	SELECT CONCAT ('Booking ', bookingID, ' cancelled') AS Confirmation;
END //
DELIMITER ;

DROP PROCEDURE CancelBookingp;
CALL CancelBooking(9);


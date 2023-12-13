CREATE TABLE IF NOT EXISTS public.room_types (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS public.guests (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL CHECK (name <> '' AND name IS NOT NULL),
    info VARCHAR(100) NOT NULL CHECK (info <> '' AND info IS NOT NULL),
    email VARCHAR(100) NOT NULL CHECK (email <> '' AND email IS NOT NULL),
    phone_number VARCHAR(13) NOT NULL CHECK (phone_number <> '' AND phone_number IS NOT NULL),
    egn VARCHAR(10) NOT NULL CHECK (egn <> '' AND egn IS NOT NULL),
    birth_date DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS public.rooms (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL CHECK (name <> '' AND name IS NOT NULL),
    price_per_night NUMERIC(6,2) NOT NULL CHECK (price_per_night >= 0),
    capacity INTEGER NOT NULL CHECK (capacity >= 0),
    room_type_id INT NOT NULL,
	rating INT ,
    FOREIGN KEY (room_type_id) REFERENCES public.room_types(id)
);

CREATE TABLE IF NOT EXISTS public.payment_types(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.reservations (
    id SERIAL PRIMARY KEY NOT NULL,
    payment_type_id INT NOT NULL,
	cancelled BOOLEAN NOT NULL,
    guest_id INT NOT NULL,
    date_from DATE NOT NULL,
    date_to DATE NOT NULL,
    number_guests INTEGER,
    total_price NUMERIC(7,2) CHECK (total_price >= 0),
    FOREIGN KEY (payment_type_id) REFERENCES public.payment_types(id),
    FOREIGN KEY (guest_id) REFERENCES public.guests(id)
);


CREATE TABLE IF NOT EXISTS public.seasonal_promotions (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL CHECK (name <> '' AND name IS NOT NULL),
    date_from DATE NOT NULL,
    date_to DATE NOT NULL CHECK (date_to >= date_from)
);
CREATE TABLE IF NOT EXISTS public.service_names(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
	price NUMERIC(6,2),
	season_id INT NOT NULL,
	FOREIGN KEY (season_id) REFERENCES public.seasonal_promotions (id)
);

CREATE TABLE IF NOT EXISTS public.services(
    id SERIAL PRIMARY KEY NOT NULL,
    service_name_id INT NOT NULL,
	reservation_id INT NOT NULL,
    price NUMERIC(6,2),
    quantity INTEGER NOT NULL,
	FOREIGN KEY (service_name_id) REFERENCES public.service_names (id),
	FOREIGN KEY (reservation_id) REFERENCES public.reservations (id)
);




CREATE TABLE IF NOT EXISTS public.rooms_reservations(
    room_id INT NOT NULL,
    reservation_id INT NOT NULL,
    FOREIGN KEY (room_id) REFERENCES public.rooms (id),
    FOREIGN KEY (reservation_id) REFERENCES public.reservations (id)
);

CREATE TABLE IF NOT EXISTS public.review(
	id SERIAL PRIMARY KEY NOT NULL,
	room_id INT NOT NULL,
	guest_id INT NULL,
	rating INT CHECK (rating >= 1 AND rating <= 5),
	coment VARCHAR(100) NOT NULL,
	FOREIGN KEY (room_id) REFERENCES public.rooms (id),
	FOREIGN KEY (guest_id) REFERENCES public.guests (id)
);

INSERT INTO public.review(room_id,guest_id,rating,coment) VALUES
(1,NULL,5,'Primeren comentar'),
(1,NULL,5,'Primeren comentar'),
(1,NULL,3,'Primeren comentar'),
(1,NULL,3,'Primeren comentar');
--INSERTS
INSERT INTO public.payment_types (name) VALUES
  ('Credit Card'),
  ('Cash'),
  ('PayPal'),
  ('Bank Transfer'),
  ('Venmo'),
  ('Apple Pay'),
  ('Google Pay'),
  ('Bitcoin'),
  ('Check'),
  ('Amazon Pay');
  
  
  
    INSERT INTO public.seasonal_promotions(name, date_from, date_to)
VALUES 
    ('Year-Round Special', '2023-01-01', '2023-12-31'),
    ('Spring Special Offer', '2023-03-20', '2023-06-20'),
    ('Summer Special Offer', '2023-06-21', '2023-09-22'),
    ('Autumn Special Offer', '2023-09-23', '2023-12-20'),
    ('Winter Special Offer', '2023-09-21', '2024-03-19');
	
INSERT INTO public.room_types (name)
VALUES 
  ('Single Room'),
  ('Double Room'),
  ('Suite'),
  ('Twin Room'),
  ('Family Room');

INSERT INTO public.service_names(name,price,season_id) 
VALUES
	('OutsidePool',15,3),
	('InsidePool',25,1),
	('Dinner',5,1),
	('Lunch',5,1),
	('Breakfast',5,1),
	('SPA',10,1),
	('Fitness',5,1);
	
	
INSERT INTO public.rooms (name,price_per_night,capacity,room_type_id) VALUES
  ('Room 101', 30, 1,1),
  ('Room 102', 30, 1,1),
  ('Room 103', 30, 4,5),
  ('Room 104', 30, 1,1),
  ('Room 201', 40, 2,2),
  ('Room 202', 40, 2,2),
  ('Room 203', 40, 2,2),
  ('Room 204', 40, 2,2),
  ('Room 204', 45, 5,3),
  ('Room 301', 45, 3,3),
  ('Room 302', 45, 4,5),
  ('Room 303', 45, 2,2),
  ('Room 304', 50, 4,4),
  ('Room 401', 45, 5,3),
  ('Room 402', 50, 2,4),
  ('Room 403', 50, 4,4),
  ('Room 404', 50, 4,4);
  
  INSERT INTO public.guests(name,info,email,phone_number,egn,birth_date)  VALUES
 ('Nikola','Student in TU VARNA','nikola123@abv.bg','+359883928323','0149283721','2001-08-15'),
('Yordan','Teacher in TU VARNA','yordanY@abv.bg','+359892381323','9587362518','1995-06-19'),
('Yancho','Student in MU VARNA','jane123@gmail.com','+359873285594','0142938295','2001-07-22'),
('Aleksandar','Teacher in MU VARNA','alexP@gmail.com','+359887236217','9023920149','1990-01-23');
  
INSERT INTO public.reservations(payment_type_id, guest_id, date_from, date_to) VALUES
 (1, 1, '2023-11-01', '2023-11-05'),
  (2, 2, '2023-11-10', '2023-11-15'),
  (3, 3, '2023-11-05', '2023-11-08'),
  (1, 4, '2023-11-20', '2023-11-25'),
  (4, 3, '2023-11-15', '2023-11-20'),
  (2, 3, '2023-11-03', '2023-11-07'),
  (1, 3, '2023-11-08', '2023-11-12'),
  (3, 3, '2023-11-02', '2023-11-06'),
  (3, 3, '2023-11-12', '2023-11-17'),
  (3, 3, '2023-11-22', '2023-11-27');
  
  
  INSERT INTO public.reservations(payment_type_id, guest_id, date_from, date_to) VALUES
  (1,1,'2023-12-13','2023-12-15');
  

INSERT INTO rooms_reservations (room_id, reservation_id)
VALUES (11, 1); 
  
 
  

INSERT INTO rooms_reservations (room_id, reservation_id)
VALUES (2, 1);

INSERT INTO rooms_reservations (room_id, reservation_id)
VALUES (3, 1);

INSERT INTO rooms_reservations (room_id, reservation_id)
VALUES (4, 1);

INSERT INTO rooms_reservations (room_id, reservation_id)
VALUES (5, 1);


INSERT INTO public.services (service_name_id, quantity,reservation_id)
VALUES
  (29,4,1),
  (30,4,1),
  (31,4,1),
  (32,4,1);
 



--SELECT QUERIES
--  SELECT reservations(id),rooms(name),guests(name),reservation(date_from),reservation(date_to)
--  FROM public.reservations;



	-- TRIGGER FUNCTION
	--1. TRIGGER FUNCTION
CREATE OR REPLACE FUNCTION calculate_reservation_price()
RETURNS TRIGGER AS $$
DECLARE
  room_price NUMERIC(6,2);
  service_price NUMERIC(6,2);
BEGIN
  -- Calculate room price
  room_price = (
    SELECT SUM(r.price_per_night * (res.date_to - res.date_from + 1))
    FROM rooms r
    JOIN rooms_reservations rr ON r.id = rr.room_id
    JOIN reservations res ON rr.reservation_id = res.id
    WHERE res.id = NEW.reservation_id
  );

-- Calculate service price
  service_price = COALESCE((
    SELECT SUM(sn.price * s.quantity)
    FROM services s
    JOIN service_names sn ON s.service_name_id = sn.id
    WHERE s.reservation_id = NEW.reservation_id
  ), 0.0);

  -- Update total price in reservations table
  UPDATE reservations
  SET total_price = room_price + service_price
  WHERE id = NEW.reservation_id;

	RAISE NOTICE 'Room Price: %, Service Price: %, Total Price: %', room_price, service_price, room_price + service_price;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

	-- TRIGGER for public.rooms_reservations
CREATE TRIGGER calculate_reservation_price_rooms_reservations
AFTER INSERT OR UPDATE ON public.rooms_reservations
FOR EACH ROW
EXECUTE FUNCTION calculate_reservation_price();

-- TRIGGER for public.services
CREATE TRIGGER calculate_reservation_price_services
AFTER INSERT ON public.services
FOR EACH ROW
EXECUTE FUNCTION calculate_reservation_price();
	
	
	
--2.CalculateServicePrice

-- TRIGGER FUNCTION
CREATE OR REPLACE FUNCTION calculate_service_price()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.services AS s
    SET price = (
        SELECT sn.price * NEW.quantity
        FROM public.service_names AS sn
        WHERE sn.id = NEW.service_name_id
    )
    WHERE s.id = NEW.id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to execute the function after insert on services table
CREATE TRIGGER update_service_price
AFTER INSERT ON public.services
FOR EACH ROW
EXECUTE FUNCTION calculate_service_price();



--3 Average Rating Trigger
CREATE OR REPLACE FUNCTION update_room_rating()
RETURNS TRIGGER AS $$
DECLARE
  avg_rating NUMERIC(3,2);
BEGIN
  -- Calculate average rating for the room
  SELECT AVG(rating) INTO avg_rating
  FROM review
  WHERE room_id = NEW.room_id;

  -- Update the room rating in the rooms table
  UPDATE rooms
  SET rating = avg_rating
  WHERE id = NEW.room_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER for public.review
CREATE TRIGGER update_room_rating_trigger
AFTER INSERT ON public.review
FOR EACH ROW
EXECUTE FUNCTION update_room_rating();


--4.Function
-- Trigger Function to Check Room Availability
CREATE OR REPLACE FUNCTION check_room_availability()
RETURNS TRIGGER AS $$
DECLARE
  reservation_period TSRANGE;
  overlapping_reservations INTEGER;
BEGIN
  -- Get the reservation period for the new reservation
  SELECT daterange(res.date_from, res.date_to, '[]') INTO reservation_period
  FROM reservations res
  WHERE res.id = NEW.reservation_id;

  -- Check for overlapping reservations for the given room and period
  SELECT COUNT(*)
  INTO overlapping_reservations
  FROM rooms_reservations rr
  JOIN reservations res ON rr.reservation_id = res.id
  WHERE rr.room_id = NEW.room_id
    AND tsrange(res.date_from, res.date_to, '[]') && reservation_period;

  -- If there are overlapping reservations, raise an exception
  IF overlapping_reservations > 0 THEN
    RAISE EXCEPTION 'Room is not available for the specified period.';
  END IF;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for public.rooms_reservations to Check Room Availability
--5.0


---SELECTSSSS
--Да се направи заявка за отчет на пристигащите резервации към днешна дата 
--(от гледна точка на рецепционист). Резултатът от заявката да съдържа 
--данни за номер на резервация, номер на стаята, която е резервирана, 
--имената на клиента към резервацията, датите на престой, броя души, 
--крайната сума и метод на плащане
SELECT
    r.id AS reservation_number,
    rm.name AS room_name,
    g.name AS guest_name,
    r.number_guests AS number_of_guests, 
    r.total_price AS total_amount,
    pt.name AS payment_type,
    r.date_from AS reservation_start_date,
    r.date_to AS reservation_end_date
FROM
    public.reservations r
JOIN
    public.guests g ON r.guest_id = g.id
JOIN
    public.rooms_reservations rr ON r.id = rr.reservation_id
JOIN
    public.rooms rm ON rr.room_id = rm.id
JOIN
    public.payment_types pt ON r.payment_type_id = pt.id
WHERE
    CURRENT_DATE BETWEEN r.date_from AND r.date_to
    AND r.date_from = CURRENT_DATE
	AND r.cancelled=false;
	
	
-- 	Да се направи заявка за отчет на избраните допълнителни услуги към 
-- резервация по име на клиент. Заявката да се базира на идентификатор на 
-- резервацията. Резултатът да включва името на услугата, количеството от 
-- услугата и финалната цена за услугата.
	
	SELECT g.name AS guest_name,
       sn.name AS service_name,
       s.quantity,
       sn.price * s.quantity AS total_price
FROM public.services s
JOIN public.service_names sn ON s.service_name_id = sn.id
JOIN public.reservations r ON s.reservation_id = r.id
JOIN public.guests g ON r.guest_id = g.id
WHERE r.id = 1 AND r.cancelled=false;


-- Да се направи заявка отчет, показваща най-натовареният период на 
-- резервации. Резултатът да включва брой резервации и стаите към тях за 
-- дадения период

SELECT
    r.date_from AS reservation_date,
    rm.name AS room_name,
    COUNT(*) AS reservation_count
FROM
    public.reservations r
JOIN
    public.rooms_reservations rr ON r.id = rr.reservation_id
JOIN
    public.rooms rm ON rr.room_id = rm.id
GROUP BY
    r.date_from, rm.name
ORDER BY
    reservation_count DESC
LIMIT 5;

-- Да се покажат последователността от действия, съответстващи на 
-- анулирането на резервация. Изтриване на резервацията не е допустимо от 
-- гледна точка на принципа за хисторизация на резервациите.
UPDATE public.reservations SET cancelled = TRUE WHERE id = 31;
  
  


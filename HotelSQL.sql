CREATE TABLE IF NOT EXISTS public.room_types (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);
CREATE TABLE IF NOT EXISTS  public.guests(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    info  VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone_number VARCHAR(13) NOT NULL,
    egn VARCHAR(10) NOT NULL ,
    birth_date DATE NOT NULL
);


CREATE TABLE IF NOT EXISTS public.rooms (
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    price_per_night NUMERIC(6,2) NOT NULL,
    capacity INTEGER NOT NULL,
	room_type_id INT NOT NULL,
	FOREIGN KEY (room_type_id) REFERENCES public.room_types(id)
	
);

CREATE TABLE IF NOT EXISTS public.payment_types(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE IF NOT EXISTS public.reservations(
    id SERIAL PRIMARY KEY NOT NULL,
    payment_type_id INT NOT NULL,
    guest_id INT NOT NULL,
    date_from DATE NOT NULL,
    date_to DATE NOT NULL,
    total_price NUMERIC(7,2),
    FOREIGN KEY (payment_type_id) REFERENCES public.payment_types (id),
    FOREIGN KEY (guest_id) REFERENCES public.guests(id)
);
CREATE TABLE IF NOT EXISTS public.service_names(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
	price NUMERIC(6,2)
);

CREATE TABLE IF NOT EXISTS public.services(
    id SERIAL PRIMARY KEY NOT NULL,
    service_name_id INT NOT NULL,
	season_id INT NOT NULL,
	reservation_id INT NOT NULL,
    price NUMERIC(6,2),
    quantity INTEGER NOT NULL,
	FOREIGN KEY (service_name_id) REFERENCES public.service_names (id),
	FOREIGN KEY (season_id) REFERENCES public.seasonal_promotions (id),
	FOREIGN KEY (reservation_id) REFERENCES public.reservations (id)
);


CREATE TABLE IF NOT EXISTS public.services_reservations(
    service_id INT NOT NULL,
    reservation_id INT NOT NULL,
    FOREIGN KEY (service_id) REFERENCES public.services (id),
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
	reservation_id INT NOT NULL,
	guest_id INT ,
	rating INT
);
CREATE TABLE IF NOT EXISTS public.seasonal_promotions(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    date_from DATE NOT NULL,
    date_to DATE NOT NULL
);


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
	
INSERT INTO public.room_types (name)
VALUES 
  ('Single Room'),
  ('Double Room'),
  ('Suite'),
  ('Twin Room'),
  ('Family Room');

INSERT INTO public.service_names(name,price) 
VALUES
	('Pool',15),
	('Dinner',5),
	('Lunch',5),
	('Breakfast',5),
	('SPA',10),
	('Fitness',5);
	
	
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
  
  INSERT INTO public.seasonal_promotions(name, date_from, date_to)
VALUES 
    ('Year-Round Special', '2023-01-01', '2023-12-31'),
    ('Spring Special Offer', '2023-03-20', '2023-06-20'),
    ('Summer Special Offer', '2023-06-21', '2023-09-22'),
    ('Autumn Special Offer', '2023-09-23', '2023-12-20'),
    ('Winter Special Offer', '2023-09-21', '2024-03-19');
  
 
  

INSERT INTO rooms_reservations (room_id, reservation_id)
VALUES (2, 1);

INSERT INTO rooms_reservations (room_id, reservation_id)
VALUES (3, 1);

INSERT INTO rooms_reservations (room_id, reservation_id)
VALUES (4, 1);


INSERT INTO public.services (service_name_id, quantity)
VALUES
  (1,4),
  (2,4),
  (3,5);


INSERT INTO services_reservations (service_id, reservation_id)
VALUES (1, 2);


--SELECT QUERIES
 SELECT reservations(id),rooms(name),guests(name),reservation(date_from),reservation(date_to)
 FROM public.reservations;



	-- TRIGGER FUNCTION
	CREATE OR REPLACE FUNCTION calculate_reservation_price()
	RETURNS TRIGGER AS $$
	DECLARE
	  room_price NUMERIC(6,2);
	  service_price NUMERIC(6,2);
	BEGIN

	  room_price = (
		SELECT SUM(r.price_per_night * (res.date_to - res.date_from + 1))
		FROM rooms r
		JOIN rooms_reservations rr ON r.id = rr.room_id
		JOIN reservations res ON rr.reservation_id = res.id
		WHERE res.id = NEW.reservation_id
	  );


	  service_price = COALESCE((
		SELECT SUM(s.price * s.quantity)
		FROM services s
		JOIN services_reservations sr ON s.id = sr.service_id
		WHERE sr.reservation_id = NEW.reservation_id
	  ), 0.0);


	  UPDATE reservations
	  SET total_price = room_price + service_price
	  WHERE id = NEW.reservation_id;

	  RETURN NEW;
	END;
	$$ LANGUAGE plpgsql;

	-- TRIGGER
	CREATE TRIGGER calculate_reservation_price_trigger
	AFTER INSERT OR UPDATE ON public.rooms_reservations
	FOR EACH ROW
	EXECUTE FUNCTION calculate_reservation_price();
	
	
	
----AnotherTrigger 

CREATE OR REPLACE FUNCTION calculate_price()
RETURNS TRIGGER AS $$
BEGIN
    UPDATE public.services AS s
    SET price = (sn.price * NEW.quantity)
    FROM public.service_names AS sn
    WHERE sn.id = NEW.service_name_id AND s.service_name_id = NEW.service_name_id;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Create a trigger to execute the function after insert on services table
CREATE TRIGGER update_service_price
AFTER INSERT ON public.services
FOR EACH ROW
EXECUTE FUNCTION calculate_price();


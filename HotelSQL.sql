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



-- TRIGGER FUNCTION
CREATE OR REPLACE FUNCTION calculate_reservation_price_with_services()
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
    SELECT SUM(s.price * s.quantity)
    FROM services s
    JOIN services_reservations sr ON s.id = sr.service_id
    WHERE sr.reservation_id = NEW.reservation_id
  ), 0.0);

  -- Update total_price in reservations table
  UPDATE reservations
  SET total_price = room_price + service_price
  WHERE id = NEW.reservation_id;

  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- TRIGGER
CREATE TRIGGER calculate_reservation_price_with_services_trigger
AFTER INSERT OR UPDATE ON public.rooms_reservations
FOR EACH ROW
EXECUTE FUNCTION calculate_reservation_price_with_services();


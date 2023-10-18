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
    capacity INTEGER NOT NULL
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

CREATE TABLE IF NOT EXISTS public.services(
    id SERIAL PRIMARY KEY NOT NULL,
    name VARCHAR(100) NOT NULL,
    price NUMERIC(6,2),
    quantity INTEGER NOT NULL
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
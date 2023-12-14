--Employeeee
CREATE USER employee WITH ENCRYPTED PASSWORD '123456';

CREATE ROLE employeeRole;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO employeeRole;

GRANT INSERT ON TABLE guests, reservations,rooms_reservations TO employeeRole;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO employeeRole;

REVOKE UPDATE ON TABLE reservations FROM employeeRole;



GRANT INSERT, UPDATE, DELETE ON TABLE guests, rooms,rooms_reservations,review TO employeeRole;

ALTER USER employee WITH ENCRYPTED PASSWORD '123456';

GRANT employeeRole TO employee;



--Admin

CREATE USER adminhotel WITH ENCRYPTED PASSWORD '123456';

CREATE ROLE adminhotelRole;

GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA public TO adminhotelRole;

GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA public TO adminhotelRole;

ALTER USER adminhotel WITH ENCRYPTED PASSWORD '123456';

GRANT adminhotelRole TO adminhotel;

UPDATE public.reservations SET cancelled = TRUE WHERE id = 1;--Access denied


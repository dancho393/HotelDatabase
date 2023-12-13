
CREATE USER employee WITH ENCRYPTED PASSWORD '123456';

CREATE ROLE employeeRole;

GRANT SELECT ON ALL TABLES IN SCHEMA public TO employeeRole;

GRANT INSERT ON TABLE guests, reservations,rooms_reservations TO employeeRole;

GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA public TO employeeRole;

REVOKE DELETE ON TABLE reservations FROM employeeRole;

GRANT INSERT, UPDATE, DELETE ON TABLE services TO employeeRole;

GRANT INSERT, UPDATE, DELETE ON TABLE guests, rooms TO employeeRole;

ALTER USER employee WITH ENCRYPTED PASSWORD '123456';

GRANT employeeRole TO employee;



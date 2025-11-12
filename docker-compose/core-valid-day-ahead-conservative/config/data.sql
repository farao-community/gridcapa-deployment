INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('USE_PROJECTION', 'USE PROJECTION', 1, 'BOOLEAN', 'PROJECTION ', 1, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'USE PROJECTION', display_order = 1, parameter_type = 'BOOLEAN', section_title = 'PROJECTION', section_order = 1;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, value)
VALUES ('RUN_ES-FR', 'Run ES -> FR', 1, 'BOOLEAN', 'ES -> FR', 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run ES -> FR', display_order = 1, parameter_type = 'BOOLEAN', section_title = 'ES -> FR', value = 'true';

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, value)
    VALUES ('RUN_ES-PT', 'Run ES -> PT', 5, 'BOOLEAN', 'ES -> PT', 'true')
    ON CONFLICT (id) DO
    UPDATE SET name = 'Run ES -> PT', display_order = 5, parameter_type = 'BOOLEAN', section_title = 'ES -> PT', value = 'true';

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, value)
VALUES ('RUN_FR-ES', 'Run FR -> ES', 9, 'BOOLEAN', 'FR -> ES', 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run FR -> ES', display_order = 9, parameter_type = 'BOOLEAN', section_title = 'FR -> ES', value = 'true';

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, value)
VALUES ('RUN_PT-ES', 'Run PT -> ES', 13, 'BOOLEAN', 'PT -> ES', 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run PT -> ES', display_order = 13, parameter_type = 'BOOLEAN', section_title = 'PT -> ES', value = 'true';

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, value)
VALUES ('RUN_ES-FR', 'Run ES -> FR', 1, 'BOOLEAN', 'ES -> FR', 1, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run ES -> FR', display_order = 1, parameter_type = 'BOOLEAN', section_title = 'ES -> FR', section_order = 1, value = 'true';

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, value)
    VALUES ('RUN_ES-PT', 'Run ES -> PT', 5, 'BOOLEAN', 'ES -> PT', 3, 'true')
    ON CONFLICT (id) DO
    UPDATE SET name = 'Run ES -> PT', display_order = 5, parameter_type = 'BOOLEAN', section_title = 'ES -> PT', section_order = 3, value = 'true';

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, value)
VALUES ('RUN_FR-ES', 'Run FR -> ES', 9, 'BOOLEAN', 'FR -> ES', 2, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run FR -> ES', display_order = 9, parameter_type = 'BOOLEAN', section_title = 'FR -> ES', section_order = 2, value = 'true';

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, value)
VALUES ('RUN_PT-ES', 'Run PT -> ES', 13, 'BOOLEAN', 'PT -> ES', 4, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run PT -> ES', display_order = 13, parameter_type = 'BOOLEAN', section_title = 'PT -> ES', section_order = 4, value = 'true';

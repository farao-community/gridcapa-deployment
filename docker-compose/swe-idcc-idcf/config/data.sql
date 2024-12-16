INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('RUN_ES-FR', 'Run ES -> FR', 10, 'BOOLEAN', 'ES -> FR', 1, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run ES -> FR', display_order = 10, parameter_type = 'BOOLEAN', section_title = 'ES -> FR', section_order = 1;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('RUN_FR-ES', 'Run FR -> ES', 10, 'BOOLEAN', 'FR -> ES', 2, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run FR -> ES', display_order = 10, parameter_type = 'BOOLEAN', section_title = 'FR -> ES', section_order = 2;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('RUN_ES-PT', 'Run ES -> PT', 10, 'BOOLEAN', 'ES -> PT', 3, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run ES -> PT', display_order = 10, parameter_type = 'BOOLEAN', section_title = 'ES -> PT', section_order = 3;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('RUN_PT-ES', 'Run PT -> ES', 10, 'BOOLEAN', 'PT -> ES', 4, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run PT -> ES', display_order = 10, parameter_type = 'BOOLEAN', section_title = 'PT -> ES', section_order = 4;


INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MAX_TTC_ES-FR', 'Max TTC (MW)', 20, 'INT', 'ES -> FR', 1, '6400')
    ON CONFLICT (id) DO
UPDATE SET name = 'Max TTC', display_order = 20, parameter_type = 'INT', section_title = 'ES -> FR', section_order = 1;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MAX_TTC_FR-ES', 'Max TTC (MW)', 20, 'INT', 'FR -> ES', 2, '6400')
    ON CONFLICT (id) DO
UPDATE SET name = 'Max TTC (MW)', display_order = 20, parameter_type = 'INT', section_title = 'FR -> ES', section_order = 2;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MAX_TTC_ES-PT', 'Max TTC (MW)', 20, 'INT', 'ES -> PT', 3, '6400')
    ON CONFLICT (id) DO
UPDATE SET name = 'Max TTC (MW)', display_order = 20, parameter_type = 'INT', section_title = 'ES -> PT', section_order = 3;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MAX_TTC_PT-ES', 'Max TTC (MW)', 20, 'INT', 'PT -> ES', 4, '6400')
    ON CONFLICT (id) DO
UPDATE SET name = 'Max TTC (MW)', display_order = 20, parameter_type = 'INT', section_title = 'PT -> ES', section_order = 4;


INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MIN_TTC_ES-FR', 'Min TTC (MW)', 30, 'INT', 'ES -> FR', 1, '0')
    ON CONFLICT (id) DO
UPDATE SET name = 'Min TTC (MW)', display_order = 30, parameter_type = 'INT', section_title = 'ES -> FR', section_order = 1;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MIN_TTC_FR-ES', 'Min TTC (MW)', 30, 'INT', 'FR -> ES', 2, '0')
    ON CONFLICT (id) DO
UPDATE SET name = 'Min TTC (MW)', display_order = 30, parameter_type = 'INT', section_title = 'FR -> ES', section_order = 2;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MIN_TTC_ES-PT', 'Min TTC (MW)', 30, 'INT', 'ES -> PT', 3, '0')
    ON CONFLICT (id) DO
UPDATE SET name = 'Min TTC (MW)', display_order = 30, parameter_type = 'INT', section_title = 'ES -> PT', section_order = 3;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MIN_TTC_PT-ES', 'Min TTC (MW)', 30, 'INT', 'PT -> ES', 4, '0')
    ON CONFLICT (id) DO
UPDATE SET name = 'Min TTC (MW)', display_order = 30, parameter_type = 'INT', section_title = 'PT -> ES', section_order = 4;


INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('DICHOTOMY_PRECISION_ES-FR', 'Dichotomy precision (MW)', 40, 'INT', 'ES -> FR', 1, '50')
    ON CONFLICT (id) DO
UPDATE SET name = 'Dichotomy precision (MW)', display_order = 40, parameter_type = 'INT', section_title = 'ES -> FR', section_order = 1;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('DICHOTOMY_PRECISION_FR-ES', 'Dichotomy precision (MW)', 40, 'INT', 'FR -> ES', 2, '50')
    ON CONFLICT (id) DO
UPDATE SET name = 'Dichotomy precision (MW)', display_order = 40, parameter_type = 'INT', section_title = 'FR -> ES', section_order = 2;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('DICHOTOMY_PRECISION_ES-PT', 'Dichotomy precision (MW)', 40, 'INT', 'ES -> PT', 3, '50')
    ON CONFLICT (id) DO
UPDATE SET name = 'Dichotomy precision (MW)', display_order = 40, parameter_type = 'INT', section_title = 'ES -> PT', section_order = 3;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('DICHOTOMY_PRECISION_PT-ES', 'Dichotomy precision (MW)', 40, 'INT', 'PT -> ES', 4, '50')
    ON CONFLICT (id) DO
UPDATE SET name = 'Dichotomy precision (MW)', display_order = 40, parameter_type = 'INT', section_title = 'PT -> ES', section_order = 4;


INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('RUN_ANGLE_CHECK', 'Run angle check', 10, 'BOOLEAN', 'RAO Parameters', 5, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run angle check', display_order = 10, parameter_type = 'BOOLEAN', section_title = 'RAO Parameters', section_order = 5;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('RUN_VOLTAGE_CHECK', 'Run voltage check', 20, 'BOOLEAN', 'RAO Parameters', 5, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'Run voltage check', display_order = 20, parameter_type = 'BOOLEAN', section_title = 'RAO Parameters', section_order = 5;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MAX_CRA', 'Max amount of Curative RA', 30, 'INT', 'RAO Parameters', 5, '10')
    ON CONFLICT (id) DO
UPDATE SET name = 'Max amount of Curative RA', display_order = 30, parameter_type = 'INT', section_title = 'RAO Parameters', section_order = 5;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('DISABLE_SECOND_PREVENTIVE_RAO', 'Disable second preventive RAO', 40, 'BOOLEAN', 'RAO Parameters', 5, 'false')
    ON CONFLICT (id) DO
UPDATE SET name = 'Disable second preventive RAO', display_order = 40, parameter_type = 'BOOLEAN', section_title = 'RAO Parameters', section_order = 5;


INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MAX_NEWTON_RAPHSON_ITERATIONS', 'Max number of iterations', 10, 'INT', 'LoadFlow Parameters', 6, '30')
    ON CONFLICT (id) DO
UPDATE SET name = 'Max number of iterations', display_order = 10, parameter_type = 'INT', section_title = 'LoadFlow Parameters', section_order = 6;

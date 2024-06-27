INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('USE_DC_CGM_INPUT', 'USE DC CGM INPUT', 1, 'BOOLEAN', 'DC CGM INPUT ', 1, 'false')
    ON CONFLICT (id) DO
UPDATE SET name = 'USE DC CGM INPUT', display_order = 1, parameter_type = 'BOOLEAN', section_title = 'DC CGM INPUT', section_order = 1;

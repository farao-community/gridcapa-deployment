INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MAX_SELECTED_VERTICES', 'NUMBER OF MAX SELECTED VERTICES', 1, 'INT', 'VERTICES FILTERING', 1, '6')
    ON CONFLICT (id) DO
UPDATE SET name = 'NUMBER OF MAX SELECTED VERTICES', display_order = 1, parameter_type = 'INT', section_title = 'VERTICES FILTERING', section_order = 1;
INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MARGIN_FOR_PREFILTER', 'MARGIN FOR PREFILTER' , 2, 'INT', 'VERTICES FILTERING', 1, '0')
    ON CONFLICT (id) DO
UPDATE SET name = 'MARGIN FOR PREFILTER', display_order = 2, parameter_type = 'INT', section_title = 'VERTICES FILTERING', section_order = 1;
INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('FRM_MARGIN_PERCENTAGE', 'FRM MARGIN PERCENTAGE' , 1, 'INT', 'COMPUTE IVA', 2, '5')
    ON CONFLICT (id) DO
UPDATE SET name = 'FRM MARGIN PERCENTAGE', display_order = 1, parameter_type = 'INT', section_title = 'COMPUTE IVA', section_order = 1;
INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MIN_RAM_MCCC', 'MINIMUM RAM MCCC' , 2, 'INT', 'COMPUTE IVA', 2, '20')
    ON CONFLICT (id) DO
UPDATE SET name = 'MINIMUM RAM MCCC', display_order = 2, parameter_type = 'INT', section_title = 'COMPUTE IVA', section_order = 1;

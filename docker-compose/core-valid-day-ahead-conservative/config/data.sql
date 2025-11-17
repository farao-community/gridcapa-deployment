INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('USE_PROJECTION', 'USE PROJECTION', 1, 'BOOLEAN', 'PROJECTION ', 1, 'true')
    ON CONFLICT (id) DO
UPDATE SET name = 'USE PROJECTION', display_order = 1, parameter_type = 'BOOLEAN', section_title = 'PROJECTION', section_order = 1;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MAX_VERTICES_PER_BRANCH', 'MAX VERTICES PER BRANCH', 1, 'INT', 'BRANCH MAX IVA', 2, '5')
    ON CONFLICT (id) DO
UPDATE SET name = 'MAX VERTICES PER BRANCH', display_order = 1, parameter_type = 'INT', section_title = 'BRANCH MAX IVA', section_order = 2;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('RAM_LIMIT', 'RAM LIMIT', 2, 'INT', 'BRANCH MAX IVA ', 2, '-10')
    ON CONFLICT (id) DO
UPDATE SET name = 'RAM LIMIT', display_order = 2, parameter_type = 'INT', section_title = 'BRANCH MAX IVA', section_order = 2;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('MIN_RAM_MCCC', 'MIN RAM MCCC PERCENT', 3, 'INT', 'BRANCH MAX IVA ', 2, '20')
    ON CONFLICT (id) DO
UPDATE SET name = 'MIN RAM MCCC PERCENT', display_order = 3, parameter_type = 'INT', section_title = 'BRANCH MAX IVA', section_order = 2;

INSERT INTO parameter (id, name, display_order, parameter_type, section_title, section_order, parameter_value)
VALUES ('EXCLUDED_BRANCHES', 'EXCLUDED BRANCHES', 4, 'STRING', 'BRANCH MAX IVA ', 2,
        '[FR-FR] Creys - Saint-Vulbas 2 [DIR];[FR-FR] Creys - Saint-Vulbas 2 [OPP];[FR-CH] Cornier - Riddes [DIR];[FR-CH] Cornier - Riddes [OPP];[FR-FR] Creys - Genissiat 1 [DIR];[FR-FR] Creys - Genissiat 1 [OPP];[FR-FR] Creys - Saint-Vulbas 1 [DIR];[FR-FR] Creys - Saint-Vulbas 1 [OPP];[FR-FR] Frasnes - Genissiat [DIR];[FR-FR] Frasnes - Genissiat [OPP];[FR-FR] Creys - Genissiat 2 [DIR];[FR-FR] Creys - Genissiat 2 [OPP];[FR-CH] Cornier - Saint-Triphon [DIR];[FR-CH] Cornier - Saint-Triphon [OPP]')
    ON CONFLICT (id) DO
UPDATE SET name = 'EXCLUDED BRANCHES', display_order = 4, parameter_type = 'STRING', section_title = 'BRANCH MAX IVA', section_order = 2;

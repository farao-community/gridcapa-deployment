CREATE DATABASE config;
CREATE USER config_server WITH ENCRYPTED PASSWORD 'config';
GRANT ALL PRIVILEGES ON DATABASE config TO config_server;
CREATE DATABASE cse_import_idcc_tasks;
CREATE USER cse_import_idcc_server WITH ENCRYPTED PASSWORD 'cse-import-idcc';
GRANT ALL PRIVILEGES ON DATABASE cse_import_idcc_tasks TO cse_import_idcc_server;
CREATE DATABASE cse_import_d2cc_tasks;
CREATE USER cse_import_d2cc_server WITH ENCRYPTED PASSWORD 'cse-import-d2cc';
GRANT ALL PRIVILEGES ON DATABASE cse_import_d2cc_tasks TO cse_import_d2cc_server;
CREATE DATABASE cse_export_idcc_tasks;
CREATE USER cse_export_idcc_server WITH ENCRYPTED PASSWORD 'cse-export-idcc';
GRANT ALL PRIVILEGES ON DATABASE cse_export_idcc_tasks TO cse_export_idcc_server;
CREATE DATABASE cse_export_d2cc_tasks;
CREATE USER cse_export_d2cc_server WITH ENCRYPTED PASSWORD 'cse-export-d2cc';
GRANT ALL PRIVILEGES ON DATABASE cse_export_d2cc_tasks TO cse_export_d2cc_server;
CREATE DATABASE core_valid_tasks;
CREATE USER core_valid_server WITH ENCRYPTED PASSWORD 'core-valid';
GRANT ALL PRIVILEGES ON DATABASE core_valid_tasks TO core_valid_server;


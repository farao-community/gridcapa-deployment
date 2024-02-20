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
CREATE DATABASE swe_d2cc_tasks;
CREATE USER swe_d2cc_server WITH ENCRYPTED PASSWORD 'swe-d2cc';
GRANT ALL PRIVILEGES ON DATABASE swe_d2cc_tasks TO swe_d2cc_server;
CREATE DATABASE swe_idcc_tasks;
CREATE USER swe_idcc_server WITH ENCRYPTED PASSWORD 'swe-idcc';
GRANT ALL PRIVILEGES ON DATABASE swe_idcc_tasks TO swe_idcc_server;
CREATE DATABASE swe_idcc_idcf_tasks;
CREATE USER swe_idcc_idcf_server WITH ENCRYPTED PASSWORD 'swe-idcc-idcf';
GRANT ALL PRIVILEGES ON DATABASE swe_idcc_idcf_tasks TO swe_idcc_idcf_server;
CREATE DATABASE swe_btcc_tasks;
CREATE USER swe_btcc_server WITH ENCRYPTED PASSWORD 'swe-btcc';
GRANT ALL PRIVILEGES ON DATABASE swe_btcc_tasks TO swe_btcc_server;
CREATE DATABASE cse_valid_d2cc_tasks;
CREATE USER cse_valid_d2cc_server WITH ENCRYPTED PASSWORD 'cse-valid-d2cc';
GRANT ALL PRIVILEGES ON DATABASE cse_valid_d2cc_tasks TO cse_valid_d2cc_server;
CREATE DATABASE cse_valid_idcc_tasks;
CREATE USER cse_valid_idcc_server WITH ENCRYPTED PASSWORD 'cse-valid-idcc';
GRANT ALL PRIVILEGES ON DATABASE cse_valid_idcc_tasks TO cse_valid_idcc_server;
CREATE DATABASE cse_import_ec_idcc_tasks;
CREATE USER cse_import_ec_idcc_server WITH ENCRYPTED PASSWORD 'cse-import-ec-idcc';
GRANT ALL PRIVILEGES ON DATABASE cse_import_ec_idcc_tasks TO cse_import_ec_idcc_server;
CREATE DATABASE cse_import_ec_d2cc_tasks;
CREATE USER cse_import_ec_d2cc_server WITH ENCRYPTED PASSWORD 'cse-import-ec-d2cc';
GRANT ALL PRIVILEGES ON DATABASE cse_import_ec_d2cc_tasks TO cse_import_ec_d2cc_server;
CREATE DATABASE core_cc_tasks;
CREATE USER core_cc_server WITH ENCRYPTED PASSWORD 'core-cc';
GRANT ALL PRIVILEGES ON DATABASE core_cc_tasks TO core_cc_server;


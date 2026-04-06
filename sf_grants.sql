-- RAW READ
GRANT USAGE ON DATABASE {{ sf_db }} TO ROLE AR_{{ env }}_SF_RAW_READ;
GRANT USAGE ON SCHEMA {{ sf_db }}.RAW TO ROLE AR_{{ env }}_SF_RAW_READ;
GRANT SELECT ON ALL TABLES IN SCHEMA {{ sf_db }}.RAW TO ROLE AR_{{ env }}_SF_RAW_READ;
 
-- RAW WRITE inherits READ (because if you can write, you can read)
GRANT ROLE AR_{{ env }}_SF_RAW_READ TO ROLE AR_{{ env }}_SF_RAW_WRITE;
GRANT CREATE TABLE ON SCHEMA {{ sf_db }}.RAW TO ROLE AR_{{ env }}_SF_RAW_WRITE;
GRANT INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA {{ sf_db }}.RAW
    TO ROLE AR_{{ env }}_SF_RAW_WRITE;
 
-- ... same pattern for TRANSFORM and REPORTING ...
 
-- FUNCTIONAL ROLES ; the actual wiring
-- INGEST: writes to RAW, reads TRANSFORM (to check dependencies)
GRANT ROLE AR_{{ env }}_SF_RAW_WRITE       TO ROLE FR_{{ env }}_SF_INGEST;
GRANT ROLE AR_{{ env }}_SF_TRANSFORM_READ  TO ROLE FR_{{ env }}_SF_INGEST;
 
-- TRANSFORM: reads RAW, writes to TRANSFORM
GRANT ROLE AR_{{ env }}_SF_RAW_READ        TO ROLE FR_{{ env }}_SF_TRANSFORM;
GRANT ROLE AR_{{ env }}_SF_TRANSFORM_WRITE TO ROLE FR_{{ env }}_SF_TRANSFORM;
 
-- REPORTING: reads TRANSFORM, writes to REPORTING
GRANT ROLE AR_{{ env }}_SF_TRANSFORM_READ  TO ROLE FR_{{ env }}_SF_REPORTING;
GRANT ROLE AR_{{ env }}_SF_REPORTING_WRITE TO ROLE FR_{{ env }}_SF_REPORTING;
 
-- All functional roles roll up to DCM_ADMIN (so we don't lock ourselves out)
GRANT ROLE FR_{{ env }}_SF_INGEST    TO ROLE DCM_ADMIN;
GRANT ROLE FR_{{ env }}_SF_TRANSFORM TO ROLE DCM_ADMIN;
GRANT ROLE FR_{{ env }}_SF_REPORTING TO ROLE DCM_ADMIN;

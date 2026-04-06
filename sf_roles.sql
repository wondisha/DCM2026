-- Access roles ; per-schema READ and WRITE (the key cards)
DEFINE ROLE AR_{{ env }}_SF_RAW_READ;
DEFINE ROLE AR_{{ env }}_SF_RAW_WRITE;
DEFINE ROLE AR_{{ env }}_SF_TRANSFORM_READ;
DEFINE ROLE AR_{{ env }}_SF_TRANSFORM_WRITE;
DEFINE ROLE AR_{{ env }}_SF_REPORTING_READ;
DEFINE ROLE AR_{{ env }}_SF_REPORTING_WRITE;
 
-- Functional roles ; business function (the job titles)
DEFINE ROLE FR_{{ env }}_SF_INGEST;
DEFINE ROLE FR_{{ env }}_SF_TRANSFORM;
DEFINE ROLE FR_{{ env }}_SF_REPORTING;

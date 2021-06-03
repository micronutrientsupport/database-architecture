CREATE TABLE survey (
    id                        integer primary key generated by default as IDENTITY
    , name                    text
    , publication_date        date
    , surveying_date_start    date
    , surveying_date_end      date
    , geometry                geometry(MultiPolygon,4326)
    , geonetwork_uuid         text
    , survey_weight_factor    integer
    , notes                   text
);

COMMENT ON TABLE survey IS 'Surveys that have been carried out and collected data from households on things including the households (or the individuals therein) food consumption';
COMMENT ON COLUMN survey.name                  IS 'The name of the survey';
COMMENT ON COLUMN survey.publication_date      IS 'The date when the survey was published';
COMMENT ON COLUMN survey.surveying_date_start  IS 'The date when surveying and interviewing started';
COMMENT ON COLUMN survey.surveying_date_end    IS 'The date when no further interviews took place';
COMMENT ON COLUMN survey.geometry              IS 'The area covered by the survey; all households interviewed by the survey should fall into this area';
COMMENT ON COLUMN survey.geonetwork_uuid       IS 'a UUID for Geonetwork. See https://geonetwork-opensource.org/ for further info';
COMMENT ON COLUMN survey.survey_weight_factor  IS 'The factor survey weightings have been scaled by'
COMMENT ON COLUMN survey.notes                 IS 'a generic text field for notes about a survey. Can include such as: Whether biomarker measurements were taken from blood plasma or blood serum';


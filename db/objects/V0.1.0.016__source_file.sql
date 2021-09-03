CREATE TABLE source_file (
      file_name            text primary key
    , created_by           text
    , created_date         date
    , notes                text
);
COMMENT ON TABLE source_file                 IS 'The source file from which data has been loaded or imported into the database. ';
COMMENT ON COLUMN source_file.file_name      IS 'The name of the file including file type/extension';
COMMENT ON COLUMN source_file.created_by     IS 'Name of the person or organisation responsible for creating the file';
COMMENT ON COLUMN source_file.notes          IS 'Notes about file prearation, considerations, assumptions etc. might include notes about which data were excluded from the file, and why';

-- Cleanup 
DROP TABLE nfl.pbp.data;

-- Install ATTACH_FROM_CSV_DIR
DROP PROCEDURE ATTACH_FROM_CSV_DIR;
CREATE PROCEDURE ATTACH_FROM_CSV_DIR(IN table_name VARCHAR, IN file_directory VARCHAR, IN file_starts_with VARCHAR, IN file_extension VARCHAR := 'csv', IN delimiter VARCHAR, IN new_line VARCHAR, IN escape_character VARCHAR := null, IN skip_rows VARCHAR := 1, IN primary_key_columns ANY := null){
    FOREACH( VARCHAR _file IN FILE_DIRLIST(file_directory,1) ) DO{
        IF(REGEXP_MATCH( LCASE(file_starts_with),LCASE(_file) ) AND REGEXP_MATCH(LCASE(CONCAT('.',file_extension)),LCASE(_file))){
            ATTACH_FROM_CSV(table_name,CONCAT(file_directory,_file),delimiter,new_line,escape_character,skip_rows,primary_key_columns);
        }
         ELSE IF(file_starts_with := null AND CONTAINS(LCASE(_file), LCASE(CONCAT('.',file_extension)))){
             ATTACH_FROM_CSV(table_name,CONCAT(file_directory,_file),delimiter,new_line,escape_character,skip_rows,primary_key_columns);
         }
        RETURN 0;
    };
    RETURN 1;
};

-- Attach all tables to nfl.pbp.data
SELECT ATTACH_FROM_CSV_DIR('nfl.pbp.data','nfl-kg/data/','pbp-','csv',',','\n',null,1,VECTOR(1,2,3,4,5,6,7,8,9,10));
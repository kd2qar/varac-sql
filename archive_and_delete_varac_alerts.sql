/*
Archive and delete alerts in VARAC
Open the VARAC database in sqlite3 client or other client such as HeidiSQL
Run this querey agains the database to archive and delete the alserts in bulk
This is mainly in preparation for the MDC Digital EMCOMM exercises to clear out kruft
from previous exercises

Note: 'deleted' alerts in VARAC are only marked 'is_deleted' and are not actually removed from the 
		database. They can be recovered by toggling the is_deleted field

Folder IDs:
	1: Incomming
	2: Archived
	3: Sent

Note: This works with VARAC database versions 18-25 YMMV

Use this at your own risk
** Wear a Helmet **
*/

SELECT IIF( ABS(parameter_value) >= 18 AND ABS(parameter_value) <= 25,'YES','NO'+ ABS(-9223372036854775808)) AS `Validated Version` 
		FROM parameter WHERE parameter_name = 'db_version' LIMIT 1; -- Intentionally throws an error if version is out of range

UPDATE alert SET is_deleted = 1, read_status = 1, folder_id = 2 WHERE folder_id = 1;
UPDATE alert SET is_deleted = 1 WHERE folder_id = 3;
UPDATE alert SET is_deleted = 1, read_status = 1 WHERE folder_id = 2 AND is_deleted = 0;

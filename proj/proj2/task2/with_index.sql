SET @start_time_with_index = (SELECT MICROSECOND(NOW(4)));

SELECT * FROM ACCOUNT547 WHERE account_number = 'A-11451';

SET @end_time_with_index = (SELECT MICROSECOND(NOW(4)));

SELECT @end_time_with_index - @start_time_with_index AS with_index_query_duration_microseconds;
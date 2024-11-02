SET @start_time_no_index = (SELECT MICROSECOND(NOW(4)));

SELECT * FROM ACCOUNT547 WHERE account_number = 'A-11451';

SET @end_time_no_index = (SELECT MICROSECOND(NOW(4)));

SELECT @end_time_no_index - @start_time_no_index AS no_index_query_duration_microseconds;
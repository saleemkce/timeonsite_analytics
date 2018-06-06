/**
 * tos_ten_big_sessions_duration.sql
 *
 * Find 10 large sessions - timeonsite occured in your application
 *
 * Dependency: 'TOS_GET_DURATION' - check tos_get_duration.sql
 */

SELECT 
  TOS_GET_DURATION(max_timeonsite) as 'Session Duration', 
  tos_session_key 
FROM 
  (
    SELECT 
      MAX(timeonsite) AS max_timeonsite, 
      tos_session_key 
    FROM 
      tos 
    GROUP BY 
      tos_session_key 
    ORDER BY 
      max_timeonsite DESC 
    LIMIT 
      10
  ) timeonsite_large_sessions;


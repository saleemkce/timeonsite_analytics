/**
 * tos_large_session_detailed_stats.sql
 *
 * Find detailed stats of large timeonsite session occured in application
 * 
 */

SELECT 
  * 
FROM 
  tos 
WHERE 
  tos_session_key = (
    SELECT 
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
          1
      ) app_large_session
  ) 
ORDER BY 
  timeonsite DESC;

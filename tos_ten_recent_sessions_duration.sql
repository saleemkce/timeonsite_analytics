/**
 * tos_ten_recent_sessions_duration.sql
 *
 * Find recent 10 sessions time on site
 *
 * Dependency: 'TOS_GET_DURATION' - check tos_get_duration.sql
 */

SELECT 
  tos_session_key, 
  entry_time, 
  TOS_GET_DURATION(max_timeonsite) AS 'Time Spent - Duration' 
FROM 
  (
    SELECT 
      MAX(timeonsite) AS max_timeonsite, 
      entry_time, 
      tos_session_key 
    FROM 
      tos 
    WHERE 
      tos_session_key IN (
        SELECT 
          * 
        FROM 
          (
            SELECT 
              tos_session_key 
            FROM 
              tos 
            GROUP BY 
              tos_session_key 
            ORDER BY 
              entry_time DESC 
            LIMIT 
              10
          ) AS recent_ten_sessions
      ) 
    GROUP BY 
      tos_session_key
      ORDER BY entry_time DESC
  ) AS recent_entries;


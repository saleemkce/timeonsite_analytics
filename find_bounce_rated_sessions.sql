/**
 * find_bounce_rated_sessions.sql
 *
 * Find bounce rated user sessions or single pageview sessions.
 * 
 */

select 
  * 
from 
  (
    SELECT 
      tos_session_key, 
      tos_id, 
      count(tos_id) as tos_id_count, 
      (
        SELECT 
          count(*) 
        FROM 
          tos AS j2 
        WHERE 
          j1.tos_session_key = j2.tos_session_key
      ) AS tos_session_key_count 
    FROM 
      tos AS j1 
    GROUP BY 
      tos_session_key, 
      tos_id
  ) AS fullSql 
where 
  fullSql.tos_id_count = 1 
  AND fullSql.tos_session_key_count = 1

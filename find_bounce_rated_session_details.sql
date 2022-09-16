/**
 * find_bounce_rated_session_details.sql
 *
 * Find bounce rated user sessions' details like page accessed, entry_time, exit_time and stay time 
 * for finding new and existing user behaviour for single-page visits.
 * 
 */
 
 select 
  tos_session_key, 
  title as pageTitle, 
  URL as pageUrl, 
  entry_time, 
  exit_time, 
  timeonsite_by_duration, 
  1 as 'pageviews', 
  True as 'Bounce_rated_session' 
from 
  tos 
where 
  tos_session_key IN (
    select 
      tos_session_key 
    from 
      (
        SELECT 
          *, 
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
  ) 
order by 
  entry_time desc

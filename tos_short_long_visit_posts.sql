/**
 * tos_short_long_visit_posts.sql
 *
 * Find each post by short and long page visit duration
 */

SELECT 
  title, 
  TOS_GET_DURATION(short_visit) AS 'Short Visit', 
  TOS_GET_DURATION(long_visit) AS 'Long Visit' 
FROM 
  (
    SELECT 
      title, 
      MIN(timeonpage) AS 'short_visit', 
      MAX(timeonpage) AS 'long_visit' 
    FROM 
      tos 
    GROUP BY 
      title
  ) AS short_long_visits_by_title;


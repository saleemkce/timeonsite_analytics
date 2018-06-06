/**
 * tos_time_spent_by_user_type.sql
 *
 * Find time spent duration by user type - anonymous/authenticated; time spent bebaviour by user type
 *
 * Dependency: 'TOS_GET_DURATION' - check tos_get_duration.sql
 * 
 */

SELECT 
  Type, 
  Pageviews, 
  TOS_GET_DURATION(total_time_spent) AS 'Time Spent - Duration' 
FROM 
  (
    SELECT 
      SUM(timeonpage) AS total_time_spent, 
      COUNT(*) AS 'pageviews', 
      'Anonymous' AS 'Type' 
    FROM 
      tos 
    WHERE 
      tos_user_id = 'anonymous' 
    UNION 
    SELECT 
      SUM(timeonpage) AS total_time_spent, 
      COUNT(*) AS 'pageviews', 
      'Authenticated' AS 'Type' 
    FROM 
      tos 
    WHERE 
      tos_user_id != 'anonymous'
  ) AS user_type_timeonsite_reporting;

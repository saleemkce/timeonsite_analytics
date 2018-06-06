/**
 * tos_single_post_pageview_time_spent.sql
 *
 * Find single page by pageviews and overall time spent duration. It requires that you
 * pass title='some value' to filter desired post
 *
 * Dependency: 'TOS_GET_DURATION' - check tos_get_duration.sql
 * 
 */

SELECT 
  title as Title, 
  pageviews as 'Page Views', 
  TOS_GET_DURATION(time_spent) as 'Time Spent - Duration' 
from 
  (
    SELECT 
      title, 
      count(*) as pageviews, 
      sum(timeonpage) as time_spent 
    from 
      (
        SELECT 
          timeonpage, 
          title, 
          entry_time 
        from 
          tos 
        where 
          title = 'About'
      ) tas 
    group by 
      title
  ) as avg_time_spent;


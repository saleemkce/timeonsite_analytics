/**
 * tos_single_post_last_month_pageview_time_spent.sql
 *
 * Find single page by pageviews and overall time spent duration for last month. It computes last 
 * month dates automatically.
 * It requires that you pass title='some value' to filter desired post
 *
 * Dependency: 'TOS_GET_DURATION' - check tos_get_duration.sql
 * 
 * Main query has dependency 
 * on @last_month_start and @last_month_end variables to find first and last date of last month
 */

/* @last_month_start variable holds 1st date in last month e.g, 2015-10-01 from today */
SET @last_month_start = last_day(curdate() - INTERVAL 2 MONTH) + INTERVAL 1 day;

/* @last_month_end variable holds last date in last month e.g, 2015-10-31 from today */
SET @last_month_end = last_day(curdate() - INTERVAL 1 month);

/* Main query */
SELECT 
  title AS Title, 
  pageviews AS 'Page Views', 
  TOS_GET_DURATION(time_spent) AS 'Time Spent - Duration' 
FROM 
  (
    SELECT 
      title, 
      COUNT(*) AS pageviews, 
      SUM(timeonpage) AS time_spent 
    FROM 
      (
        SELECT 
          timeonpage, 
          title, 
          entry_time 
        FROM 
          tos 
        WHERE 
          title = 'About' 
          AND (
            entry_time >= @last_month_start && entry_time <= @last_month_end
          )
      ) AS timeonsite_data 
    GROUP BY 
      title
  ) AS avg_time_spent_by_title;

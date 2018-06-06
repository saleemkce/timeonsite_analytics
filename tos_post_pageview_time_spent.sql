/**
 * tos_post_pageview_time_spent.sql
 * 
 * Find each page by pageviews and overall time spent duration. Main query has dependency 
 * on @posts_order to order recent post visits
 *
 * Dependency: 'TOS_GET_DURATION' - check tos_get_duration.sql
 */

/* Find recent pages/posts by order and concatenate as comma-separated string */
SET 
  @posts_order = (
    SELECT 
      GROUP_CONCAT(DISTINCT title) 
    FROM 
      (
        SELECT 
          DISTINCT title, 
          entry_time 
        FROM 
          tos 
        ORDER BY 
          entry_time DESC
      ) AS recent_posts
  );

/**
 * Main query
 * Find each page by pageviews and overall time spent duration
 */
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
          title IN (
            SELECT 
              * 
            FROM 
              (
                SELECT 
                  DISTINCT title 
                FROM 
                  (
                    SELECT 
                      DISTINCT title, 
                      entry_time 
                    FROM 
                      tos 
                    ORDER BY 
                      entry_time DESC
                  ) AS recent_posts
              ) AS posts_ordered
          )
      ) AS posts_info 
    GROUP BY 
      title 
    ORDER BY 
      FIND_IN_SET(title, @posts_order)
  ) AS avg_time_spent;

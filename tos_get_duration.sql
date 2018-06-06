/**
 * tos_get_duration.sql
 *
 * Given time unit in seconds, it converts to more readable format
 *
 * Eg. TOS_GET_DURATION(72) => 00d 0:1:12
 */

DROP FUNCTION IF EXISTS TOS_GET_DURATION;
DELIMITER $$
CREATE FUNCTION TOS_GET_DURATION(seconds INT) 
  RETURNS VARCHAR(16) 
BEGIN
  RETURN CONCAT(LPAD(FLOOR(HOUR(SEC_TO_TIME(seconds)) / 24), 2, 0), ' days ',TIME_FORMAT(SEC_TO_TIME(seconds % (24 * 3600)), '%H:%i:%s'));
END; 
$$
DELIMITER;

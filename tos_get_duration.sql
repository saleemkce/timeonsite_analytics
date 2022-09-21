/**
 * tos_get_duration.sql
 *
 * Given time unit in seconds, it converts to more readable format
 *
 * Eg. SELECT TOS_GET_DURATION(72) => 00d 0:1:12
 */


/**
 * MariaDB version(s)
 */
DROP FUNCTION IF EXISTS TOS_GET_DURATION;
CREATE FUNCTION TOS_GET_DURATION(seconds INT) 
  RETURNS VARCHAR(16)
  RETURN CONCAT(LPAD(FLOOR(HOUR(SEC_TO_TIME(seconds)) / 24), 2, 0), ' days ',TIME_FORMAT(SEC_TO_TIME(seconds % (24 * 3600)), '%H:%i:%s'));


/**
 * MySQL version(s)
 * requires "DETERMINISTIC" keyword in recent versions.
 */
DROP FUNCTION IF EXISTS TOS_GET_DURATION;
CREATE FUNCTION TOS_GET_DURATION(seconds INT) 
  RETURNS VARCHAR(16) DETERMINISTIC
  RETURN CONCAT(LPAD(FLOOR(HOUR(SEC_TO_TIME(seconds)) / 24), 2, 0), ' days ',TIME_FORMAT(SEC_TO_TIME(seconds % (24 * 3600)), '%H:%i:%s'));
  

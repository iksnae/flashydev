<?php
require_once("db.inc.php");
// validate the provided data
$who = $_POST['who'];
if ((!$who) || (strlen($who) < 2)) {
	echo "Error: invalid name '$who'";
	exit;
}
$comment = $_POST['comment'];
if ((!$comment) || (strlen($comment) < 2)) {
	echo "Error: invalid comment";
	exit;
}
$from = $_POST['from'];
$sql = "INSERT INTO Comments (who, fromURL, postedOn, comment) VALUES ('$who', '$from', NOW(), '$comment')";
$DB = new DB;
$result = $DB->QUERY($sql);
if ($result) echo "OK";
else echo "Error";
?>
<?php
require_once("db.inc.php");


$text_address = $_POST['text_address'];
$subject = "Text Confirmation";
$body = "Your subscription for Bootleg Comedy 'Question of the Day' has been confirmed.";
if ((!$text_address) || (strlen($text_address) < 2)) {
	echo "Error: invalid name '$text_address'";
	exit;
}

$sql = "INSERT INTO JOD_Phone_Subscribers ( text_address, date_added ) VALUES ('$text_address', UTC_TIMESTAMP())";
$DB = new DB;
$result = $DB->QUERY($sql);
if ($result) mail($text_address, $subject, $body, 'From: BootlegComedy');
else echo 'false';
?>
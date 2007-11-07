<?php
require_once("db.inc.php");


$email_address = $_POST['email_address'];
$subject = "Email Confirmation";
$body = "Your subscription for Bootleg Comedy 'Question of the Day' has been confirmed.";
if ((!$email_address) || (strlen($email_address) < 2)) {
	echo "Error: invalid name '$email_address'";
	exit;
}

$sql = "INSERT INTO JOD_Email_Subscribers ( email_address, date_added ) VALUES ('$email_address', UTC_TIMESTAMP())";
$DB = new DB;
$result = $DB->QUERY($sql);
if ($result) mail($email_address, $subject, $body, 'From: BootlegComedy');
else echo 'false';
?>
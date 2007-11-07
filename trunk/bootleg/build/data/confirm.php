<?php
require_once("db.inc.php");


$email_address = $_POST['email_address'];
$subject = "Email Confirmation";
$body = "Your Email subscription is confirmed.";

if ((!$email_address) || (strlen($email_address) < 2)) {
	echo "Error: invalid name '$email_address'";
	exit;
}

$sql = "INSERT INTO JOD_Email_Subscribers ( email_address, date_added ) VALUES ('$email_address', UTC_TIMESTAMP())";
$DB = new DB;

$result = $DB->QUERY($sql);
if ($result) {
	echo 'true';
	mail($email_address, $subject, $body);
}else{
	 echo 'false';
}

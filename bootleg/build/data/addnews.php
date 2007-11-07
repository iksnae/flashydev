<?php
require_once("db.inc.php");

$id = $_POST['id'];
$header = $_POST['header'];
$body = $_POST['body'];
$image = $_POST['image'];
if ((!$header) || (strlen($header) < 2)) {
	echo "Error: invalid name '$header'";
	exit;
}
if ((!$body) || (strlen($body) < 2)) {
	echo "Error: invalid body";
	exit;
}
$sql = "INSERT INTO News (id, header, body, image, date_added ) VALUES ('$id', '$header', '$body','$image', NOW())";
$DB = new DB;
$result = $DB->QUERY($sql);
if ($result) echo "OK";
else echo "Error";
?>
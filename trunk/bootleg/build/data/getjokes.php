<?php
require_once("db.inc.php");
$DB = new DB;
echo $DB->GetXML("SELECT * FROM Jokes ORDER BY date_added DESC");
?>
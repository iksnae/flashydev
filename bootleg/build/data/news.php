<?php
require_once("db.inc.php");
$DB = new DB;
echo $DB->GetXML("SELECT * FROM News ORDER BY date_added DESC");
?>
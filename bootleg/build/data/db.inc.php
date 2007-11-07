<?php
class DB {
	
	/*
	  Edited version of Luke's MySQL DB class (v.1.0.0)
	  Note - you will need to edit some properties below,
	  inserting your username and password, database name
	  and host (if not localHost).
	*/

    function DB() {
         $this->host = "localhost";    // EDIT THIS (eg. localHost)
         $this->db   = "BootlegComedy";            // EDIT THIS 
         $this->user = "mysqladmin";    // EDIT THIS
         $this->pass = "wehrmacht";  // EDIT THIS
         $this->link = mysql_connect($this->host, $this->user, $this->pass);
         if (!$this->link) die;
         mysql_select_db($this->db);
    }
	
	function GetArray($q='') {
		// return a recordset as a PHP array
		// returns an empty array if there is an error
		$errResult = array();
		if (!$q) return $errResult;
		$rs = mysql_query($q, $this->link);
		if(!$rs) return $errResult;
		if (mysql_num_rows($rs) > 0) {
			while ($a = mysql_fetch_assoc($rs)) $out[] = $a; 
			return $out;
		}
		return $errResult;
	}	 
		 
	
	function GetXML ($q='') {
		// return a recordset as XML (MANUALLY CONSTRUCTED)
		// returns an empty string if there is an error
		$errResult ="";
		if (!$q) return $errResult;
		$rs = mysql_query($q, $this->link);
		if(!$rs) return $errResult;
		$doc = "<?xml version=\"1.0\"?>";
		$doc .="<recordset>";
		while ($a = mysql_fetch_assoc($rs)) {
			$record = "";
			foreach ($a as $k => $v) {
				$v2 = $this->_xmlentities($v);
				$record .="<$k>$v2</$k>";
			}
			$doc .="<record>$record</record>";
		}
		$doc .= "</recordset>";
		return $doc;
	}
	
	/*
	function GetXML ($q='') {
		// return a recordset as XML (USING XML Extension for PHP 4.3)
		// returns an empty string if there is an error
		$errResult ="";
		if (!$q) return $errResult;
		$rs = mysql_query($q, $this->link);
		if(!$rs) return $errResult;
		if (mysql_num_rows($rs) > 0) {
			$doc = domxml_new_doc("1.0"); // new XML doc
			$root = $doc->add_root("recordset");
			while ($a = mysql_fetch_assoc($rs)) {
				$record = $root->new_child("record","");
				foreach ($a as $k => $v) $record->new_child("$k",htmlentities("$v", ENT_QUOTES));				
			}
			return $doc->dumpmem();
		}
		return $errResult;
	}	
	*/
		
	function Query($q='') {
		// Make a query, returning false if there is no result;
		if (!$q) return false;
		$result = mysql_query($q,$this->link);
		if(!$result) return false;
		return $result;
	}
	
	function GetInsertID () {
		return mysql_insert_id();
	}
	
	// PRIVATE ---------------------------------------------------------------------------------------
	
	function _xmlentities($string, $quote_style=ENT_QUOTES) {
		// function from au.php.net user comments
	   static $trans;
	   if (!isset($trans)) {
		   $trans = get_html_translation_table(HTML_ENTITIES, $quote_style);
		   foreach ($trans as $key => $value)
			   $trans[$key] = '&#'.ord($key).';';
		   // dont translate the '&' in case it is part of &xxx;
		   $trans[chr(38)] = '&';
	   }
	   // after the initial translation, _do_ map standalone '&' into '&#38;'
	   return preg_replace("/&(?![A-Za-z]{0,4}\w{2,3};|#[0-9]{2,3};)/","&#38;" , strtr($string, $trans));
	}

} 
?>

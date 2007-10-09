
String.prototype.searchreplace = function(find,replace) {
	var string=this
    var counter
	while (counter<string.length) {
		var start = string.indexOf(find, counter);
		if (start == -1) {
			break;
		} else {
			var before=string.substr(0,start)
			var after=string.substr(start+find.length,string.length)
			string=before+replace+after
			var counter=before.length+replace.length
					
		}
	}
	return string;
};
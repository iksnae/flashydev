/** * @author gregpymm */class com.continuityny.form.SubmitSearchForm {			private var result_lv:LoadVars;	private var submitListener:Object;	private var error_message:String; 		public function SubmitSearchForm( 	url:String,									send_vars:LoadVars,									method:String,									callback:Function, 									stripCharacters:Boolean									) {															trace("submitSearchForm");											/*				 * 				 * This is fairly speacialized for the USOC application				 * 				 * 				 */				    			    result_lv = new LoadVars();								result_lv.onData = function(src:String) {				   				       if(src == undefined || src == ""){				       					       		var stripped_src = src; 				       				       }else{				       					       					       	// remove tabs				       	 var stripped_src = src.split("\t").join(""); 				 			trace("escape:"+escape(src)+" ecaspe stripped_src:"+escape(stripped_src));				       	   				       	   // remove line-feeds				       	 stripped_src = stripped_src.split("\n").join("");				       	    				       	    // remove carriage returns				       	 stripped_src = stripped_src.split("\r").join("");				  				  	 	trace("escape stripped_src:"+escape(stripped_src));				       }				   				   				     				trace("onData:src"+stripped_src+" stripped_src.length:"+stripped_src.length+" result_lv.toString():"+this.toString());				       				       				       if(stripped_src.length <= 1){				        	// for 0/1 boolean response				        					        	if(stripped_src == 0 || stripped_src == ""){				        		callback("valid");				        	}else{				        		callback("invalid");				        	}				        					        				        }else if(stripped_src.length > 1){				        					        	if(stripped_src.charCodeAt(0) > 47 && stripped_src.charCodeAt(0) < 58){				        		trace("onData: Success:"+stripped_src);				        		callback("valid", stripped_src);				        	}else{				        		trace("onData: Error:"+stripped_src);				        		callback("invalid");				        	}				        					        }				    };			   					// valid - 0, number					// invalid - 1, string			    			    send_vars.sendAndLoad(url, result_lv, method);			  trace("send_vars:"+send_vars+" send_vars.toString()):"+send_vars.toString());			  			  // send_vars:support%5Faid=1&email%5Fmessage=do%20you%20also%20love%20lamp%3F&to%5Femail5=YOUR%20FRIEND%27S%20EMAIL%20ADDRESS&to%5Femail4=YOUR%20FRIEND%27S%20EMAIL%20ADDRESS&to%5Femail3=YOUR%20FRIEND%27S%20EMAIL%20ADDRESS&to%5Femail2=greg%40pymm%2Ecom&to%5Femail1=greg%40pymm%2Ecom&img%5Fnum=6&email=greg%40pymm%2Ecom&location=new%20york%20city&name=gregory%20p%2E&message=i%20love%20lamp&uid=4&avatar=sports%2Fsport%5F6%2Ejpg&avatar%5Fid=6&data=%5Bobject%20Object%5D&athlete%5Fid=1&icode=QFJ677&invited=true				}}
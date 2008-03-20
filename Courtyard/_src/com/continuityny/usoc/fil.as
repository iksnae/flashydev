/// FILLLLLLLLLLLLLLLLLLLERRRRRR //
	
			
		
		
		private function applyPerspective (	mc:MovieClip, 
											fd:Number, 
											coords:Object, 
											oScale:Number):Void {
		   
			//if(oScale == undefined){ originScale = 100;}else{ originScale = oScale;}
			
			var originScale:Number = oScale!=undefined?oScale:100;
			
			// focalDistance = 600;        //calculate perspective ratio
			var p = fd/coords.z;
			// trace(mc._name+" z: "+mc.getDepth()+" perspective: "+Perspective.perspective);
			mc._x =  coords.x * p;    //apply perspective ratio to _x, _y, _xscale & _yscale
			mc._y = -coords.y * p;
			
			mc._xscale = mc._yscale = mc.os = (originScale*p);
			
///			mc.swapDepths(-coords.z);
			
			//mc._alpha = coords.z/4;
			
			mc._alpha = originScale*(p*1.5);
			mc.ao = mc._alpha;
			
			//if( mc._xscale < 33 ) mc._alpha =  100 - (mc._xscale * 3);
			//( mc._xscale >= 33 ) mc._alpha =  100;
			
			//var half = fd/2;
			
			//if( mc._xscale > 300 ) mc._alpha =  100 - (mc._xscale - 300);
			//if( mc._alpha  < 0 ) mc._alpha = 0;
		
		}
		
		
		
		private function r2d(r:Number):Number{
			return r*180/Math.PI;
		}
		
		private function d2r(d:Number):Number{
			return d*Math.PI/180;
		}
		
		private function updateLines(mca:MovieClip, mcb:MovieClip, id:Number):Void {
			// radius x/y
			
			trace("updateLines("+mca+", "+mcb+")");
			
			var rx:Number = 50;
			var ry:Number = 37.5; // 37.5 (but it offsets the crosshair)
		
			// WE HARD-ASSUME THE PARENTS ARE THE SAME!!!!
			var space:MovieClip = mca._parent;
			var spaceScale:Number = mca._parent._xscale/100;
			//trace("SPACESCALE: "+spaceScale);
			
			// distances
			var xd:Number = mca._x - mcb._x;
			var yd:Number = mca._y - mcb._y;
			
			// hypotenuse distance
			var pd:Number = Math.sqrt(Math.pow(xd,2)+Math.pow(yd,2));
			
			//trace("updateLines: XD: "+xd+", YD: "+yd+", POINT DISTANCE: "+pd);
			
			// angle 1, at point a to y axis
			var a1:Number = _r.r2d(Math.asin(xd/pd));
			
			var a1b:Number = _r.r2d(Math.asin(yd/pd));
			
			// 2 different ways of getting the other angle, at pt b to x axis
			var a2a:Number = -90-a1;
			var a2b:Number = _r.r2d(Math.asin(yd/pd));
			
			//trace("A1: "+a1);
			
			//trace("A2a: "+a2a+", A2b: "+a2b);
			
			// because angles are derived against different axes, have to be handled diff.
			// fix by deriving a1 against x axis
			
			if(xd>0){
				var ra2:Number = -(mcb._rotation-a2b);
			}else{
				var ra2:Number = 180 - (mcb._rotation+a2b);
			}
			
			if(yd>0){
				var ra1:Number = -90 - (mca._rotation+a1);
			}else{
				var ra1:Number = 90 - (mca._rotation-a1);
			}
			
			//mca.line._rotation = ra1;
			//mcb.line._rotation = ra2;
			//mca.axis._visible = 
			//mcb.axis._visible = 
			//mca.line._visible = 
			//mcb.line._visible = false;
			
			var ra_plus:Number = 8; // what the hell IS this number?
			var ra1plus:Number = ra1+ra_plus*Math.sin((Math.PI*ra1)/90);
			var ra2plus:Number = ra2+ra_plus*Math.sin((Math.PI*ra2)/90);
			
			mca["xmc"+id]._x = rx * Math.cos(_r.d2r(ra1plus));
			mca["xmc"+id]._y = ry * Math.sin(_r.d2r(ra1plus));
			
			mcb.xmc._x = rx * Math.cos(_r.d2r(ra2plus));
			mcb.xmc._y = ry * Math.sin(_r.d2r(ra2plus));
			
			var xha:Number = Math.sqrt(Math.pow(mca["xmc"+id]._x,2)+Math.pow(mca["xmc"+id]._y,2));
			var xra:Number = _r.r2d(Math.asin(mca["xmc"+id]._y/xha));
			
			//trace("XRA: "+xra+", RA1: "+ra1);
			
			//mca.xmc._rotation = -mca._rotation+45;
			//mcb.xmc._rotation = -mcb._rotation+45;
			
			//lines.moveTo(mca._x-mca.xmc._x,mca._y+mca.xmc._y);
			//lines.lineTo(mcb._x-mcb.xmc._x,mcb._y+mcb.xmc._y);
			
			var lines:MovieClip = _r.space_mc.bg;
			
			// var pd:Number = Math.sqrt(Math.pow(xd,2)+Math.pow(yd,2));
			
			// begin copout l2g stuff
			var pa:Object = {x:0,y:0};
			var pb:Object = {x:0,y:0};
			
			mca["xmc"+id].localToGlobal(pa);
			mcb.xmc.localToGlobal(pb); 
			
			mca["xmc"+id]._alpha = 
			mcb.xmc._alpha = 100;
		
			//lines.clear();
			
			// the only time spaceScale SHOULD be applied
			
			lines.lineStyle(6,0xffffff); // white backing
			lines.moveTo((pa.x-space._x)/spaceScale, (pa.y-space._y)/spaceScale);
			lines.lineTo((pb.x-space._x)/spaceScale, (pb.y-space._y)/spaceScale);
			
			lines.lineStyle(2,0x336699); // blue topline
			lines.moveTo((pa.x-space._x)/spaceScale, (pa.y-space._y)/spaceScale);
			lines.lineTo((pb.x-space._x)/spaceScale, (pb.y-space._y)/spaceScale);
			
		}
		
		
		
		private function handleChain(mc:MovieClip):Void {
			//trace("handleChain("+mc+")");
		
			var c:Array = _r.chain.slice(0);
			//var tc:Array = [];
		
			for(var i:Number = 0; i<c.length; i++){
				if(mc==c[i]){
					var mcix:Number = i;
				}
				trace("handleChain -- "+i+": "+c[i]);
			}
			
			if(mcix!=undefined){
				trace("handleChain MCIX of "+mc+" = "+mcix);
				var xc:Array = c.slice(mcix);
				_r.undrawChain(xc);
				c.splice(mcix);
		
			}else{
				trace("handleChain "+mc+" not in chain ");
				//c = [];
			}
			
			c[c.length] = mc;
			
			for(var i:Number = 0; i<c.length; i++){
				if(mc==c[i]){
					var mcix:Number = i;
				}
				//trace("handleChain --2 "+i+": "+c[i]);
			}
			
			// replace main chain with current chain
			_r.chain = [];
			_r.chain = c.slice(0);
			
			// pop all possible children of last element of chain into temp chain for bounds
			//_r.tempChain = [];
			//_r.tempChain = tc.slice(0);
			// moved to getSetBounds
		
		}
		
		private function redrawChain():Void {
			_r.space_mc.bg.clear();
			if(_r.chain.length>0){
				for(var i:Number = 0; i<_r.chain.length-1; i++){
					_r.updateLines(_r.chain[i], _r.chain[i+1], 0);
				}
			}
		}
		
		// removes artifacts of belonging from trunc'd members of chain
		private function undrawChain(xc:Array):Void {
			for(var i:Number = 0; i<xc.length; i++){
				var ti:MovieClip = xc[i];
				_r.undrawSingle(ti);
			}
		}
		
		private function undrawSingle(ti:MovieClip):Void {
			
			//ti._alpha = ti.ao;
			
			ti.hit._alpha = 0;
			//ti.hit._visible = false;
			
			// hide umbilical up
			ti.xmc._alpha = 0;
			
			// hide umbilicals down
			for(var d:Number=0; d<5; d++){
				ti["xmc"+d]._alpha = 0;
			}
			
			for(var k:Number = 0; k<ti.kids.length; k++){
				ti.kids[k]._alpha = ti.kids[k].ao;
				ti.kids[k].hit._alpha = 0;
				//ti.kids[k].hit._visible = false;
				ti.kids[k].xmc._alpha = 0;
				
			}
		}
		
		private function getSetBounds():Void {
			// get area used by current chain
			// todo: add children of last chain link to expected bounds
			var minx:Number = 0;
			var maxx:Number = 0;
			var miny:Number = 0;
			var maxy:Number = 0;
		
			var tDuration:Number = .375;
			var tType:String = "easeInOutSine";
			var boundsPadding:Number = 60;
			var xPadWindow:Number = 300;
			
			for(var i:Number = 0; i<_r.chain.length; i++){
				minx = Math.min(minx, _r.chain[i]._x);
				maxx = Math.max(maxx, _r.chain[i]._x);
				miny = Math.min(miny, _r.chain[i]._y);
				maxy = Math.max(maxy, _r.chain[i]._y);
			}
			
			// extra for last element childrens
			
			var leMC:MovieClip = _r.chain[_r.chain.length-1];
			var space:MovieClip = leMC._parent;
			var leRow:Number = parseInt(leMC._name.split("_")[1]);
			var leCol:Number = parseInt(leMC._name.split("_")[2]);
			
			var leKids:Array = [];
			//trace("LAST ELEMENT: "+leMC+", row:"+leRow+", col:"+leCol);
			
			var stagger:Boolean = leRow%2==0?false:true;
		
			for(var hand:Number = 0; hand<_r.indexVectors.length; hand++){
				for(var finger:Number = 0; finger<_r.indexVectors[hand].length; finger++){
					var plus:Number = stagger==true&&_r.indexVectors[hand][finger][2]==true?1:0;
					var cr:Number = leRow+parseInt(_r.indexVectors[hand][finger][1]);
					var cc:Number = leCol+parseInt(_r.indexVectors[hand][finger][0])+plus;
					leKids[leKids.length] = space["b_"+cr+"_"+cc];
				}
			}
			
			//trace("OLD BOUNDS: "+minx+", "+miny+" -> "+maxx+", "+maxy);
			
			for(var i:Number = 0; i<leKids.length; i++){
				//trace("leKids["+i+"]: "+leKids[i]);
				minx = Math.min(minx, leKids[i]._x);
				maxx = Math.max(maxx, leKids[i]._x);
				miny = Math.min(miny, leKids[i]._y);
				maxy = Math.max(maxy, leKids[i]._y);
			}
			
			trace("NEW BOUNDS: "+minx+", "+miny+" -> "+maxx+", "+maxy);
			
			var bxs:Number = maxx-minx+boundsPadding*2+xPadWindow;
			var bys:Number = maxy-miny+boundsPadding*2;
			
			trace("BOUNDS SIZE: W: "+bxs+", H: "+bys);
			
			var vxs:Number = (975/bxs) * 100;
			var vys:Number = (610/bys) * 100;
			
			trace("BOUNDS SCALES: X: "+vxs+", Y: "+vys);
			
			var vs:Number = Math.min(vxs,vys);
			
			// set box around used area (later move camera)
			_r.space.bounds.slideTo(minx-boundsPadding,miny-boundsPadding,tDuration,tType);
			_r.space.bounds.xScaleTo(bxs,tDuration,tType);
			_r.space.bounds.yScaleTo(bys,tDuration,tType);
			
			_r.space.scaleTo(vs,tDuration*2,tType);
			_r.space.slideTo(-1*(minx-boundsPadding)*(vs/100)+xPadWindow,-1*(miny-boundsPadding)*(vs/100),tDuration,tType);
			
			
		}
		
		private function drawLinesFrom(mc:MovieClip):Void {
			
			if(mc!=_r.chain[_r.chain.length-1]){
				_r.undrawSingle(_r.chain[_r.chain.length-1]);
			}
			
			// handle chain first (add mc to chain if not there
			_r.handleChain(mc);
			
			_r.redrawChain();
			_r.getSetBounds();
			
			var space:MovieClip = mc._parent;
			var bg:MovieClip = space.bg;
			
			//bg.clear();
			bg.lineStyle(1,0xff0000);
			bg.moveTo(mc._x*(space._xscale/100),mc._y*(space._yscale/100));
			
			mc.hit._alpha = 100;
			mc.hit._visible = true;
			mc.scaleTo(mc.os*1.15,1,"easeOutElastic");
			
			var split:Array = mc._name.split("_");
			var row:Number = parseInt(split[1]);
			var col:Number = parseInt(split[2]);
			
			var varr:Array = _r.indexVectors.slice(0);
			
			var dirs:Array = varr[Math.floor(Math.random()*varr.length)];
			
			var stagger:Boolean = row%2==0?false:true;
			
			var kids:Array = [];
			
			for(var i:Number = 0; i<dirs.length; i++){
				var plus:Number = stagger==true&&dirs[i][2]==true?1:0;
				var tr:Number = row+dirs[i][1];
				var tc:Number = col+dirs[i][0]+plus;
				var tb:MovieClip = space["b_"+tr+"_"+tc];
				if(tb!=undefined){
					trace(tb);
					
					tb.enabled = true;
					
					tb.par = mc;
					kids.push(tb);
					
					tb.onRelease = function():Void{
						trace(this+"_________________________________________________");
					
						_r.drawLinesFrom(this);
						
						if(this!=_r.athlete_mc){
							_r.attachInfoWindow(this,"support_win",300);
						}
					};
					
					
					//tb.hit._x = 100;
					//tb.hit._alpha = 100;
					tb.hit.alphaTo(50,0.375,"easeOutSine");
					
					_r.updateLines(mc,tb, i);
					
				}else{
					trace("dang, we fell off the edge of grid: space.b_"+tr+"_"+tc+" is undefined");
				}
				
				//bg.lineTo(tb._x,tb._y);
				//bg.moveTo(mc._x,mc._y);
			}
			
			mc.kids = [];
			mc.kids = kids.slice(0);
			trace("ROW "+row+", COL "+col);
			
		}

		
		private function attachInfoWindow(node:MovieClip,winName:String,d:Number):Void {
			trace("attachInfoWindow("+node+")");
			var windowName:String = winName==undefined ? node._name : winName;
			var depth:Number = d==undefined ? 100 : d;
			var win:MovieClip = node._parent.messaging.attachMovie("_info_window_2",windowName,depth); //_universe_info_window_tmp
			win._x = node._x;
			win._y = node._y;
			
			// attach hax hax hax picture ball
			
			var pball:MovieClip = win.attachMovie("node_center","pic",200);
			pball.pic_holder.loadMovie("./supporters/supporter_0"+Math.round(Math.random()*3)+""+Math.round(Math.random()*9)+".jpg");
			
			//win._xscale = win._yscale = 100*(100/node._parent._xscale);
			
			trace("NEW WIN: "+win);
			
			//win.gotoAndPlay(2);
			
			// always flipped
			//if(node._parent._xmouse > 0){
				win.window_mc._xscale = -100;
		//		win.window_mc.gradient_mc._xscale = -10;  
				
				win.window_mc._x -= 2*win.window_mc._x;
				win.window_mc._x -= 2*win.window_mc.gradient_mc._x;
				
				win.header_txt._x -= 65+285;
				win.network_txt._x -= 65+285;
				win.body_txt._x -= 65+285;
				
				// buttons
				win.window_mc.bs._alpha = 0;
				win.window_mc.bs._x -= 275;
				
			//}
			
			_r.initWindow(win,35,200);
			_r.resizeWindow(win,270,200);
			
			win.onEnterFrame = function(){
				this._xscale = this._yscale = 100*(100/this._parent._parent._xscale);
			};
			
		}
		
		private function initWindow(par:MovieClip,w:Number, h:Number):Void {
			var ww = w;
			var wh = h;
			par.window_mc.butMask = new RoundWindow();
			par.window_mc.gradient_mc._width = ww;
			par.window_mc.gradient_mc._height = wh;
			par.window_mc.gradient_mc.setMask(par.window_mc.butMask.make(par.window_mc, 0xFF00FF, 0, 0, ww, wh, 15, 100));
			//par.window_mc.base_mc._xscale = -100;
		}
		
		private function resizeWindow(par:MovieClip, targetW:Number, targetH:Number) {
			par.window_mc.onEnterFrame = function() {
				trace("x");
				var currentW = this.gradient_mc._width;
				var currentH = this.gradient_mc._height;
				if ((currentW != targetW) || (currentH != targetH)) {
					var newW = Math.round((currentW-targetW)/2);
					this.gradient_mc._width -= newW;
					var newH = Math.round((currentH-targetH)/2);
					this.gradient_mc._height -= newH;
				} else {
					delete this.onEnterFrame;
				}
				this.gradient_mc.setMask(this.butMask.make(this, 0xFF00FF, 0, 0, this.gradient_mc._width, this.gradient_mc._height, 15, 100));
			};
		
		}
		
		/*
		sbg.onEnterFrame = function():Void {
			this.clear();
			this.lineStyle(1,0xff0000);
			var ba:MovieClip = this._parent["b"+Math.floor(Math.random()*100)];
			var bb:MovieClip = this._parent["b"+Math.floor(Math.random()*100)];
			trace("fdfff "+ba._x+", "+ba._y+" // "+bb._x+", "+bb._y);
			this.moveTo(ba._x,ba._y);
			this.lineTo(bb._x,bb._y);
		}
		*/
		
		
		
	private function initGalaxy(){
			
		var space:MovieClip = 	view.createEmptyMovieClip("space_mc",100);
		var sbg:MovieClip = 	space.createEmptyMovieClip("bg",12);
		
		
		
		var bounds:MovieClip = space.attachMovie("_box_ol", "bounds",12000);
		bounds._visible = false;
		// not as easy as scaling space because lines use positions IN space before drawing
		
		//space._xscale = space._yscale = 100;
		//space.scaleTo(200,15);
		//sbg._xscale = sbg._yscale = 100/(space._xscale/100);
		
		//bounds._visible = false;
		
		/*
		var smask:MovieClip = this.attachMovie("_box","space_mask",150);
		smask._xscale = Stage.width;
		smask._yscale = Stage.height;
		space.setMask(smask);
		*/
		
		// mask space to screen
		//space.setMask(_r.attachMovie("_box","space_mask",150,{_xscale:Stage.width, _yscale:Stage.height}));
		
		
		
		
		// center on stage
		space._x = 486;
		space._y = 305;
		
		//sbg._x = space._x - Stage.width + 3; // this +3 makes no sense, kthxbai
		//sbg._y = space._y - Stage.height;
		
		
		
		trace("X offset: "+x_offset+", Y offset: "+y_offset);
		
		
		
		
		
		
		//for(var i:Number = drawrows[0]; i<drawrows[1]; i++){
		for(var i:Number = 0; i < numrows; i++){
			
			// 20*Math.sin(((1/rows)/2)*i*Math.PI);
			// 300*Math.sin(((1/rows)/1)*i*Math.PI);
			
			var z:Number = z_offset+i*z_increment;
			var y:Number = y_offset+i*y_increment;
			
			var rxo:Number = i%2==0?0:x_stagger;
			
			var rrot:Number = 90 * (0.5 - 0.5*Math.sin(((1/numrows/2))*i*Math.PI));
			
			/*var dxn:Number = lx-fx;
			
			var dxr:Number = dxn/dx;
			
			trace((i-1)+") ROW LENGTH: "+dxn+", RATIO TO OLD ROW: "+dxr);
			
			var fx:Number = 0;
			var lx:Number = 0;
			var dx:Number = dxn;
			
			*/
			
		//	trace(rrot);
			
			for(var j:Number = 0; j < numcols; j++){
		
				var name_i:Number = drawrows[0]+i;
				var name_j:Number = drawcols[0]+j;
				
				var node:MovieClip = space.attachMovie("_circ2","b_"+name_i+"_"+name_j,100+cr);
		
				node.x = x_offset+j*x_increment+rxo;
				node.y = y;
				node.z = z;
				
				node.hit._alpha = 0;
				
				// adds a nice lens distortion but difficult to manage when changing scales
				// (because expects to apply tilt across full grid not visible portion)
				// also not reconfigured for function form of grid drawing
				node._rotation = rrot*Math.cos(((1/numcols))*j*Math.PI);
				
				//b.cross._visible = false;
				//b.cross._rotation = -3 * rrot*Math.cos(((1/cols))*j*Math.PI);
				
				_r.applyPerspective(node,focal,{x:node.x, y:node.y, z:node.z},node_oscale);
				
				/*if(j==0){
					fx = node._x;
				}else if(j==numcols-1){
					lx = node._x;
				}*/
		
				node.onRollOver = function(){
					
					if(this!=_r.athlete_mc){
						_r.attachInfoWindow(this,"support_win_roll",350);
					}
					
					//_root.haxPerspective(this, _root._xmouse, {x:this.x, y:this.y, z:this.z+_root._xmouse},9);
					//this._rotation+=0.5+Math.random()/2; // drunk
					//_r.applyPerspective(this,750,{x:this.x, y:this.y, z:this.z+Math.random()},this.os);
				};
				
				
				node.onRelease = function():Void {
					
					trace(this+"_________________________________________________");
					
					_r.drawLinesFrom(this);
					
					if(this!=_r.athlete_mc){
						_r.attachInfoWindow(this,"support_win",300);
					}
					
					
				};
				
				// not enabled until activated as child (abstract mode)
				node.enabled = false;
				
				
				trace("jjjjj:"+j+" iiiiii:"+i);
				// depth counter
				cr++;
			}
			
			
			
			
			
		}
		
		
		var space_front:MovieClip = space.createEmptyMovieClip("messaging",cr+100);
		
		
		
		athlete_mc = space["b_"+athletePosition[0]+"_"+athletePosition[1]];
		//athlete_mc.colorTo(0xff0000);
		
		trace("lucky athlete clip is : "+athlete_mc);
		athlete_mc.enabled = true;
		//athlete_mc.onRelease(); // hax! adds childs and makes bounds calculation possible
		
		// just makes atbhlete node initially a little bigger
		//athlete_mc._xscale = athlete_mc._yscale = athlete_mc.os*1.25;
		
		//attachInfoWindow(athlete_mc, "athlete_win", 200);
		
		
		
		
		} // end init
	
	
	// FILLLLEEERRRRREEERERERERERRER //
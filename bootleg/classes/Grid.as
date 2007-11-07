﻿import com.util.Proxy;import com.mosesSupposes.fuse.*;class Grid extends MovieClip {	public var GridArray:Array;	function Grid() {		init();	}	private function init() {				ZigoEngine.register(PennerEasing);			}	public function resetGrid(id:Number) {		trace('resetGrid: '+id)		for (var i = 0; i<GridArray.length; i++) {			if(id==GridArray[i].idNum){				ZigoEngine.doTween(GridArray[i].selectorBox,'_alpha,_xscale,_yscale',100,.6,'easeOutBack');							}else{				ZigoEngine.doTween(GridArray[i].selectorBox,'_alpha,_xscale,_yscale',0,.6,'easeOutBack');			}		}	}	public function populateGrid(arr:Array) {		trace('grid array: '+arr);		GridArray = new Array();		for (var i = 0; i<arr.length; i++) {			var block = attachMovie('GridBox', 'GridBox'+i, i);			block.idNum = i;			block._x = block._width*i;			block.title.text = arr[i].id;			GridArray.push(block);		}	}}
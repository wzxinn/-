function getStyle(obj,name){
		if(obj.currentStyle){
			return obj.currentStyle[name]
		}else{
			return getComputedStyle(obj,false)[name]
		}
	};

	/*move(div,'width',300,10,function(){
		move(div,'height',900,70);
	});
*/

	
	function move(obj,opt,timer,fn){
		clearInterval(obj.timer);
		var json = {};
		obj.cur = false;
		var arr = [];
		for(var i in opt){
			arr.push(i);
		};
		//alert(arr.length);
		obj.timer = setInterval(function(){
			//var p = []

			for(var i in opt){
				obj.cur = false;

				//json[i] = false;
				//obj[i] = false;
				var w = parseFloat(getStyle(obj,i));

			//	p.push(obj[i]);
				//100
				//console.log(w);

				//110
				var m = opt[i];

				
				var speed = (m-w)/7;
				speed = speed>0?Math.ceil(speed):Math.floor(speed);

				//console.log(speed + ',' +w)
				//(200 - 100)/10
				//200 - 110 /9
				//console.log(i)
				obj.style[i] = w+speed+'px';

				if(w == m){
					//marginLeft o
					//width x
					//height x
					//  
				//	obj.cur = true;

					json[i] = true;
					//console.log(json)

					//console.log(i)
					//json[i]=true;
					//obj[i] = true;
					//clearInterval(obj.timer);
					//fn && fn();
				}


			}

			var arr2 = [];
			for(var i in json){
				arr2.push(json);
			};


			if(arr.length == arr2.length){
				clearInterval(obj.timer);
				fn && fn();
			}
			//console.log(arr2.length)

		//	console.log(json);
			/*if(obj.cur==true){
				clearInterval(obj.timer);
				fn && fn()
			}*/


			//110
			//119


		},timer);

	}
	
	
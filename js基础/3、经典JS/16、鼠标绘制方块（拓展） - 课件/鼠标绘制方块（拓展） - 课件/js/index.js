container.onmousedown = function(e) {
	var ev = e || event;
	var div = document.createElement("div");
	var _top = ev.clientY - this.offsetTop;
	var _left = ev.clientX - this.offsetLeft;
	this.appendChild(div);
	document.onmousemove = function(e) {
		var ev = e || event;
		var _width = ev.clientX - container.offsetLeft - _left;
		var _height = ev.clientY - container.offsetTop - _top;			
		(_height < 0) ? (_height = -_height, div.style.top = "", div.style.bottom = container.offsetHeight - _top + "px", ((_height > _top) ? _height = _top - 4 : _height = _height)) : (div.style.bottom = "", div.style.top = _top + "px", ((_height > container.offsetHeight - _top) ? _height = container.offsetHeight - _top - 4 : _height = _height));
		(_width < 0) ? (_width = -_width, div.style.left = "", div.style.right = container.offsetWidth - _left + "px", ((_width > _left) ? _width = _left - 4 : _width = _width)) : (div.style.right = "", div.style.left = _left + "px", ((_width > container.offsetWidth - _left) ? _width = container.offsetWidth - _left - 4 : _width = _width));
		div.style.width = _width + "px";
		div.style.height = _height + "px";
	};
		document.onmouseup = function() {
			div.style.borderStyle = "solid";
			div.style.transition = ".7s";
			div.style.background = "rgba(" + (parseInt(Math.random() * 256)) + "," + (parseInt(Math.random() * 256)) + "," + (parseInt(Math.random() * 256)) + ",1)";
			document.onmousemove = document.onmouseup = null;
		};
		return false;
	}

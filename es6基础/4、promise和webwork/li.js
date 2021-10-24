this.onmessage=function(res){
    var data = res.data;
    var lastData=data.charAt(0).toUpperCase()+data.substring(1);
    this.postMessage(lastData);
}
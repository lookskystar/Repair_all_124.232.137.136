var Page = function(count,params){
	this.size=10;
	this.num=1;
	this.count=count;
	this.url;
	this.sumNum = function(){
		return Math.ceil(this.count/this.size);
	};
	this.params = {};
	this.first=function(){
		this.show(1);
	}
	this.last=function(){
		this.show(this.sumNum());
	}
	this.next=function() {
		this.show(this.num + 1);
	}
	this.prev=function() {
		this.show(this.num - 1);
	}
	this.show=function(num) {
		if(num>0&&num<=this.sumNum()){
			this.num = num;
			var args = {'pnum':(this.num-1)*this.size,'psize':this.size,'_temp':Math.random()};
			for(p in params){
				args[p] = params[p];
			}
			$.get(this.url,args,function(data){
				document.body.innerHTML = data;
			});
			delete args;
		}
	}
	this.reload=function(){
		this.show(1);
	}
	this.bindForm=function(id){
		$(function(){
			$('#'+id+' input[type=text]').each(function(i,input){
				if($(input).val()!=''){
					page.params[$(input).attr('name')] = $(input).val();
				}
			});
			$('#'+id+' input:checked').each(function(i,input){
				if($(input).val()!=''){
					page.params[$(input).attr('name')] = $(input).val();
				}
			});
			$('#'+id+' select').each(function(i,s){
				if($(s).find('option:selected').val()!=''){
					page.params[$(s).attr('name')] = $(s).find('option:selected').val();
				}
			});
			$('#'+id).bind('submit',function(f){
				for(var i=0;i<form.length;i++){
					if(form[i].value==''){
						$(form[i]).removeAttr('name');
					}
				}
			});
		});
	}
}
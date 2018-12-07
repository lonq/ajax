var lottery={
	index:0,		//当前转动到哪个位置
	count:0,		//总共有多少个位置
	timer:0,		//setTimeout的ID，用clearTimeout清除
	speed:200,		//初始转动速度
	times:0,		//转动次数
	cycle:30,		//转动基本次数：即至少需要转动多少次再进入抽奖环节
	prize:-1,		//中奖位置
	luckyTimes: 10,	//可抽奖次数
	//emptyIndex: 7,	//没有抽到奖
	init:function(id){
		if ($("#"+id).find(".lottery-unit").length>0) {
			$lottery = $("#"+id);
			$units = $lottery.find(".lottery-unit");
			this.obj = $lottery;
			this.count = $units.length;
			$lottery.find(".lottery-unit-"+this.index).addClass("active");
			$("#resultTimes").text(lottery.luckyTimes);
		};
	},
	roll:function(){
		var index = this.index;
		var count = this.count;
		var lottery = this.obj;
		$(lottery).find(".lottery-unit-"+index).removeClass("active");
		index += 1;
		if (index>count-1) {
			index = 0;
		};
		$(lottery).find(".lottery-unit-"+index).addClass("active");
		this.index=index;
		return false;
	},
	stop:function(index){
		this.prize=index;
		return false;
	}
};

function roll(){
	var startObj = $("#start"),
			curLuckyTimes = parseInt($("#resultTimes").text()) - 1;
	lottery.times += 1;
	lottery.roll();
	if (lottery.times > lottery.cycle+10 && lottery.prize==lottery.index) {
		clearTimeout(lottery.timer);
		lottery.prize=-1;
		lottery.times=0;
		click=false;
		startObj.find("a").attr("class", "end");
		$("#resultTimes").text(curLuckyTimes);
		//弹出模态框
		$(".modal-alert").modal("show");
	}else{
		if (lottery.times<lottery.cycle) {
			lottery.speed -= 10; //第一步，以速度10递减。
		}else if(lottery.times==lottery.cycle) { //第三步，当第cycle圈的时候，确定中奖位置。
			var index = Math.random()*(lottery.count)|0;
			lottery.prize = index;
		}else{
			if (lottery.times > lottery.cycle+10 && ((lottery.prize==0 && lottery.index==7) || lottery.prize==lottery.index+1)) { //第五步，大于cycle+10圈 且 同时满足中奖。迅速跳到中奖处。
				lottery.speed += 110;
			}else{ //第四步，在cycle至cycle+10，规则区间内，迅速依次序跳到获奖位置。
				lottery.speed += 20;
			}
		}
		if (lottery.speed<150) { //第二步，保证圈圈转够cycle圈，以速度150。
			lottery.speed=150;
		};
		//console.log(lottery.times+'^^^^^^'+lottery.speed+'^^^^^^^'+lottery.prize);
		lottery.timer = setTimeout(roll,lottery.speed);
		startObj.find("a").attr("class", "proceed");
	}
	return false;
}

var click=false;
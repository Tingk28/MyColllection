/*H14086030 郭庭維 第3次作業 4/26
H14086030 TingWeiKuo TheThird Homework 4/26*/
/*
    遊戲規則：
    只有 A+10點的牌叫blackjack，賠1.5x
    hit:當點數<21.時，可以抽一張牌
    stand(結束回合)：停止叫牌，莊家將開始開牌
    投降：當莊家非blackjack時才可以投降，返還一半的籌碼
    double:加倍下注，投入押注一倍的籌碼，並只能再抽一張牌

    split: 分牌，每局只能分牌一次，並且分牌後不得進行投降等動作，只能hit/stand/double

    本程式在 牌面>=21或double後會自動結算，原則上使用者不需要自行按stand
    按左上角籌碼五次可以進入cheat mode 將無條件發給莊家將獲勝or和局
    當牌小於兩副52*2張時，將洗牌

    結算table 將顯示前五張牌，以及該回合點數、勝負&和局&投降、結算後剩餘金錢、不同回合所下注之金額（若有分牌則分別顯示）、是否加倍下注（已包含在前述之"下注金額"）or balckjack
*/
cheat.addEventListener("click",function(){
    cheat_click++
    if(cheat_click>=5){
        alert("cheat start")
    }
})
start.addEventListener("click", function(){
    show_card_ui()//顯示遊戲介面UI
    place_bet()//開啟下注介面
    document.getElementById("bgm").play();
    document.getElementById("bgm").loop = true;
    //setTimeout(in_game, 100);
})
bet_btn.addEventListener("click",function(){//玩家準備下注
    money = document.getElementById("money");
    chip = parseInt(document.getElementById("bet").value);
    if (chip >money.innerText ){
        alert("下注金額過大");
    }
    else if (chip<0){
        alert("請輸入正整數");
    }
    else if (chip !== chip){
        alert("請輸入數字");
    }
    else{
        money.innerText-=chip;
        document.getElementById("place_bet_ui").style.display = "none";
        document.getElementById("dealer_bust").style.display = "none";
        document.getElementById("player_bust").style.display = "none";
        document.getElementById("stand").innerText = "stand";
        document.getElementById("money_on_table").children[1].innerText = chip;
        new_round(cards)
    }
})
hit.addEventListener("click",function(){// when player press "hit"
    document.getElementById("split").disabled = true//叫牌後不可分牌
    document.getElementById("double").disabled = true//叫牌後不可雙倍下注
    document.getElementById("surrender").disabled = true//叫牌後不得投降
    player = document.getElementById("player_card_block")
    index = deal(cards,false);//get a card
    player.cards.push(index);
    
    add_card(player,player.cards)//show card
    player_points=cards2point(player.cards);//update the points
    document.getElementById("player_points").innerHTML = "玩家：<br>Points = "+ player_points;
    if(player_points>=21){
        if(player_points>21){//如果爆牌
            document.getElementById("player_bust").style.display = "block";
        }
        document.getElementById("hit").disabled = true;
        setTimeout(function(){
            document.getElementById("stand").click();//按下stand 同時會更新"player_points2的狀態"
            console.log(document.getElementById("player_points2").innerHTML)
            if(document.getElementById("player_points2").innerHTML==""){//沒有split了
                document.getElementById("stand").disabled = true;
            }
            else{//還有Split
                document.getElementById("player_bust").style.display = "none";//隱藏爆牌提示
                document.getElementById("stand").disabled = false;//啟用Stand block
            }
        }, 1500);
    }
})
stand.addEventListener("click",function(){// when player press "stand"
    if(split_temp !=-1){//還有split
        //store the data
        if(cards2point(player.cards)==21&&player.cards.length==2){
            document.getElementById("player_points2").innerHTML = "分牌1：<br>Points = blackjack";//update the points
        }
        else{
            player_points=cards2point(player.cards);//calculate the points
            document.getElementById("player_points2").innerHTML = "分牌1：<br>Points = "+ player_points;//update the points
        }
        split_money = parseInt(money_on_table.innerText)
        split_card = player.cards
        if(special_event==1){//double
            money_on_table.innerText = parseInt(money_on_table.innerText)/2
        }
        prev_special_event = special_event
        special_event = 0;
        //get new card
        player.cards = [split_temp,deal(cards,false)];
        split_temp = -1;
        //update info
        add_card(player,player.cards)
        player_points=cards2point(player.cards);//calculate the points
        document.getElementById("player_points").innerHTML = "玩家：<br>Points = "+ player_points;//update the points

        //檢查按鈕區
        document.getElementById("player_bust").style.display = "none";//隱藏爆牌提示
        if(player_points==21){//disable all buttons
            special_event = 2
            document.getElementById("stand").innerText = "結束回合"
            document.getElementById("hit").disabled = true;
            document.getElementById("double").disabled = true;
            document.getElementById("split").disabled = true;
            document.getElementById("surrender").disabled = true;
            setTimeout(function(){
                document.getElementById("stand").click();
                if(cards2point(player.cards)!=21){
                    document.getElementById("stand").disabled = false;
                }
            },1500)
        }
        else{
            document.getElementById("hit").disabled = false;
            document.getElementById("stand").disabled = true;//不論如何先停用stand
            document.getElementById("split").disabled = true;
            document.getElementById("surrender").disabled = true;
            //檢查double
            if(parseInt(money.innerText)>=parseInt(money_on_table.innerText)){
                document.getElementById("double").disabled = false //若有足夠的錢可以雙倍下注
            }
            else{
                document.getElementById("double").disabled = true //若沒有足夠的錢可以雙倍下注
            }
            setTimeout(function(){//兩秒後啟用stand
                document.getElementById("stand").disabled = false;
            },2000)
        }
        
    }
    else{//沒有split了
        win_log = []//和局1、莊家2、玩家3、balckjack 4
        document.getElementById("hit").disabled = true;
        document.getElementById("stand").disabled = true;
        document.getElementById("double").disabled = true;
        document.getElementById("split").disabled = true;
        document.getElementById("surrender").disabled = true;
        dealer = document.getElementById("dealer_card_block")
        player = document.getElementById("player_card_block")
        dealer_points=cards2point(dealer.cards);//calculate the points
        dealer.children[0].children[0].style.opacity = "100%"
        document.getElementById("dealer_points").innerHTML = "莊家：<br>Points = "+ dealer_points;//update the points
        player_points=cards2point(player.cards);//calculate the points

        while(cards2point(dealer.cards)<17 || (cards2point(dealer.cards)<cards2point(player.cards)& cards2point(player.cards)<=21)){//莊家必須>=17 or 玩家的牌介於17-21間
            index = deal(cards,true);//get a card
            dealer.cards.push(index);
            
            add_card(dealer,dealer.cards)//show card
            dealer_points=cards2point(dealer.cards);//update the points
            document.getElementById("dealer_points").innerHTML = "莊家：<br>Points = "+ dealer_points;
            if(dealer_points>21){
                document.getElementById("dealer_bust").style.display = "block";
            }
        }
        temp_log.push(dealer.cards)//log加入莊家牌
        setTimeout(function(){
            while(player_points>0){
                money_on_table = document.getElementById("money_on_table").children[1];
                money = document.getElementById("money");
                if (player_points==21&&player.cards.length==2){//player blackjack
                    if(cards2point(dealer.cards)==21&&dealer.cards.length==2){//both blackjack
                        alert("和局")
                        win_log.push(1)
                        money.innerText = parseInt(money.innerText)+parseInt(money_on_table.innerText);
                    }
                    else{
                        alert("blackjack!")
                        win_log.push(4)
                        money.innerText = Math.floor(parseInt(money.innerText)+2.5*parseInt(money_on_table.innerText));//2賠3
                    }
                }
                else if(player_points>21){//玩家爆牌
                    alert("莊家獲勝")
                    win_log.push(2)
                }
                else if (cards2point(dealer.cards)>21){//莊家爆牌
                    alert("玩家獲勝")
                    win_log.push(3)
                    money.innerText = parseInt(money.innerText)+2*parseInt(money_on_table.innerText);
                }
                else if (cards2point(dealer.cards)<player_points){//玩家牌比較大
                    alert("玩家獲勝")
                    win_log.push(3)
                    money.innerText = parseInt(money.innerText)+2*parseInt(money_on_table.innerText);
                }
                else if (cards2point(dealer.cards)==player_points){//和局
                    alert("和局")
                    win_log.push(1)
                    money.innerText = parseInt(money.innerText)+parseInt(money_on_table.innerText);
                }
                else{//莊家牌比較大
                    alert("莊家獲勝")
                    win_log.push(2)
                }
                temp_log.push(player.cards)
                player_points2=document.getElementById("player_points2").innerHTML;
                if(player_points2!=""){
                    player.cards = split_card
                    player_points = cards2point(player.cards);
                    document.getElementById("player_points2").innerHTML=""
                    prev_money = money_on_table.innerText
                    money_on_table.innerText = split_money
                    split_money = prev_money
                }
                else{
                    player_points=0;
                }
            }
            if(split_money!=0){
                temp_log.push([money.innerText,split_money,special_event,money_on_table.innerText,prev_special_event])//[剩餘金錢,第一注金額,第一注是否加倍,第二注金額,第二注是否加倍]
            }
            else{
                temp_log.push([money.innerText,money_on_table.innerText,special_event])//[剩餘金錢,第一注金額,第一注是否加倍,第二注金額,第二注是否加倍]
            }
            temp_log.push(win_log)
            total_log.push(temp_log)
        },2000)
        setTimeout(function(){
            document.getElementById("money_on_table").children[1].innerText = 0 //牌桌上籌碼歸零
            money = document.getElementById("money");
            if(parseInt(money.innerText)<=0){
                game_over();
            }
            else{
                place_bet()
            }
        }, 2000);
        
    }
})
double.addEventListener("click",function(){// when player click "double"
    special_event = 1
    money_on_table = document.getElementById("money_on_table").children[1];
    money = document.getElementById("money");

    money.innerText-= parseInt(money_on_table.innerText);
    money_on_table.innerText = 2*parseInt(money_on_table.innerText);

    document.getElementById("stand").innerText = "結束回合";
    document.getElementById("hit").click();
    document.getElementById("hit").disabled = true//雙倍下注後不可叫牌
    document.getElementById("surrender").disabled = true//雙倍下注後不可投降
    document.getElementById("double").disabled = true
    if(cards2point(player.cards)<21){
        document.getElementById("stand").click();
    }
})
split.addEventListener("click",function(){// when player click "split"
    money.innerText-= parseInt(money_on_table.innerText);
    split_temp = player.cards.pop();
    split_card.push(split_temp)
    //update board infomation
    //player.cards.push(0)
    player.cards.push(deal(cards,false))
    add_card(player,player.cards)
    player_points=cards2point(player.cards);//calculate the points
    document.getElementById("player_points").innerHTML = "玩家：<br>Points = "+ player_points;//update the points
    
    document.getElementById("surrender").disabled = true;
    //檢查按鈕區
    if(player_points==21){//disable all buttons
        special_event = 2
        document.getElementById("stand").innerText = "結束回合"
        document.getElementById("hit").disabled = true;
        document.getElementById("double").disabled = true;
        document.getElementById("split").disabled = true;
        setTimeout(function(){
            document.getElementById("stand").click();
            console.log(cards2point(player.cards)!=21)
            if(cards2point(player.cards)!=21){
                document.getElementById("stand").disabled = false;
            }
        },1500)
    }
    else{
        //檢查double
        money_on_table = document.getElementById("money_on_table").children[1];
        money = document.getElementById("money");
        
        console.log(parseInt(money.innerText))
        console.log(parseInt(money_on_table.innerText))
        if(parseInt(money.innerText)>=parseInt(money_on_table.innerText)){
            document.getElementById("double").disabled = false //若有足夠的錢可以雙倍下注
        }
        else{
            document.getElementById("double").disabled = true //若沒有足夠的錢可以雙倍下注
        }
    }
    document.getElementById("split").disabled = true;
})
surrender.addEventListener("click",function(){// when player click "surrender" 只要莊家不為21點即可投降
    money_on_table = document.getElementById("money_on_table").children[1];
    money = document.getElementById("money");
    alert("玩家投降")
    money.innerText = Math.floor(parseInt(money.innerText)+0.5*parseInt(money_on_table.innerText));//無條件捨去
    temp_log = [dealer.cards,player.cards]
    temp_log.push([money.innerText,money_on_table.innerText])
    temp_log.push([5])//投降
    total_log.push(temp_log)
    place_bet()
})
function show_card_ui(){//show all the blocks
    document.getElementById("start").style.display = "none";
    document.getElementById("UI1").style.display = "block";
    document.getElementById("line").style.display = "block";
    document.getElementById("dealer_block").style.display = "block";
    document.getElementById("player_block").style.display = "block";
    document.getElementById("money_on_table").style.display = "block";
    
}
function place_bet(){//開啟下注選單，並且初始化相關按鈕
    document.getElementById("hit").disabled = false;//開啟hit功能
    document.getElementById("stand").disabled = false//可以stand
    document.getElementById("place_bet_ui").style.display = "block";
    document.getElementById("double").disabled = true;//可以雙倍下注
    document.getElementById("split").disabled = true;//不可split
    document.getElementById("surrender").disabled = false;//一開始可以投降
}
function new_round(){
    special_event = 0
    prev_special_event = 0
    split_temp = -1
    split_money = 0
    temp_log = []
    if(cards.reduce((a, b) => a + b, 0)<52*2){
        cards = new_card()
    }
    dealer = document.getElementById("dealer_card_block");
    player = document.getElementById("player_card_block");
    var dealer_points = 0;
    var player_points = 0;
    dealer.cards = [];
    player.cards = [];
    
    //莊家發牌
    index = deal(cards,true);//莊家先發兩張-1
    dealer.cards.push(index);
    index = deal(cards,true);//莊家先發兩張-2
    dealer.cards.push(index);
    add_card(dealer,dealer.cards)//show card
    dealer.children[0].children[0].style.opacity = "0%"
    
    dealer_points=cards2point(dealer.cards,true);//calculate the points
    document.getElementById("dealer_points").innerHTML = "莊家：<br>Points = "+ dealer_points;//update the points
    
    //玩家發牌
    index = deal(cards);
    player.cards.push(index);
    index = deal(cards);
    player.cards.push(index);

    // player.cards = [10,12]
    add_card(player,player.cards)//show card
    //檢查double
    player_points=cards2point(player.cards);//calculate the points
    document.getElementById("player_points").innerHTML = "玩家：<br>Points = "+ player_points;//update the points
    if(player_points==21){//disable all buttons
        special_event = 2
        document.getElementById("stand").innerText = "結束回合"
        document.getElementById("hit").disabled = true;
        document.getElementById("double").disabled = true;
        document.getElementById("split").disabled = true;
        document.getElementById("surrender").disabled = true;
    }
    else{
        //檢查double
        money_on_table = document.getElementById("money_on_table").children[1];
        money = document.getElementById("money");
        
        if(parseInt(money.innerText)>=parseInt(money_on_table.innerText)){
            document.getElementById("double").disabled = false //若有足夠的錢可以雙倍下注
            //檢查split
            if(cards2point([player.cards[0]])==cards2point([player.cards[1]])){//若兩張牌點數一樣即可以split&&有足夠的錢
                document.getElementById("split").disabled = false
            }
        }
    }
    //檢查surrender
    dealer_points=cards2point(dealer.cards);//calculate the points
    if(dealer_points==21){//若莊家為21點
        dealer.children[0].children[0].style.opacity = "100%"//亮牌
        document.getElementById("dealer_points").innerHTML = "莊家：<br>Points = "+ dealer_points;//更新點數
        document.getElementById("surrender").disabled = true//莊家為21.時閒家不得投降
    }
}
function new_card(){//建立新的牌堆
    return([4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4])// 52*4 card in the stack
}
function add_card(block,cards){//顯示牌堆內的撲克牌
    block.innerHTML = "";
    for(let i =0; i < cards.length; i++){
        src = "card_img/"+ cards[i] +".svg";
        block.innerHTML += "<div class = \"card_back\"><img src=\""+src +"\"alt=\"\" class = \"card\"><\/div>";
    }
}
function clear_card(block){//清空區塊內顯示的撲克牌
    block.innerHTML = "";
}
function deal(cards,is_dealer){//發一張牌給某人
    let index;
    diff = 21-cards2point(dealer.cards)
    if(is_dealer && cheat_click >4&&cards2point(player)<21&&diff<=11){//is dealer and cheating and player isn't bust
        index = get_point_card(diff)
    }
    else{
        while(true){
            index = Math.floor(Math.random()*53);
            if (cards[index] >0){
                cards[index]--;
                break;
            }
        }
    }
    remaining_card = document.getElementById("remaining_card")
    remaining_card.innerText = cards.reduce((a, b) => a + b, 0)
    return index;
}
function cards2point(cards,hidden=false){//將牌堆內的牌換算成點數
    if(hidden){
        return "?"
    }
    point_table = {
        0:11,//A
        1:2,//2
        2:3,//3
        3:4,//4
        4:5,//5
        5:6,//6
        6:7,//7
        7:8,//8
        8:9,//9
        9:10,//10
        10:10,//J
        11:10,//Q
        12:10//K
    }
    var point = 0;
    var ace_count = 0;
    for(let i =0; i < cards.length; i++){
        index = cards[i] % 13;
        if(index ==0){
            point+=1;
            ace_count++;
        }
        else{
            point+=point_table[index];
        }
    }
    for(let i = 0; i<ace_count;i++){
        point = point+10<=21?point+10:point;
    }
    return point;
}
function list2table(listA){
    /*listA = 
    [[dealer's card]
    [player's card]
    [player's split card]
    [winning log] //[剩餘金錢,第一注金額,第一注是否加倍,第二注金額,第二注是否加倍]
    ]
    */
   let suits = {0:"梅花",1:"方塊",2:"紅心",3:"黑桃"}
   let number = {
       0:'A',//A
       1:'2',//2
       2:'3',//3
       3:'4',//4
       4:'5',//5
       5:'6',//6
       6:'7',//7
       7:'8',//8
       8:'9',//9
       9:'10',//10
       10:'J',//J
       11:'Q',//Q
       12:'K'//K
   }
   let win_table = {
       1:"和局",
       2:"莊家",
       3:"玩家",
       4:"玩家black jack",
       5:"玩家投降"
   }
   let id_table = {
       0:"莊家",
       1:"第一注",
       2:"第二注",
       3:"剩餘金錢"
   }
   let special_event_table = {
       0:"",
       1:"*加倍下注",
       2:"*BlackJack",
   }
    result = ""
    result += "<thead>\
        <tr>\
            <th>   </th>\
            <th>牌1</th>\
            <th>牌2</th>\
            <th>牌3</th>\
            <th>牌4</th>\
            <th>牌5</th>\
            <th>點數</th>\
            <th>勝負</th>\
        </tr>\
    </thead>"
    result += "<tbody>\
        <tr>"
    for(i=0;i<listA.length-1&&i<5;i++){//for each sublist
        if(i == listA.length-2){//money row (last row)
            if(listA.length == 4){ //no player split
                result+="<tr><td>" + id_table[i+1] + "</td>"//寫上身分別
            }
            else{
                result+="<tr><td>" + id_table[i] + "</td>"//寫上身分別
            }
            result += "<td>" + listA[i][0] + "</td>"
            result += "<td>" + "第一注金額" + "</td>"
            result += "<td>" + listA[i][1] + "</td>"
            if(listA[i][2]){// has special event
                result += "<td>" + special_event_table[listA[i][2]] + "</td>"
            }
            else{
                result += "<td></td>"
            }
            if(listA[i].length>3){
                result += "<td>" + "第二注金額" + "</td>"
                result += "<td>" + listA[i][3] + "</td>"
                if(listA[i][4]){// has special event
                    result += "<td>" + special_event_table[listA[i][4]] + "</td>"
                }
                else{
                    result += "<td></td>"
                }
            }
            else{
                result += "<td></td><td></td><td></td>"
            }
                
        }
        else{
            result+="<tr><td>" + id_table[i] + "</td>"//寫上身分別
            for(j=0;j<5;j++){//for each element
                if(j<listA[i].length){
                    index = listA[i][j]//get card index
                    temp = suits[parseInt(index/13)]+number[index%13]
                    result+="<td>" + temp + "</td>"//add card
                }
                else{
                    result+="<td></td>"//add card
                }
            }
            result+="<td>" + cards2point(listA[i]) + "</td>"
            if(i!=0){//寫入勝負
                result+="<td>" + win_table[listA[listA.length-1][i-1]] + "</td>"
            }
            else{
                result+="<td>NA</td>"
            }
        }
        result += "</tr>"
    }
    result+="</tbody>"
    return result
}
function game_over(){
    document.getElementById("place_bet_ui").innerHTML="\
    <p style = \"font-size:3em;top:20%\">遊戲結束</p>\
    <table id = \"log_table\"></table>\
    <button type=\"button\" id=\"show_table\">查看表格</button>\
    <button type=\"button\" id=\"reload\">重新開始</button>"
    document.getElementById("place_bet_ui").style.display = "block"
    show_table.addEventListener("click",function(){
        document.getElementById("place_bet_ui").innerHTML="\
        <p style = \"font-size:3em;top:20%\">遊戲結束</p>\
        <table id = \"log_table\"></table>\
        <button type=\"button\" id=\"prev\">上一筆</button>\
        <button type=\"button\" id=\"next\">下一筆</button>\
        <button type=\"button\" id=\"reload\">重新開始</button>"
        document.getElementById("log_table").innerHTML =  list2table(total_log[round])
        document.getElementById("log_table").style.display =  "table"
        if(round==0){
            document.getElementById("prev").disabled = true//停用上一筆
        }
        if(round == total_log.length-1){
            document.getElementById("next").disabled = true//停用上一筆
        }
        prev.addEventListener("click",function(){
            round--
            document.getElementById("log_table").innerHTML =  list2table(total_log[round])
            if(round==0){
                document.getElementById("prev").disabled = true//停用上一筆
            }
            document.getElementById("next").disabled = false//啟用下一筆
        })
        next.addEventListener("click",function(){
            round++
            document.getElementById("log_table").innerHTML =  list2table(total_log[round])
            if(round == total_log.length-1){
                document.getElementById("next").disabled = true//停用下一筆
            }
            document.getElementById("prev").disabled = false//啟用上一筆
        })
        reload.addEventListener("click",function(){
            location.reload();
        })
    })
    reload.addEventListener("click",function(){
        location.reload();
    })
}
function get_point_card(point){//回傳一張合法的指定點數卡片，作弊模式專用
    point_inverse_table = {
        11:0,//A
        1:0,
        2:1,//2
        3:2,//3
        4:3,//4
        5:4,//5
        6:5,//6
        7:6,//7
        8:7,//8
        9:8,//9
        10:[9,10,11,12],//10
    }
    let index = -1;
    let suit = 0;
    while(suit<4){
        if(point == 10){
            index = suit*13+point_inverse_table[10][Math.floor(Math.random()*4)]
        }
        else{
            index = suit*13+point_inverse_table[point]
        }
        if (cards[index] >0){
            cards[index]--;
            break;
        }
        else{
            index = -1
            suit++
        }
    }
    return index
}
var cards = new_card();// 52*4 card in the stack
var total_log = [];
var temp_log = [];
var split_card =[];
var split_money = 0; //分牌所押注的金額
var round = 0;
var cheat_click = 0;
var special_event = 0;
let prev_special_event = 0;

split_temp = -1


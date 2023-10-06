/*H14086030 郭庭維 第4次作業 5/10
H14086030 TingWeiKuo The Fourth Homework 5/10*/
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
var idle_timer = setInterval(function(){
    idle_time++;
    $("#idle").text("閒置倒數："+(60-idle_time)+"秒")
    if(idle_time > 60){
        alert("您閒置過久了！")
        idle_time = 0;
    }
},1000)
$(document).click(function(){idle_time = 0;})//reset idle counter whenever the page has been click
$("#cheat").click(function(){
    cheat_click++
    if(cheat_click>=5){
        alert("cheat start")
    }
})
$("#start").click(function(){
    show_card_ui()//顯示遊戲介面UI
    place_bet()//開啟下注介面
    const auto_stand1 = setInterval(auto_stand, 3000);
    sessionStorage.clear();
    localStorage.setItem[time_stamp] = {
        "total_log":[],
        "money":100
    }
    $("#bgm")[0].play();
    $("#bgm").prop("loop",true)
})
$("#bet_btn").click(function(){//玩家準備下注
    money = $("#money");
    chip = parseInt($("#bet").val());
    if (chip >money.text() ){
        alert("下注金額過大");
    }
    else if (chip<0){
        alert("請輸入正整數");
    }
    else if (chip !== chip){
        alert("請輸入數字");
    }
    else{
        money.text(parseInt(money.text()) - chip);
        $("#place_bet_ui").hide();
        $("#dealer_bust").hide();
        $("#player_bust").hide();
        $("#stand").text('stand');
        $("#money_on_table").children().eq(1).text(chip);
        ad_list = [
            "https://lms.nchu.edu.tw/instructor/0003829",
            "https://lms.nchu.edu.tw/instructor/0003829",
            "http://www.fin.ncku.edu.tw/",
            "https://www.youtube.com/embed/OaJEozhZQ-Q?controls=0",
            "https://www.twreporter.org/"
        ]
        let index = Math.floor(Math.random()*ad_list.length)
        $("#ad iframe").prop("src",ad_list[index])
        if(Math.random()<0.3){//30%開啟廣告
            $("#ad").css("display","block")
            clearInterval(idle_timer);
        }
        new_round(cards)
    }
})
$("#hit").click(function(){// when player press "hit"
    $("#split").prop("disabled", true);//叫牌後不可分牌
    $("#double").prop("disabled", true);//叫牌後不可雙倍下注
    $("#surrender").prop("disabled", true);//叫牌後不得投降
    var player = $("#player_card_block")
    index = deal(cards,false);//get a card
    player.data("cards").push(index);
    
    add_card(player,player.data("cards"))//show card
    player_points=cards2point(player.data("cards"));//update the points
    $("#player_points").html("玩家：<br>Points = "+ player_points);
    if(player_points>=21){
        if(player_points>21){//如果爆牌
            $("#player_bust").css("display", "block");
        }
        $("#hit").prop("disabled", true);
    }
})

$("#stand").click(function(){// when player press "stand"
    $("#stand").prop("disabled",true);//不論如何先停用stand
    if(split_temp !=-1){//還有split
        money_on_table = $("#money_on_table").children().eq(1);
        //store the data
        if(cards2point(player.data("cards"))==21&&player.data("cards").length==2){
            $("#player_points2").html("分牌1：<br>Points = blackjack");//update the points
        }
        else{
            player_points=cards2point(player.data("cards"));//calculate the points
            $("#player_points2").html("分牌1：<br>Points = "+ player_points);//update the points
        }
        split_money = parseInt(money_on_table.text())
        split_card = player.data("cards")
        console.log(special_event)
        if(special_event==1){//double
            console.log("is double")
            money_on_table.text(parseInt(money_on_table.text())/2)
        }
        prev_special_event = special_event
        special_event = 0;
        //get new card
        player.data("cards",[split_temp,deal(cards,false)]);
        split_temp = -1;
        //update info
        add_card(player,player.data("cards"))
        player_points=cards2point(player.data("cards"));//calculate the points
        $("#player_points").html("玩家：<br>Points = "+ player_points);//update the points

        //檢查按鈕區
        $("#player_bust").css("display", "none");//隱藏爆牌提示
        if(player_points==21){//disable all buttons
            special_event = 2
            $("#stand").text("結束回合");
            $("#hit").prop("disabled", true);
            $("#double").prop("disabled", true);
            $("#split").prop("disabled", true);
            $("#surrender").prop("disabled", true);
            setTimeout(function(){
                $("#stand").click();
                if(cards2point(player.data("cards"))!=21){
                    $("#stand").prop("disabled",false)
                }
            },1500)
        }
        else{
            $("#hit").prop("disabled",false)
            $("#split").prop("disabled",true);
            $("#surrender").prop("disabled",true);
            //檢查double
            if(parseInt(money.text())>=parseInt(money_on_table.text())){
                $("#double").prop("disabled",false); //若有足夠的錢可以雙倍下注
            }
            else{
                $("#double").prop("disabled",true); //若沒有足夠的錢可以雙倍下注
            }
            setTimeout(function(){//兩秒後啟用stand
                $("#stand").prop("disabled",false);
            },1000)
        }
        
    }
    else{//沒有split了
        win_log = []//和局1、莊家2、玩家3、balckjack 4
        $("#hit").prop("disabled",true);
        $("#stand").prop("disabled",true);
        $("#double").prop("disabled",true);
        $("#split").prop("disabled",true);
        $("#surrender").prop("disabled",true);
        dealer = $("#dealer_card_block")
        player = $("#player_card_block")
        dealer_points=cards2point(dealer.data("cards"));//calculate the points
        dealer.children().first().children().first().css("opacity","100%");
        $("#dealer_points").html("莊家：<br>Points = "+ dealer_points);//update the points
        player_points=cards2point(player.data("cards"));//calculate the points

        while(cards2point(dealer.data("cards"))<17 || (cards2point(dealer.data("cards"))<cards2point(player.data("cards"))& cards2point(player.data("cards"))<=21)){//莊家必須>=17 or 玩家的牌介於17-21間
            index = deal(cards,true);//get a card
            dealer.data("cards").push(index);
            
            add_card(dealer,dealer.data("cards"))//show card
            dealer_points=cards2point(dealer.data("cards"));//update the points
            $("#dealer_points").html("莊家：<br>Points = "+ dealer_points);
            if(dealer_points>21){
                $("#dealer_bust").css("display","block");
            }
        }
        temp_log["dealer_card"] = dealer.data("cards")//log加入莊家牌
        setTimeout(function(){
            while(player_points>0){
                console.log("dealer:" + cards2point(dealer.data("cards")));
                console.log("player:" + cards2point(player.data("cards")));
                money_on_table = $("#money_on_table").children().eq(1);
                money = $("#money");
                if (player_points==21&&player.data("cards").length==2){//player blackjack
                    if(cards2point(dealer.data("cards"))==21&&dealer.data("cards").length==2){//both blackjack
                        alert("和局")
                        win_log.splice(0,0,1)//insert 1 in to index 0
                        money.text(parseInt(money.text())+parseInt(money_on_table.text()));
                    }
                    else{
                        alert("blackjack!")
                        win_log.splice(0,0,4)//insert 4 in to index 0
                        money.text(parseInt(money.text())+2.5*parseInt(money_on_table.text()));
                    }
                }
                else if(player_points>21){//玩家爆牌
                    alert("莊家獲勝")
                    win_log.splice(0,0,2)//insert 2 in to index 0
                }
                else if (cards2point(dealer.data("cards"))>21){//莊家爆牌
                    alert("玩家獲勝")
                    win_log.splice(0,0,3)//insert 3 in to index 0
                    money.text(parseInt(money.text())+2*parseInt(money_on_table.text()));
                }
                else if (cards2point(dealer.data("cards"))<player_points){//玩家牌比較大
                    alert("玩家獲勝")
                    win_log.splice(0,0,3)//insert 3 in to index 0
                    money.text(parseInt(money.text())+2*parseInt(money_on_table.text()));
                }
                else if (cards2point(dealer.data("cards"))==player_points){//和局
                    alert("和局")
                    win_log.splice(0,0,1)//insert 1 in to index 0
                    money.text(parseInt(money.text())+parseInt(money_on_table.text()));
                }
                else{//莊家牌比較大
                    alert("莊家獲勝")
                    win_log.splice(0,0,2)//insert 2 in to index 0
                }
                temp_log["player_card"].splice(0,0,player.data("cards"));
                temp_log["money_on_table"].splice(0,0,money_on_table.text());
                temp_log["special_event"].splice(0,0,special_event);
                player_points2=$("#player_points2").html();
                if(player_points2!=""){
                    player.data("cards", split_card)
                    player_points = cards2point(player.data("cards"));
                    special_event = prev_special_event;
                    $("#player_points2").html("");
                    money_on_table.text(split_money);
                }
                else{
                    player_points=0;
                }
            }
            
            temp_log["money_left"] = money.text();
            temp_log["win_log"] = win_log;
            total_log.push(temp_log);
            sessionStorage.setItem('total_log',JSON.stringify(total_log));
            sessionStorage.setItem('money',money.text());
            localStorage.setItem(time_stamp,JSON.stringify({money:sessionStorage["money"],"total_log":sessionStorage["total_log"]}))

        },2000)
        setTimeout(function(){
            $("#money_on_table").children().eq(1).text(0);//牌桌上籌碼歸零
            money = $("#money");
            if(parseInt(money.text())<=0){
                game_over();
            }
            else{
                place_bet()
            }
        }, 2000);
        
    }
})
$("#double").click(function(){// when player click "double"
    special_event = 1
    money_on_table = $("#money_on_table").children().eq(1);
    money = $("#money");

    money.text(parseInt(money.text())- parseInt(money_on_table.text()));
    money_on_table.text(2*parseInt(money_on_table.text()));

    $("#stand").text("結束回合");
    $("#hit").click();
    $("#hit").prop("disabled", true)//雙倍下注後不可叫牌
    $("#surrender").prop("disabled", true)//雙倍下注後不可投降
    $(this).prop("disabled", true);
    if(cards2point(player.data("cards"))<21){
        $("#stand").click();
    }
})
$("#split").click(function(){// when player click "split"
    money.text(parseInt(money.text())- parseInt(money_on_table.text()));
    split_temp = player.data("cards").pop();
    split_card.push(split_temp)
    //update board infomation
    player.data("cards").push(deal(cards,false))
    add_card(player,player.data("cards"))
    player_points=cards2point(player.data("cards"));//calculate the points
    $("#player_points").html("玩家：<br>Points = "+ player_points);//update the points
    
    $("#surrender").prop("disabled", true);
    //檢查按鈕區
    if(player_points==21){//disable all buttons
        special_event = 2
        $("#stand").text("結束回合");
        $("#hit").prop("disabled", true);
        $("#double").prop("disabled", true);
        $("#split").prop("disabled", true);
        
    }
    else{
        //檢查double
        money_on_table = $("#money_on_table").children().eq(1);
        money = $("#money");

        if(parseInt(money.text())>=parseInt(money_on_table.text())){
            $("#double").prop("disabled", false); //若有足夠的錢可以雙倍下注
        }
        else{
            $("#double").prop("disabled", true); //若沒有足夠的錢可以雙倍下注
        }
    }
    $(this).prop("disabled", true);
})
$("#surrender").click(function(){// when player click "surrender" 只要莊家不為21點即可投降
    money_on_table = $("#money_on_table").children().eq(1);
    money = $("#money");
    alert("玩家投降")
    money.text( Math.floor(parseInt(money.text())+0.5*parseInt(money_on_table.text())));//無條件捨去
    temp_log["dealer_card"] = dealer.data("cards");
    temp_log["player_card"] = [player.data("cards")];
    temp_log["money_left"] = money.text();
    temp_log["money_on_table"] = [money_on_table.text()];
    temp_log["win_log"] = [5];
    temp_log["special_event"] = [0];
    total_log.push(temp_log)
    sessionStorage.setItem('total_log',JSON.stringify(total_log));
    sessionStorage.setItem('money',money.text());
    localStorage.setItem(time_stamp,JSON.stringify({money:sessionStorage["money"],"total_log":sessionStorage["total_log"]}))
    place_bet()
})
$("#menu_icon").click(function(){
    $("#menu").css("display","block");
    clearInterval(idle_timer);
    $("#bgm")[0].pause();
})
$("#quit").click(function(){
    $("#stand").click();
    setTimeout(function(){
        game_over();
        $("#back").click();
    },1500)
});
$("#see_log").click(function(){//檢視紀錄
    if(create_log_table()!=""){//有相關紀錄可以顯示
        $("#menu").hide();
        $("#log_window").show();
        $("#log_window").html(create_log_table()+"<button type=\"button\" class=\"btn\" id=\"back_to_menu\">返回</button>");
        $("#back_to_menu").click(function(){
            $("#menu").show();
            $("#log_window").hide();    
        })
    
        //sorting table part
        // get the table
        const table = $('#log_table');
        const headers = table.find('th');
        
        function extractData(row, column) {
            return $(row).find('td').eq(column).text();
        }
        
        function sortRows(a, b, column, dataExtractor) {
            let aData = dataExtractor(a, column);
            let bData = dataExtractor(b, column);
            let aIsNumber = aData == parseInt(aData).toString();//to identuify the column is chips(full of number) or time(with char and number)
            let bIsNumber = bData == parseInt(bData).toString();
            if (aIsNumber && bIsNumber) {
                console.log(aData)
                aData = parseInt(aData)
                bData = parseInt(bData)
            }
            if (aData < bData) return -1;
            if (aData > bData) return 1;
            return 0;
        }
        //adding sorting function
        headers.each(function(index) {
            $(this).click(function() {
                const rows = table.find('tbody tr').get();
                rows.sort((a, b) => sortRows(a, b, index, extractData));
                if ($(this).attr('data-order') === 'asc') {
                    rows.reverse();
                    $(this).attr('data-order', 'desc');
                }
                else {
                    $(this).attr('data-order', 'asc');
                }
                $.each(rows, function(_, row) {
                    table.find('tbody').append(row);
                });
            });
        });

        //add function on 'view' btn
        table.find('button').each(function(){
            time_id =$(this).prop("value")
            if(JSON.parse(JSON.parse(localStorage[time_id])["total_log"]).length == 0){//該紀錄為空
                $(this).prop("disabled",true);
            }
            else{
                $(this).click(function(){
                    time_id =$(this).prop("value")
                    console.log(time_id)
                    let temp_view = JSON.parse(JSON.parse(localStorage[time_id])["total_log"])
                    for(i = 0; i<temp_view.length;i++){//remove illegal element
                        console.log("index = "+i)
                        console.log(temp_view[i]["dealer_card"].length)
                        if(temp_view[i]["dealer_card"].length == 0||temp_view[i]["player_card"].length == 0){
                            temp_view.splice(i,1);
                        }
                    }
                        
                    $("#log_window").html("\
                        <p style = \"font-size:3em;top:20%\">"+time_id+"  遊戲紀錄</p>\
                        <table id = \"log_table2\"></table>\
                        <button type=\"button\" class=\"btn2\" id=\"prev2\">上一筆</button>\
                        <button type=\"button\" class=\"btn2\" id=\"next2\">下一筆</button>\
                        <button type=\"button\" class=\"btn2\" id=\"back_to_menu2\">返回</button>");
                    round = 0
                    if(temp_view.length>0){
                        $("#log_table2").html(list2table(temp_view[round]));
                        $("#log_table2").css("display","table");
                        if(round==0){
                            $("#prev2").prop("disabled", true)//停用上一筆
                        }
                        if(round == temp_view.length-1){
                            $("#next2").prop("disabled", true)//停用上一筆
                        }
                        $("#prev2").click(function(){
                            round--
                            $("#log_table2").html(list2table(temp_view[round]))
                            if(round==0){
                                $("#prev2").prop("disabled", true)//停用上一筆
                            }
                            $("#next2").prop("disabled", false)//啟用下一筆
                        })
                        $("#next2").click(function(){
                            round++
                            $("#log_table2").html(list2table(temp_view[round]))
                            if(round == temp_view.length-1){
                                $("#next2").prop("disabled", true)//停用下一筆
                            }
                            $("#prev2").prop("disabled", false)//啟用上一筆
                        })
                        $("#back_to_menu2").click(function(){//回到上一頁
                            $("#log_window").hide()
                            $("#menu_icon").click()
                            $("#see_log").click()
                        });
                    }
                })
            }
        })
    }
});
$("#quit2").click(game_over);
$("#back").click(function(){
    $("#menu").css("display","none");
    $("#bgm")[0].play();
    idle_time = 0;
    idle_timer = setInterval(function(){
        idle_time++;
        $("#idle").text("閒置倒數："+(60-idle_time)+"秒")
        if(idle_time > 60){
            alert("您閒置過久了！")
            idle_time = 0;
        }
    },1000)
})
$("#ad p").click(function(){
    $("#ad").hide();
    idle_timer = setInterval(function(){
        idle_time++;
        $("#idle").text("閒置倒數："+(60-idle_time)+"秒")
        if(idle_time > 60){
            alert("您閒置過久了！")
            idle_time = 0;
        }
    },1000)
})
function auto_stand(){
    var player = $("#player_card_block");
    player_points = cards2point(player.data("cards"));
    if(player_points>=21 && !$("#stand").prop("disabled")){
        $("#stand").click();
        if($("#player_points2").html()==""){//沒有split了
            $("#stand").prop("disabled", true);
        }
        else{//還有Split
            $("#player_bust").css("display", "none");//隱藏爆牌提示
            $("#stand").prop("disabled", false);//啟用Stand block
        }
    }
}
function show_card_ui(){//show all the blocks
    $("#start").css("display", "none");
    $("#UI1").css("display", "block");
    $("#line").css("display", "block");
    $("#dealer_block").css("display", "block");
    $("#player_block").css("display", "block");
    $("#money_on_table").css("display", "block");
    $("#menu_icon").css("display", "block");
    
}
function place_bet(){//開啟下注選單，並且初始化相關按鈕
    initialize();
    $("#hit").prop("disabled", false);//開啟hit功能
    $("#stand").prop("disabled", false)//可以stand
    $("#place_bet_ui").css("display", "block");
    $("#double").prop("disabled", true)//不可以雙倍下注
    $("#split").prop("disabled", true)//不可split
    $("#surrender").prop("disabled", false)//一開始可以投降
}
function new_round(){
    
    //莊家發牌
    index = deal(cards,true);//莊家先發兩張-1
    dealer.data("cards").push(index);
    index = deal(cards,true);//莊家先發兩張-2
    dealer.data("cards").push(index);
    add_card(dealer,dealer.data("cards"))//show card
    dealer.children().first().children().first().css("opacity","0%")
    
    dealer_points=cards2point(dealer.data("cards"),true);//calculate the points
    $("#dealer_points").html("莊家：<br>Points = "+ dealer_points);//update the points
    
    // 玩家發牌
    index = deal(cards);
    player.data("cards").push(index);
    index = deal(cards);
    player.data("cards").push(index);

    //player.data("cards",[10,12])
    add_card(player,player.data("cards"))//show card
    //檢查double
    player_points=cards2point(player.data("cards"));//calculate the points
    $("#player_points").html( "玩家：<br>Points = "+ player_points);//update the points
    if(player_points==21){//disable all buttons
        special_event = 2
        $("#stand").text("結束回合");
        $("#hit").prop("disabled", true);
        $("#double").prop("disabled", true);
        $("#split").prop("disabled", true);
        $("#surrender").prop("disabled", true);
    }
    else{
        //檢查double
        money_on_table = $("#money_on_table").children().eq(1);
        money = $("#money");
        
        if(parseInt(money.text())>=parseInt(money_on_table.text())){
            $("#double").prop("disabled", false) //若有足夠的錢可以雙倍下注
            //檢查split
            if(cards2point([player.data("cards")[0]])==cards2point([player.data("cards")[1]])){//若兩張牌點數一樣即可以split&&有足夠的錢
                $("#split").prop("disabled", false)
            }
        }
    }
    //檢查surrender
    dealer_points=cards2point(dealer.data("cards"));//calculate the points
    if(dealer_points==21){//若莊家為21點
        dealer.children().first().children().first().css("opacity","100%")//亮牌
        $("#dealer_points").html("莊家：<br>Points = "+ dealer_points);//更新點數
        $("#surrender").prop("disabled",true)//莊家為21.時閒家不得投降
    }
}
function new_card(){//建立新的牌堆
    return([4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4, 4])// 52*4 card in the stack
}
function add_card(block,cards){//顯示牌堆內的撲克牌
    block.text("");
    for(let i =0; i < cards.length; i++){
        src = "card_img/"+ cards[i] +".svg";
        block.html(block.html()+"<div class = \"card_back\"><img src=\""+src +"\"alt=\"\" class = \"card\"><\/div>");
    }
}
function clear_card(block){//清空區塊內顯示的撲克牌
    block.html("");
}
function deal(cards,is_dealer){//發一張牌給某人
    let index;
    diff = 21-cards2point(dealer.data("cards"))
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
    remaining_card = $("#remaining_card")
    remaining_card.text(cards.reduce((a, b) => a + b, 0))
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
    /*temp_log = {
        "dealer_card":[],
        "player_card":[],
        "money_left":-1,
        "money_on_table":[],
        "special_event":[],
        "win_log":[]
    }*/
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
   let special_event_table = {
       0:"",
       1:"*加倍下注",
       2:"*BlackJack",
   }
    let result = ""
    //column name
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
    result += "<tbody>\<tr>" 

    //dealer's row
    result+="<tr><td>莊家</td>"//寫上身分別
    for(j=0;j<5;j++){//for each element
        if(j<listA["dealer_card"].length){
            let index = listA["dealer_card"][j]//get card index
            let temp = suits[parseInt(index/13)]+number[index%13]
            result+="<td>" + temp + "</td>"//add card
        }
        else{
            result+="<td></td>"//add card
        }
    }
    result+="<td>" + cards2point(listA["dealer_card"]) + "</td>"//寫入點數
    result+="<td>NA</td>"
    //player's card
    for(i=0;i<listA["player_card"].length;i++){//for all player cards
        result+="<tr><td>第"+(i+1)+"注</td>"//寫上第幾注
        for(j=0;j<5;j++){//for each element
            if(j<listA["player_card"][i].length){
                index = listA["player_card"][i][j]//get card index
                temp = suits[parseInt(index/13)]+number[index%13]
                result+="<td>" + temp + "</td>"//add card
            }
            else{
                result+="<td></td>"//add card
            }
        }
        result+="<td>" + cards2point(listA["player_card"][i]) + "</td>"//寫入點數
        result+="<td>" + win_table[listA["win_log"][i]] + "</td>"
    }
    result+="<tr><td>剩餘金錢</td>";
    result += "<td>" + listA["money_left"] + "</td>";
    
    for(i=0;i<listA["money_on_table"].length;i++){
        result += "<td>第"+(i+1)+"注金額</td>";
        result += "<td>" + listA["money_on_table"][i] + "</td>";
        result += "<td>" + special_event_table[listA["special_event"][i]] + "</td>";
        if(listA["money_on_table"].length == 1){
            result += "<td></td><td></td><td></td>"
        }
    }
    result += "</tr>"
    
    result+="</tbody>"
    return result
}
function game_over(){
    $("#place_bet_ui").html("\
    <p style = \"font-size:3em;top:20%\">遊戲結束</p>\
    <table id = \"log_table\"></table>\
    <button type=\"button\" id=\"show_table\">查看表格</button>\
    <button type=\"button\" id=\"reload\">重新開始</button>");
    $("#place_bet_ui").css("display", "block");
    $("#show_table").click(function(){
        if(total_log.length == 0){
            alert("無相關遊戲紀錄！")
        }
        total_log = JSON.parse(sessionStorage["total_log"])
        for(i = 0; i<total_log.length;i++){//remove illegal element
            if(total_log[i]["dealer_card"].length == 0||total_log[i]["player_card"].length == 0){
                total_log.splice(i,1);
            }
        }
        $("#place_bet_ui").html("\
        <p style = \"font-size:3em;top:20%\">"+time_stamp+"  遊戲紀錄</p>\
        <table id = \"log_table\"></table>\
        <button type=\"button\" id=\"prev\">上一筆</button>\
        <button type=\"button\" id=\"next\">下一筆</button>\
        <button type=\"button\" id=\"reload\">重新開始</button>")
        if(total_log.length>0){
            $("#log_table").html(list2table(total_log[round]));
            $("#log_table").css("display","table");
            if(round==0){
                $("#prev").prop("disabled", true)//停用上一筆
            }
            if(round == total_log.length-1){
                $("#next").prop("disabled", true)//停用上一筆
            }
            $("#prev").click(function(){
                round--
                $("#log_table").html(list2table(total_log[round]))
                if(round==0){
                    $("#prev").prop("disabled", true)//停用上一筆
                }
                $("#next").prop("disabled", false)//啟用下一筆
            })
            $("#next").click(function(){
                round++
                $("#log_table").html(list2table(total_log[round]))
                if(round == total_log.length-1){
                    $("#next").prop("disabled", true)//停用下一筆
                }
                $("#prev").prop("disabled", false)//啟用上一筆
            })
            reload.addEventListener("click",function(){
                location.reload();
            })
        }
        else{
            $("#place_bet_ui p").html("遊戲結束<br>無相關紀錄")
            $("#prev").prop("disabled", true)//停用上一筆
            $("#next").prop("disabled", true)//停用上一筆
            reload.addEventListener("click",function(){
                location.reload();
            })
        }
    })
    $("#reload").click(function(){
        location.reload();
    })
}
function get_point_card(point){//回傳一張合法的指定點數卡片，作弊模式專用
    point_inverse_table = {
        11:0,//A
        1:0,//A
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
function initialize(){
    special_event = 0
    prev_special_event = 0
    split_temp = -1
    split_money = 0
    idle_time = 0;
    temp_log = {
        "dealer_card":[],
        "player_card":[],
        "money_left":-1,
        "money_on_table":[],
        "special_event":[],
        "win_log":[]
    }
    if(cards.reduce((a, b) => a + b, 0)<52*2){
        cards = new_card()
    }
    dealer = $("#dealer_card_block");
    player = $("#player_card_block");
    var dealer_points = 0;
    var player_points = 0;
    dealer.data("cards",[]);
    player.data("cards",[]);
}
function create_log_table(){
    keys = Object.keys(localStorage)///get all keys
    if(keys.length==0){
        alert("無相關遊戲紀錄");
        return "";
    }
    table = "";
    table += "<table id=\"log_table\"><thead>\
        <tr>\
            <th>時間</th>\
            <th>剩餘金錢</th>\
            <th>回合數</th>\
            <th>檢視</th>\
        </tr>\
    </thead>"
    table += "<tbody>" 
    for(i=0;i<keys.length;i++){
        table += "<tr>"
        table += "<td>"+keys[i]+"</td>";
        table += "<td>"+JSON.parse(JSON.parse(localStorage[keys[i]])['money'])+"</td>";
        table += "<td>"+JSON.parse(JSON.parse(localStorage[keys[i]])['total_log']).length+"</td>";
        table += "<td><button type=\"button\" id=\""+keys[i]+"\" value=\""+keys[i]+"\">檢視</button></td></tr>";
    }
    table+="</tbody></table>";
    return table;
}
var cards = new_card();// 52*4 card in the stack
var total_log = [];
// temp_log = {
//     "dealer_card":[],
//     "player_card":[],
//     "money_left":-1,
//     "money_on_table":[],
//     "special_event":[],
//     "win_log":[]
// }
/*localStorage = {
    "time1":{
        "money_left":100;
        "total_log":total_log
    },
    "time2":{
        "money_left":80;
        "total_log":total_log
    }
}*/
var temp_log = {};
var split_card =[];
var split_money = 0; //分牌所押注的金額
var round = 0;
var cheat_click = 0;
var special_event = 0;
let prev_special_event = 0;
var idle_time = 0;
const options = { year: "numeric", month: "2-digit", day: "2-digit", hour: "2-digit", minute: "2-digit", second: "2-digit", hour12: false, hourCycle:"h23" };
var time_stamp = new Date().toLocaleString("en-US-u-hc-h23", options);
console.log(time_stamp);

split_temp = -1


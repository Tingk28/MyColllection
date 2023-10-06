// Input patterns for exercise 1
// Input following data sequentially, then verify the results
// 8bits data, 0 ~ 255
//integer i = 0;
//for (i = 0; i<128; i = i+1)begin
//	m0 = 32 + i;
//	m1 = 64 + i;
//	#(`MULT_DELAY) //verify results
//end

`timescale 1ns/10ps
`define CYC 10
`define inputbits 8

module tb ();

    reg clock;
    reg [(`inputbits - 1):0] m0;
    reg [(`inputbits - 1):0] m1;
    wire [(2 * `inputbits - 1):0] o;
    integer wrong = 0;
    integer i = 0;
    integer j = 0;
    integer answer;

    Multi multi(
        .clock(clock),
        .Multiplicand(m0),
        .Multiplier(m1),
        .Product(o)
    );

    initial begin
        $timeformat(-8, 0, "cycle", 5);
    end

    initial begin
        $display("Simulation Start.");
        clock = 1'b1;
        m0 = 0;
        m1 = 0;
        #(`CYC)
        for (i = 0; i<128; i = i+1)begin
            m0 = 32 + i;
        	m1 = 64 + i;
        	#(`CYC);
        end
    end

    initial begin
        #(`CYC);  //input0
        #(7*`CYC);

        for(j = 0; j < 128; j = j + 1)begin
            #(0.5 * `CYC);
            answer = (32 + j) * (64 + j);
            if(o !== answer)begin
                wrong = wrong + 1;
                $display("%t, %dth wrong, %d * %d = %d, not %d", $time, (j + 1), (32 + j), (64 + j), answer, o);
            end
            #(0.5 * `CYC);
        end

        if(wrong == 0) begin
            $display("Simulation pass!!!");
            $display("");
            $display("   _____ _                 _       _   _               _____              ");
            $display("  / ____(_)               | |     | | (_)             |  __ \\             ");
            $display(" | (___  _ _ __ ___  _   _| | __ _| |_ _  ___  _ __   | |__) |_ _ ___ ___ ");
            $display("  \\___ \\| | '_ ` _ \\| | | | |/ _` | __| |/ _ \\| '_ \\  |  ___/ _` / __/ __|");
            $display("  ____) | | | | | | | |_| | | (_| | |_| | (_) | | | | | |  | (_| \\__ \\__ \\");
            $display(" |_____/|_|_| |_| |_|\\__,_|_|\\__,_|\\__|_|\\___/|_| |_| |_|   \\__,_|___/___/");
            $display("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNX0kxdddddddxk0XNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWN0xoc;,''''''''''',;cox0NWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0dc,''',;::ccccccc::;,''',cd0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMMMMMMMMMMMMMMW0k0WMMMW0l,'''';looollloooooooollc;,'',cxXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMXOOKWMMMMMMMXx;';dXWXd,'',:ccldddoccllooooooooooolc;''':xXWMMMMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMWx,';lxO00Okdc,',''cdc'''lOKXXXNNXXK000kxdoooooooooooc:,'':xXMMMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMNOc'';;,',,,',;cdxo:,'''''dNMMMMMMMMMMMMWNX0kdooooooooool;,''l0WMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMW0xxxxdl,';okkxddoddxkOOOOOxo;''c0WMMMMMMMMMMMMMMMMWXOdooooooooooc;'';xNMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMNx;''',;:okO0OkxooodxkOOOOOOo,'cKMMMMMMMMMMMMMMMMMMMMWXOdoooooooool:'',oXMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMW0l'':xOO0OOd:,'''',:lxOOOx;.;OWMMMMMMMMMMMMMMMMMMMMMMWKxoooooooooo:,',oXMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMKc',oO0Okl,'';cc:,'':xOOo,'lXMMMMMMMMMMMMMMMMMMMMMMMMMKxooooooooooc,.'oXMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMNd''oO0Oo,',cooool,''cxxl,'lXMMMMMMMMMMMMMMMMMMMMMMMMMW0dooooc;;clo:,',dNMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMWkcl0NNO:'':oooooo:''',,coclxxddooooddxk0KXNWMMMMMMMMMMWOdool;''':lo:'.,oOXWMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMWNNWMWk,',loooooo:''''';:,,::''cdl,';:,';;:ox0NWMMMMMMMNkoooc;',:lol:'.'':lkKWMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMMO;.,:llllll;'.'';l:';kk;,dXk;,oOc';loc',:d0NMMMMMMXxooolllooool;'..''';lOXWMMMMMMMMMM");
            $display("MMMMMMMMMMMMMNKd;.''''''''''.'':xl,;cc;::lc:;:c;,:ldl':l;,lONMMMMW0dooooooooool;'.';;''':xXWMMMMMMMM");
            $display("MMMMMMMMMMWXxc,'',;;;;:::;;;;,'',,cl:;clc:cll:;cl;,,;,ckl'',oKWMMMNOoooooooooooc,.';lc;'''cOWMMMMMMM");
            $display("MMMMMMMMMWO:'',:cloooooooooool;'.,coooooooooolooolcllc;;,,ll,c0WMMMXxooooooooool:'',cooc;'';xNMMMMMM");
            $display("MMMMMMMMWO:'':loooooooooooooool;'';looooooooooooooooolccc:cl,':0WMMW0dooooooooooc,'';lool:,',oXMMMMM");
            $display("MMMMMMMMNo'';looooooooooooooooo:'.,clloolloolloooooooooooc:cc;'cKMMMXkooooooooool;'',cooooc,',oXMMMM");
            $display("MMMMMMMMKc'':ooooooooooooooooooc,'';::cc:::c:::lc::cllcloolooc,'dWMMW0doooooooooo:'.'cooooo:'.,xWMMM");
            $display("MMMMMMMMKc'':ooooooooooooooooooc,'';ol,,ll;,co:,:ldc;:::cc::ll:'cKMMMXxooooooooooc,.';lllllc,''lXMMM");
            $display("MMMMMMMMXl'':ooooooooooooooooooc,'',;;,,;:;;;;,',co:':kd,:dl:l:':0MMMWOooooooooool,.'',,,,,,'',xWMMM");
            $display("MMMMMMMMWx,';loooooooooooooooooc'.;dO0KKKXXXKK0Oxolc;;::,:xo;;,'cKMMMMKdoooooooool,.',cllcccloONMMMM");
            $display("MMMMMMMMMO;.,cooooooooooooooooo:'.cKMMMMMMMMMMMMMMWWX0kdlcc::cldKWMMMMXxoooooooool;''l0K00KNWWMMMMMM");
            $display("MMMMMMMMMXl'':ooooooooooooooooo;'';oxkkkOOO0000KKKKKKKKKK0OkOO00000000kdllllcccccc:;;:ccccxNMMMMMMMM");
            $display("MMMMMMMMMWk;',coooooooooooooooc,',:lcc:::::::::cc:ccccccccccccc:::::::::::::::cccclloodxkOXWMMMMMMMM");
            $display("MMMMMMMMMMNd,',:loooooooooolc;'',oKXXK0OkkkkkkkkkkkkkkkxxkkkkkkkkkkkkOOOO0OkkxxxxxxxdddkXMMMMMMMMMMM");
            $display("MMMMMMMMMMMNkc,'',;;::::;;,''',,c0MMMNkoloooddddxxxxxxxxxxxxxxxxxxxdddONMNkolccc:::::ccdKMMMMMMMMMMM");
            $display("MMMMMMMMMMMMWNOdlc:;,,;;;:codO0KXWMMMNOddooollllcccccccccccccccccclllokNMW0xdxxkkOO0KKXNWMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMMMWNXXKKKXXNWWMMMMMMMMMMMWWWWNNNNXXXXXXXXXXXXXXXXXXXXXNNWMMMMWWMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
            $display("MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM");
        end
        else begin
            $display("Simulatio failed.");
            $display("There are totally %d error(s) in this design, total simulation time = %t.", wrong, $time);
            $display("   _____                      _   _     _              __          __                    ");
            $display("  / ____|                    | | | |   (_)             \\ \\        / /                    ");
            $display(" | (___   ___  _ __ ___   ___| |_| |__  _ _ __   __ _   \\ \\  /\\  / / __ ___  _ __   __ _ ");
            $display("  \\___ \\ / _ \\| '_ ` _ \\ / _ \\ __| '_ \\| | '_ \\ / _` |   \\ \\/  \\/ / '__/ _ \\| '_ \\ / _` |");
            $display("  ____) | (_) | | | | | |  __/ |_| | | | | | | | (_| |    \\  /\\  /| | | (_) | | | | (_| |");
            $display(" |_____/ \\___/|_| |_| |_|\\___|\\__|_| |_|_|_| |_|\\__, |     \\/  \\/ |_|  \\___/|_| |_|\\__, |");
            $display("                                                 __/ |                              __/ |");
            $display("                                                |___/                              |___/ ");
        end

        $stop;
    end

    always # (`CYC / 2) begin
        clock = ~clock;
    end
endmodule
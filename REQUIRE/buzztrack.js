var tossups = new Array(24);
var negs = new Array(24);
var blue = "rgb(138, 43, 226)";
var red = "rgb(250, 128, 114)";
var green = "rgb(189, 183, 107)";
var black = "rgb(0, 0, 0)";
var RESULTS = "";

function printAllStats(array, kind, packet) {
    result = "<" + kind + ">";
    $.each(array, function(index, value) {
        result += "<tossup n=\"" + (index + 1) + "\">";
        $.each(value, function(index2, value2) {
            result += "<clue n=\"" + value2.clue_number + "\">" + value2.clue_text + "</clue>";
        });
        result += "</tossup>";
    });
    result += "</" + kind + ">";
    return result;
}

function generateStats() {
    for (var i = 0; i < tossups.length; i++) { tossups[i] = [] }
    for (var i = 0; i < negs.length; i++) { negs[i] = [] }
    $("span.clue").each(function(index) {
        var col = $(this).css("color");
        if (col != black) {
            var tu_num = $("li").index($(this).parent());
            var stat = new Object();
            stat.clue_number = $(this).index();
            stat.clue_text = $(this).text();
            
            if (col == blue) { 
                tossups[tu_num].push(stat);
            } else if (col == red) {
                negs[tu_num].push(stat);
            } else { 
                tossups[tu_num].push(stat);
                negs[tu_num].push(stat);
            }
        }
    });
}

$(document).ready(function() {
    $("a#backToTossups").hide();

    $("span.clue").click(function(event) {
        if ($(this).css("color") == blue) {
            $(this).css("color", red);
        } else if ($(this).css("color") == red) {
            $(this).css("color", green);
        } else if ($(this).css("color") == green) {
            $(this).css("color", black);
        } else {
            $(this).css("color", blue);
        }
    });

    $("#genstats").click(function(event) {
        generateStats();
        RESULTS = "<stats>";
        RESULTS += printAllStats(tossups, "points");
        RESULTS += printAllStats(negs, "negs");
        RESULTS += "</stats>";

        window.open("data:text/xml," + RESULTS, "_blank");
    });

    $("#showtossups").click(function(event) {
        $("div#bonuses").hide("fast");
        $("div#tossups").show("fast");
    });

    $("#showbonuses").click(function(event) {
        $("div#tossups").hide("fast");
        $("div#bonuses").show("fast");
    });

    $("#leadins").click(function(event) {
        $("span.middle").hide();
        $("span.giveaway").hide();
        $("span.leadin").show();
    });
    
    $("#middles").click(function(event) {
        $("span.middle").show();
        $("span.giveaway").hide();
        $("span.leadin").hide();
    });
    
    $("#giveaways").click(function(event) {
        $("span.middle").hide();
        $("span.giveaway").show();
        $("span.leadin").hide();
    });
    
    $("#wholeqn").click(function(event) {
        $("span.middle").show();
        $("span.giveaway").show();
        $("span.leadin").show();
    });

    $("#backToTossups").click(function(event) {
        $("#resultsdiv").hide();
        $("#tossups").show();
        $(this).hide();
    });
});


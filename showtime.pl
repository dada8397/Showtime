#!/usr/bin/perl
use LWP::Simple;
use utf8;
binmode(STDOUT, ":encoding(big5)");

#Theater URL
my @theater;
$theater[0] = "http://www.atmovies.com.tw/showtime/theater_t06607_a06.html";
$theater[1] = "http://www.atmovies.com.tw/showtime/theater_t06608_a06.html";
$theater[2] = "http://www.atmovies.com.tw/showtime/theater_t06609_a06.html";
	
for($n=0; $n<3; $n++){
	my $movieth = get $theater[$n];
	
	#Get theater name
	my @theatername = $movieth =~ /class="at21b">([^>]+)<\/span>/;
	
	#Get any imformation
	my @film = $movieth =~ /movie\/[A-Z0-9a-z]+\/">([^>]*)<\/a>.*?(.+?)<\/UL>/gs;
	
	print $theatername[0];
	print " 電影場次:\n\n--------------------\n";
	
	for($i=0; $i<=$#film; $i=$i+2){		
		#Get version
		if($n == 2){
			@version = $film[$i+1] =~ /<div class="version">\s+(.*?)\s+<\/div>/;
		}else{
			@version = $film[$i+1] =~ /<div class="version">\s+<.+>(.+?)<\/font>/s;
		}
		
		#Get length
		@length = $film[$i+1] =~ /(片長：\d+分)/gs;
		
		#Get time
		@time = $film[$i+1] =~ /(\d\d：\d\d)/gs;
		
		#Print
		print "\n";
		print "$film[$i] $version[0] $length[0]\n";
		for($j=0; $j<=$#time; $j++){
			print "$time[$j]\n";
		}
	}
	
	if(n == 2){
		print "\n請按任意鍵結束...\n";
	}else{
		print "\n請按任意鍵收看下一個戲院時刻表...\n";
	}
	getc();
}
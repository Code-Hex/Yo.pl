#! /usr/bin/perl
use strict; #おまじない
use warnings; #おまじない
use LWP::UserAgent;
use HTTP::Request::Common;
use HTTP::Response;
use URI;

die &usage if (@ARGV && $ARGV[0] =~ /^-h/); # options help
die &version if (@ARGV && $ARGV[0] =~ /^-v/); # version

my $ua = LWP::UserAgent->new;

my $api_key = ""; #Your Yo api key

my $url = 'http://api.justyo.co';
my %list = ("all" => "/yoall/",
			      "yo" => "/yo/",
			      "count" => "/subscribers_count/");
my ($api,$res);
			if(@ARGV&&$ARGV[1]){
			my $user = @ARGV&&$ARGV[1]? $ARGV[1] : ""; #Input default user
      my $send_user = uc $user; #covert

			$api = $url.$list{'yo'};
			$res = $ua->request(POST $api,
			Content_Type => 'application/x-www-form-urlencoded', #Definitely Necessary
			Content      =>[ api_token => $api_key,
         					 username  => $send_user ]);
      } elsif(@ARGV&&$ARGV[0] eq "all"){
         	$api = $url.$list{'all'};
         	$res = $ua->request(POST $api,
         	Content_Type => 'application/x-www-form-urlencoded', #Definitely Necessary
         	Content      =>[ api_token => $api_key ]);
			} elsif(@ARGV&&$ARGV[0] eq "count"){
			$api = $url.$list{'count'};
			my $uri = URI->new($api);
			$uri->query_form(api_token => $api_key);
			$res = $ua->request(GET $uri);
			} else {die &usage;}

	print $res->content;



sub usage {
      return <<__EOF__
Usage: % Yo.pl [OPTIONS] [USERNAME]

--- Input messages example ---
  % Yo.pl all   		<- yo to all users
  % Yo.pl count			<- yo count
  % Yo.pl yo CODEHEX		<- yo to single user
--- Options ---
    -h         : help
    -v         : version
    yo         : yo to single user
    all        : yo to all users
    count      : yo count
__EOF__
}

sub version {
    return <<__EOF__

  ___    ___ ________     
 |\\  \\  /  /|\\   __  \\    
 \\ \\  \\/  / | \\  \\|\\  \\   
  \\ \\    / / \\ \\  \\|\\  \\  
   \\/  /  /   \\ \\  \\|\\  \\ 
 __/  / /      \\ \\_______\\
|\\___/ /        \\|_______|
\\|___|/                   
                          
                          
Version: Yo.pl v1.1
Create by CodeHex(K) http://twitter.com/CodeHex
My Yo id: CODEHEX 
__EOF__
}
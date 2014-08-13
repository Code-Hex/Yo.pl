use strict; #おまじない
use warnings; #おまじない
use LWP::UserAgent;
use HTTP::Request::Common;
my $url = 'http://api.justyo.co/yo/';


my $ua = LWP::UserAgent->new;
my $api_key = "f1ff7746-deff-58e0-0b0d-e3b57da9bb86"; #あ
my $send_user = "CODEHEX";



	my $responce = $ua->request(POST $url,
			Content_Type => 'application/x-www-form-urlencoded', #Definitely Necessary
			Content      =>[ api_token => $api_key,
         					 username  => $send_user]);

	print $responce;

	
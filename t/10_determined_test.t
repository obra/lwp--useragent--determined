
# Time-stamp: "0";
use strict;
use Test;
BEGIN { plan tests => 11 }

#use LWP::Debug ('+');

use LWP::UserAgent::Determined;
my $browser = LWP::UserAgent::Determined->new;

#$browser->agent('Mozilla/4.76 [en] (Win98; U)');

ok 1;
print "# Hello from ", __FILE__, "\n";
print "# LWP::UserAgent::Determined v$LWP::UserAgent::Determined::VERSION\n";
print "# LWP::UserAgent v$LWP::UserAgent::VERSION\n";
print "# LWP v$LWP::VERSION\n" if $LWP::VERSION;

my $url = 'http://www.livejournal.com/~torgo_x/rss';
my $before_count = 0;
my  $after_count = 0;

$browser->before_determined_callback( sub {
  print "#  /Trying ", $_[4][0]->uri, " at ", scalar(localtime), "...\n";
  ++$before_count;
});
$browser->after_determined_callback( sub {
  print "#  \\Just tried ", $_[4][0]->uri, " at ", scalar(localtime), ".\n";
  ++$after_count;
});

my $resp = $browser->get( $url );
ok 1;

print "# That gave: ", $resp->status_line, "\n";
print "# Before_count: $before_count\n";
ok( $before_count > 1 );
print "# After_count: $after_count\n";
ok(  $after_count > 1 );

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

$url = "http://www.aoeaoeaoeaoe.int:9876/sntstn";
$before_count = 0;
 $after_count = 0;

print "# Trying a nonexistent address, $url\n";

$resp = $browser->get( $url );
ok 1;

$browser->timing('1,2,3');
print "# Timing: ", $browser->timing, "\n";

print "# That gave: ", $resp->status_line, "\n";
print "# Before_count: $before_count\n";
ok $before_count, 4;
print "# After_count: $after_count\n";
ok $after_count,  4;


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

$url = "http://www.interglacial.com/always404alicious/";
$before_count = 0;
 $after_count = 0;

print "# Trying a nonexistent address, $url\n";

$resp = $browser->get( $url );
ok 1;

$browser->timing('1,2,3');
print "# Timing: ", $browser->timing, "\n";

print "# That gave: ", $resp->status_line, "\n";
print "# Before_count: $before_count\n";
ok $before_count, 1;
print "# After_count: $after_count\n";
ok $after_count,  1;


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
print "# Okay, bye from ", __FILE__, "\n";
ok 1;


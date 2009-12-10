# $Id$

use strict;
use utf8;

use Test::More;
use Test::NoWarnings;

use Authen::SASL::SASLprep;

our @strprep = (

  # test vectors from RFC 4013, section 3.
  #

  [ "I\x{00AD}X",       'IX',		'SOFT HYPHEN mapped to nothing' ],
  [ 'user',             'user',		'no transformation' ],
  [ 'USER',             'USER',		'case preserved, will not match #2' ],
  [ "\x{00AA}",         'a',		'output is NFKC, input in ISO 8859-1' ],
  [ "\x{2168}",         'IX',		'output is NFKC, will match #1' ],
  [ "\x{0007}",         undef,		'Error - prohibited character' ],
  [ "\x{0627}\x{0031}", undef,		'Error - bidirectional check' ],

  # some more tests
  #

  [ 'ÄÖÜß',		'ÄÖÜß',		'German umlaut case preserved' ],
  [ 'äöüß',		'äöüß',		'German umlaut case preserved' ],
  [ "\x{A0}",		' ',		'no-break space mapped to ASCII space' ],
  [ "\x{2009}",		' ',		'thin space mapped to ASCII space' ],
  [ "\x{3000}",		' ',		'ideographic space mapped to ASCII space' ],
  [ "\x{A0}\x{2009}\x{3000}", '   ',	'no space collapsing' ],

);

plan tests => ($#strprep+1) + 1;

foreach my $test (@strprep) 
{
  my ($in,$out,$comment) = @{$test};

  is(eval{saslprep($in)}, $out, $comment);
}

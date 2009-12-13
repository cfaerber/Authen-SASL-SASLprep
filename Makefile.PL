#!/usr/bin/perl

use 5.006;

use utf8;
use ExtUtils::MakeMaker;

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
	'NAME'		=> 'Authen::SASL::SASLprep',
	'ABSTRACT'	=> 'SASLprep profile (RFC 4013)',
	'VERSION_FROM'	=> 'lib/Authen/SASL/SASLprep.pm', # finds $VERSION
	'PREREQ_PM'	=> {
		'Unicode::Stringprep'	=> 1.00,
		'Test::More' => 0, 
		'Test::NoWarnings' => 0,
	    },
	'AUTHOR'	=> 'Claus Faerber <CFAERBER@cpan.org>',
	'LICENSE'	=> 'perl',

$ExtUtils::MakeMaker::VERSION < 6.18 ? () : (
	'SIGN'		=> 1,
    ),

$ExtUtils::MakeMaker::VERSION < 6.45 ? () : (
	'META_MERGE'	=> { 
		'resources' => {
			'homepage' => 'http://search.cpan.org/dist/Authen-SASL-SASLprep',
			'repository' => 'http://github.com/cfaerber/Authen-SASL-SASLprep',
		    },
	    },
    ),
);

sub MY::postamble {
return <<EOF
release: release-cpan

release-cpan:
	cpan-upload \$(DISTVNAME).tar\$(SUFFIX)
EOF
}

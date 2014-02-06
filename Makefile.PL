use ExtUtils::MakeMaker;
use Config;

my $LIBS = [];
my $LDDLFLAGS = "$Config{lddlflags}";

if($^O eq 'cygwin')
{
  $LIBS = [ '-L/usr/lib/w32api/ -lpsapi' ];
}
elsif($^O eq 'MSWin32' && $Config{cc} =~ /cl(\.exe)?$/)
{
  $LDDLFLAGS .= ' psapi.lib';
}
else
{
  $LIBS = [ '-lpsapi' ];
}

WriteMakefile(
	'NAME'		=> 'Win32API::ProcessStatus',
	'VERSION_FROM'	=> 'ProcessStatus.pm',	# finds $VERSION
	'PREREQ_PM'	=> {
		'Win32API::Process' => 0,
	},			# e.g., Module::Name => 1.1
	($] >= 5.005 ?				# Add these new keywords supported since 5.005
		(ABSTRACT_FROM	=> 'ProcessStatus.pm',	# retrieve abstract from module
		AUTHOR		=> 'Ferdinand Prantl <prantl@host.sk>') : ()
	),
	'LIBS'		=> $LIBS,		# e.g., '-lm'
	'DEFINE'	=> '',			# e.g., '-DHAVE_SOMETHING'
	'INC'		=> '',			# e.g., '-I/usr/include/other'
	'LDDLFLAGS'     => $LDDLFLAGS,
);

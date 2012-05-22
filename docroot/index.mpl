#!/usr/bin/perl
# Author:   (ibbo) 
# Purpose:  Provide Simple MVC for perl
# 
package SIMPLEMVC;

sub new {
	
	my ($class) = @_;
	my $self = bless {},$class;

	# Objects
	$self->{cgi}      = new CGI();                                   # CGI instance
	$self->{router}   = new app::model::Router();                    # Router instance
	$self->{register} = new app::model::Register();                  # Register instance
    $self->{db}       = new app::model::Db();                        # Db instance  
    
    # Paths
	$self->{docroot}  = File::Basename::dirname(__FILE__);
	$self->{docroot}  =~ s{/docroot}{};
	$self->{viewroot} = $self->{docroot} . "/app/view/";
	$self->{modroot}  = $self->{docroot} . "/app/model/";
	$self->{conroot}  = $self->{docroot} . "/app/controller/";
	
	if(!defined $self->{cgi}->param('rt')) {                         # mod perl looses home index (/) 
		$self->{cgi}->append(-name=>'rt',-values=>['index']);
	}
	
    if( $self->{cgi}->param() ) {                                    # map cgi params into our registry module       
         foreach($self->{cgi}->param()) {                            # ? + & style urls 
            $self->{register}->set( $_, $self->{cgi}->param($_) );
         }
       
         if($self->{cgi}->param('rt') =~ m/(.*)\/(.*)/) {            # clean URL's /param/value/ style
             my @bits = split(/\//, $self->{cgi}->param('rt'));
             $self->{register}->set('rt', $bits[0]);
             for(my $i=1, my $cnt = @bits; $i<$cnt; $i++) {
                if($i % 2 == 0) { $self->{register}->set($bits[$i-1], $bits[$i]); }
             }
         }
    }
   
    return $self; 
}
 
sub run {
	my $self = shift;
	$self->{router}->route($self);    
}

# Go
SIMPLEMVC->new->run();

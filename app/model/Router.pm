=head1 NAME

app::model::Router - Router Model 

=head1 SYNOPSIS

  new
  load
  
=head1 DESCRIPTION

  app::model::Router class
  
  Heavy lifting class
  Routes requests to the correct controller
  Calls the controllers index method
  And the magic begins
  
  Calls errorController if not controller located  

=head2 Methods
=cut

package app::model::Router;

=over 4

=item * $object->new(class, param)

   Default instance for given class call   
=cut

sub new {
	my ($classname, $db) = @_;
	my $self = bless {},$classname;

	return $self;
} 

=item * $object->load

   Here be magic
   Load, route requests to the correct controller 
   Simply gracefull in PERL (check it out).
   
   Params:
     vars (application variables, see index.mpl)  
=cut

sub route {
	my ($self, $vars) = @_;
    my ($controller, $tpl, $action);
    
    # Workers
    $vars->{route}          = $vars->{register}->get('rt');                    # get route
    $vars->{controller}     = $vars->{route} . "Controller";                   # build controller      
    $vars->{file}           = $vars->{conroot} . $vars->{controller} . ".pm";  # controller we need <path>/<file>    
    
    if (! -e $vars->{file} ) {                                                 # 404 page not found
        $vars->{route}      = "error";                                         # map to error
        $vars->{controller} = $vars->{route} . "Controller";                   # errorController file
        $vars->{file}       = $vars->{conroot} . $vars->{controller} . ".pm";  # errorController file
        $vars->{error}      = $vars->{register}->get('rt');                    # error message
    }
    
    $vars->{package}        = "app::controller::$vars->{controller}";          # desired controller  
    $vars->{tpl}            = join(".", $vars->{route}, "cs");                 # desired template  
   
    if (eval{ require $vars->{file} }) {                                       # then lets use it
        $vars->{package}->new($vars)->index();                                 # create new controller and call the controller->index method
        return 1;    
    }

    print STDERR "Eval require($vars->{controller}.pm) error";                 # only gets here if we find a (syntax type) error in our controller 
}

1;

=back

=head1 AUTHOR

Mark Ibbotson (mark.ibbotson@manheim.co.uk)

=head1 COPYRIGHT

Copyright 2010 Manheim.  All rights reserved.

This library is owned by Manheim.

=head1 SEE ALSO

perl(1).

=cut
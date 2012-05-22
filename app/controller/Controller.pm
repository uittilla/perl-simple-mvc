=head1 NAME

app::controller::Controller - Parent controller 

=head1 SYNOPSIS

  package app::controller::Controller;

  loadClass 
  in_array
  process
    
=head1 DESCRIPTION

Parent controller class 

=head2 Methods

=cut

package app::controller::Controller;


=over 4

=item * $object->new(class, obj, param)

   Default instance

=cut

sub new {
	my $self = shift;
	my $class;
	my @params = @_;

    if (!ref($self)){                     # ref() tells you if its a reference
	   $class = $self;                    # if its a string, its a classname,
	   $self = bless \%params,$class;     # if its a ref, its a child object
	}

    foreach(@params) {
        foreach(keys %{$_}) {             
            $self->{$_} = $_[0]->{$_};    # death by obscurity
        }
    }
	
	$self->{tt} = $self->getTemplate();   # get this pages template
    
    # Site wide headers
    print $self->{cgi}->header("text/html");
    
    return $self; 
}


=item * $object->loadClass(class, obj, param)
   Load classes as needed
   Returns a instance of the object if $obj = true
   
   params: 
      class: class name to load
      obj  : true or false for the return an instance
      param: any addition params to pass to the new insatnce  
   
   $self->loadClass($route, 1, $vars->{db});
   
=cut

sub loadClass {
   my ($self, $class, $obj, $param) = @_;
   
   if( -e $self->{modroot} . $class . ".pm" ) {                  # does the model exist ?  
	   if( eval{ require $self->{modroot} . $class . ".pm" } ) { # try load it
	   	  if($obj) {                                             # instance requested?       
	   	  	  return "app::model::$class"->new($param);          # return one "how slack or brilliant is that!"  
	   	  }
	   } else {
	   	 return $@;			                                     # could not load class
	   }
   } else {
   	  return $@;                                                 # model does not exist 
   }
}


=item * $self->in_array(what, for, pattern)

    Allows us to check if an item already exists in a hash
	
    params: 
      what: hash to search
      for : hash to compare against
      key : hash{key} to use as comparison
   
=cut

sub in_array {
    my ($self, $what, $for, $key) = @_;
    
    # damned thing likes to fill up the log with unitialized stuff.
    no warnings 'uninitialized';
    
    foreach my $value (@$what) {
    	if(defined $value->{$key} && defined $for->{$key}) {
    	   return 1 if ($value->{$key} eq $for->{$key}); 
    	}
    }
    return 0;
}


=item * $self->process(template, param)

    Enable parsing of our pages
  
=cut

sub process {
  my ($self, $template, $param) = @_;
  $self->{tt}->process( $template, $param );    
}

=item * $self->getTemplate()

    Returns new template instance

=cut

sub getTemplate {
    my $self = shift;   
    # make the template
    return Text::ClearSilver->new(load_path => [$self->{viewroot}]);
}

1;

=back   

=head1 AUTHOR

(Ibbo)

=head1 COPYRIGHT

Copyright 2010. All rights reserved.

Do as you will

=head1 SEE ALSO

perl(1).
=cut

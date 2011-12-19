package Chat;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
  my $self = shift;

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Routes
  my $r = $self->routes;

  # Normal route to controller
  $r->route('/welcome')->to('example#welcome');
  $r->route('/chat')->to('ChatControl#chatAction');
  $r->websocket('/chatWS')->to('ChatControl#wsAction');
}

1;

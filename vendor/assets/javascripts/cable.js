// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket systems live using the rails generate channel command.
//
//= require action_cable
//= require_self
//= require_tree ../../../../app/assets/javascripts/channels

(function() {
  this.App || (this.App = {});

  App.cable = ActionCable.createConsumer();

}).call(this);

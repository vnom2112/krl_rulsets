ruleset hello_world {
  meta {
    name "Hello World"
    description <<
A first ruleset for the Quickstart
>>
    author "Phil Windley"
    logging on
    sharing on
    provides hello
 
  }
  global {
    hello = function(obj) {
      msg = "Hello " + obj
      msg
    };
 
  }
  rule hello is active {
    select when echo hello
    send_directive("say") with
      something = "Hello World";
  }
  
  rule message is active {
    select when echo message input "(.*)" setting(m)
    send_directive("say") with
      something = m;
  }
 
}

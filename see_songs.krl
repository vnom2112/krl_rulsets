ruleset see_song {
  meta {
    name "See Songs"
    description <<
Song ruleset
>>
    author "Brady Kelley"
    logging on
    sharing on
 
  }
  global {
 
  }
  
  rule songs is active {
    select when echo message msg_type re#song#
    send_directive("sing") with
      song = "This is a song";
  }
 
}

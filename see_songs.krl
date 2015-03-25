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
    select when echo message msg_type "(.*)" setting(m)
    send_directive("sing") with
      song = m;
  }
 
}
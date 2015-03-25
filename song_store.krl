ruleset song_store {
  meta {
    name "Song Store"
    description <<
All the songs that have been sung
>>
    author "Brady Kelley"
    logging on
    sharing on
    provides hymns, secular_music
  }
  global {
    songs = function(x) {
      ent:all_songs
    }
    hymns = function(x) {
      ent:hymns
    }
    secular_music = function(x) {
      ent:secular
    }
  }
  
  rule collect_songs is active {
    select when explicit sung
    pre {
      currentSongs = ent:all_songs || [];
      newSongs = currentSongs.union(time:now() + '-' + event:attr("song"));
    }
    always {
      set ent:all_songs newSongs;
    }
  }
  
  rule collect_hymns is active {
    select when explicit found_hymn
    pre {
      currentHymns = ent:hymns || [];
      newHymns = currentHymns.union(time:now() + '-' + event:attr("song"));
    }
    always {
      set ent:hymns newHymns;
    }
  }

  rule collect_secular is active {
    select when explicit found_secular
    pre {
      currentSecular = ent:secular || [];
      newSecular = currentSecular.union(time:now() + '-' + event:attr("song"));
    }
    always {
      set ent:secular newSecular;
    }
  }

  rule clear_songs is active {
    select when song reset
    always {
      clear ent:all_songs;
      clear ent:hymns;
      clear ent:secular;
    }
  }
 
}

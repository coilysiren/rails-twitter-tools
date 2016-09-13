# Rails Twitter Tools

currently powering <http://twitter-mute-till-election.herokuapp.com/>

## startup

    $ bundle install
    $ subl .env # set SECRET_KEY_BASE
    $ rake db:create db:migrate
    $ foreman start

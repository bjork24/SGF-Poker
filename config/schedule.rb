env :MAILTO, ''
env :PATH, '$PATH:/bin:/sbin:/usr/bin:/usr/sbin:/usr/local/bin:/usr/local/sbin'

every 3.minutes do
  rake "twitterbot:answer"
end
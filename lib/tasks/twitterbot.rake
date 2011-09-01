require "twitter"

Rake::Task[:environment].invoke

namespace :twitterbot do
  
  desc 'Looks for @sgfpoker and replies'
  task :answer => :environment do
    Twitter.mentions(:count => 10, :include_rts => false).each do |t|
      start = t.text[0,9].downcase
      if (start == "@sgfpoker" && !TweetTracker.tweeted_before?(t.id))
        TweetTracker.create(:tid => t.id)
        task = case t.text
          when /my stats\?/ then 'stats'
          when /last winner\?/ then 'last_winner'
          when /win tonight\?/ then 'win_tonight'
          when /help!/ then 'help'
          else 'what'
        end
        Rake::Task["twitterbot:#{task}"].invoke(t)
      end
    end
  end
  
  desc 'My Stats!'
  task :stats, :t do |t, args|
    include ActionView::Helpers
    include ApplicationHelper
    player = Player.find_by_twitter(args[:t].user.screen_name)
    if player
      message = "GAMES: #{games_played(player)} of #{total_games} / WON: #{amount_won(player)} / PROFIT: #{amount_profited(player)} / WINS: #{first_place(player)} / LAST WIN: #{last_win(player,:date,'%m.%d.%y')}"
    else
      message = "Do I know you?"
    end
    Rake::Task["twitterbot:reply"].invoke(message, args[:t])
  end
  
  desc 'Spit out the last winner'
  task :win_tonight, :t do |t, args|
    include ActionView::Helpers
    include ApplicationHelper
    today = Date.today.strftime("%a")
    tweeters = Player.has_twitter
    if today == "Thu"
      message = "My guess is that @#{tweeters[rand(tweeters.size)].twitter} is going to win tonight."
    else
      message = "Well, it's not Thursday, but if it were I'd guess @#{tweeters[rand(tweeters.size)].twitter} would win."
    end
    Rake::Task["twitterbot:reply"].invoke(message, args[:t])
  end
  
  desc 'Spit out the last winner'
  task :last_winner, :t do |t, args|
    include ActionView::Helpers
    include ApplicationHelper
    winner = last_win()
    winner_twitter = winner.twitter.present? ? winner.twitter : nil
    if (winner_twitter == args[:t].user.screen_name)
      message = "You were the last winner, fool!"
    else
      extra = winner_twitter ? " (@#{winner_twitter})" : ""
      message = "#{winner.name}#{extra} won the last game."
    end
    Rake::Task["twitterbot:reply"].invoke(message, args[:t])
  end
  
  desc 'Help me out'
  task :help, :t do |t, args|
    message = "Try tweeting at me and including \"my stats?\" or \"last winner?\" or \"win tonight?\""
    Rake::Task["twitterbot:reply"].invoke(message, args[:t])
  end
  
  desc 'No comprende'
  task :what, :t do |t, args|
    message = "What did you say to me, son?!"
    Rake::Task["twitterbot:reply"].invoke(message, args[:t])
  end
  
  desc 'Send a tweet reply'
  task :reply, :message, :t do |t, args|
    include ActionView::Helpers
    include ApplicationHelper
    reply = "@#{args[:t].user.screen_name}: #{args[:message]} #{twitter_hash}"
    Twitter.update reply, :in_reply_to_status_id => args[:t].id
    Rake::Task["twitterbot:reply"].reenable
  end
  
end
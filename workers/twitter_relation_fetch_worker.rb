class TwitterRelationFetchWorker
  include Sidekiq::Worker

  def perform(id)
    account = Account.find(id)

    twitter = Twitter::REST::Client.new do |config|
      config.consumer_key         = ENV["twitter_consumer_key"]
      config.consumer_secret      = ENV["twitter_consumer_secret"]
      config.access_token         = account.access_token
      config.access_token_secret  = account.access_token_secret
    end

    old_friend_ids = AccountRelation.where("uid = ?", account.uid).pluck(:follow_uid).map(&:to_i)
    all_friend_ids = []
    twitter.friend_ids.each do |friend_id|
      all_friend_ids << friend_id
    end
    new_friend_ids = all_friend_ids - old_friend_ids

    account_relations = new_friend_ids.map {|friend_id| AccountRelation.new(uid: account.uid, follow_uid: friend_id) }
    AccountRelation.import account_relations
  end
end

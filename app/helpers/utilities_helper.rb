module UtilitiesHelper
  def segment_track_success_register_user(user)
    Analytics.track(
        user_id: user.id,
        event: 'Signed up',
        properties: { email: user.email, registered_date: Time.new.inspect },
        timestamp: Time.new
    )
  end

  def segment_track_fail_register_user(email, error)
    Analytics.track(
        anonymous_id: Date.new.to_time.to_i,
        event: 'Fail register a new user',
        properties: { email: email, error: error, registered_date: Time.new.inspect },
        timestamp: Time.new
    )
  end

  def segment_track_visit_register_new_user()
    Analytics.track(
        anonymous_id: Date.new.to_time.to_i,
        event: 'Visited register user form',
        properties: { visited_date: Time.new.inspect },
        timestamp: Time.new
    )
  end

  def segment_track_created_article_by_user(user, article)
    Analytics.track(
        user_id: user.id,
        event: 'User created an article',
        properties: { article_id: article.id, article_title: article.title, email: user.email, created_date: Time.new.inspect },
        timestamp: Time.new
    )
  end


end
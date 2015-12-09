class Comment < ActiveRecord::Base
  belongs_to :article
  validates_presence_of :name, :email, :body
  validate :article_should_be_published
  after_create :email_article_author

  def article_should_be_published
    errors.add(:article_id, I18n.t('comments.errors.not_published_yet')) if article && !article.published?
  end

  def email_article_author
    Notifier.comment_added(self).deliver
  end
end

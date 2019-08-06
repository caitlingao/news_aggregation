class Topic < ApplicationRecord
  include SoftDelete, MarkdownBody, UserAvatarDelegate
  include Topic::Actions, Topic::AutoCorrect

  mount_uploader :banner, BannerUploader

  belongs_to :user, inverse_of: :topics
  belongs_to :node, counter_cache: true, required: false

  validates :user_id, :title, :body, :node_id, :summary, presence: true

  # counter :hits, default: 0

  delegate :login, to: :user, prefix: true, allow_nil: true
  delegate :body, to: :last_reply, prefix: true, allow_nil: true

  before_save { self.node_name = node.try(:name) || "" }

  def letter_banner_url(size)
    path = LetterAvatar.generate('topic', size).sub("public/", "/")

    "#{Setting.base_url}#{path}"
  end
end

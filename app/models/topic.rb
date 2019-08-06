class Topic < ApplicationRecord
  include SoftDelete, MarkdownBody, MentionTopic, Closeable, UserAvatarDelegate
  include Topic::Actions, Topic::AutoCorrect, Topic::RateLimit

  mount_uploader :banner, BannerUploader

  belongs_to :user, inverse_of: :topics
  belongs_to :node, counter_cache: true, required: false

  validates :user_id, :title, :body, :node_id, :summary, presence: true

  # counter :hits, default: 0

  delegate :login, to: :user, prefix: true, allow_nil: true
  delegate :body, to: :last_reply, prefix: true, allow_nil: true

  # scopes
  scope :without_node_ids,   ->(ids) { exclude_column_ids("node_id", ids) }
  scope :without_users,      ->(ids) { exclude_column_ids("user_id", ids) }
  scope :exclude_column_ids, ->(column, ids) { ids.empty? ? all : where.not(column => ids) }

  scope :without_nodes, lambda { |node_ids|
    ids = node_ids + Topic.topic_index_hide_node_ids
    ids.uniq!
    exclude_column_ids("node_id", ids)
  }

  before_save { self.node_name = node.try(:name) || "" }

  def letter_banner_url(size)
    t = title || 'Topic'
    path = LetterAvatar.generate(t, size).sub("public/", "/")

    "#{Setting.base_url}#{path}"
  end
end

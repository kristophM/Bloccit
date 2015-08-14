class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  has_one :summary
  has_many :votes
  has_many :favorites, dependent: :destroy
  mount_uploader :postimage, PostimageUploader

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  default_scope { order('rank DESC')}
  # posts = Post.ordered_by_title
  # private_posts = Post.where(private: true).ordered_by_title
  # posts_with_the = Post.where("title LIKE '%the%'").where(...).some_scope.another_scope
  # Posts.where("title like '%#{params[:q]}%'") #DANDGER
  # Posts.where("title like '%?%'", params[:q]) Protect against SQL injection (sanitization)
  # select * from posts where title like '%'; delete from users;
  scope :ordered_by_title, -> { order('title ASC') }
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }
  scope :visible_to, -> (user) { user ? all : joins(:topic).where('topics.public' => true) }


  def markdown_title
    (render_as_markdown.render title).html_safe
  end

  def markdown_body
    (render_as_markdown.render body).html_safe
  end

  def up_votes
     votes.where(value: 1).count
  end

  def down_votes
     votes.where(value: -1).count
  end

  def points
    votes.sum(:value)
  end

  def update_rank
     age_in_days = (created_at - Time.new(1970,1,1)) / (60 * 60 * 24) # 1 day in seconds
     new_rank = points + age_in_days

     update_attribute(:rank, new_rank)
  end

  def create_vote
    user.votes.create(post: self, value: 1)
  end

  def save_with_initial_vote
    ActiveRecord::Base.transaction do
      self.save!
      self.create_vote
    end
  end

private

  def render_as_markdown
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
  end

end

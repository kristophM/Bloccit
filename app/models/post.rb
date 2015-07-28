class Post < ActiveRecord::Base
  has_many :comments, dependent: :destroy
  belongs_to :user
  belongs_to :topic
  has_one :summary
  mount_uploader :postimage, PostimageUploader

  validates :title, length: {minimum: 5}, presence: true
  validates :body, length: {minimum: 20}, presence: true
  validates :topic, presence: true
  validates :user, presence: true

  default_scope { order('created_at DESC')}
  # posts = Post.ordered_by_title
  # private_posts = Post.where(private: true).ordered_by_title
  # posts_with_the = Post.where("title LIKE '%the%'").where(...).some_scope.another_scope
  # Posts.where("title like '%#{params[:q]}%'") #DANDGER
  # Posts.where("title like '%?%'", params[:q]) Protect against SQL injection (sanitization) 
  # select * from posts where title like '%'; delete from users;
  scope :ordered_by_title, -> { order('title ASC') }
  scope :ordered_by_reverse_created_at, -> { order('created_at ASC') }

  def markdown_title
    (render_as_markdown.render title).html_safe
  end

  def markdown_body
    (render_as_markdown.render body).html_safe
  end


private

  def render_as_markdown
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
  end

end

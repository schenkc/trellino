class User < ActiveRecord::Base
  attr_reader :password

  validates :email, presence: true, uniqueness: true
  validates :session_token, presence: true, uniqueness: true
  validates :password_digest, presence: true
  validates :password, length: { minimum: 6, allow_nil: true }

  before_validation :ensure_session_token

  has_many(
    :memberships,
    class_name: "FriendCircleMembership",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  )

  has_many :circles, through: :memberships, source: :circle, inverse_of: :members
  has_many :friend_posts, through: :circles, source: :posts

  has_many(
    :owned_circles,
    class_name: "FriendCircle",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :owner
  )

  has_many(
    :posts,
    class_name: "Post",
    foreign_key: :user_id,
    primary_key: :id,
    inverse_of: :user
  )

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def self.find_by_credentials(email, password)
    user = User.find_by(email: email)
    user.try(:is_password?, password) ? user : nil
  end

  def self.generate_session_token
    SecureRandom::urlsafe_base64(16)
  end

  def reset_session_token!
    self.session_token = self.class.generate_session_token
    self.save! #WANT TO FAIL SILENTLY? NO!
    self.session_token
  end

  def ensure_session_token
    self.session_token ||= self.class.generate_session_token
  end

  def reset_password_token!
    self.reset_password_token = SecureRandom::urlsafe_base64(16)
    self.save!
    self.reset_password_token
  end

end
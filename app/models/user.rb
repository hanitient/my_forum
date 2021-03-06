class User < ActiveRecord::Base
   has_many :diys,dependent: :destroy
   has_many :orders,dependent: :destroy

	#创建一个可访问的令牌属性
	attr_accessor :remember_token, :activation_token, :reset_token
	#把电子邮箱转换成小写以保证唯一性
   before_save:downcase_email

    before_create :create_activation_digest

	#validates :invitation, presence: true
    #各种注册时的验证
	validates :name, presence: true, length: { maximum: 50 }

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :email, presence: true, length: { maximum: 255 },
	format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sensitive: false }

  validates :address1, presence: true


    #使密码转换成哈希值
    has_secure_password
    validates :password, length: { minimum: 6 }, allow_blank: true

  #返回指定字符串的哈希摘要
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
    BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  #返回一个随机令牌
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  #在数据库中记住令牌
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end
  #忘记用户
  def forget
    update_attribute(:remember_digest, nil)
  end
  #如果指定的令牌和摘要匹配，返回true
  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def activate
    update_attribute(:activated,true)
    update_attribute(:activated_at, Time.zone.now)
  end

  def send_activation_email
    UserMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = User.new_token
    update_attribute(:reset_digest, User.digest(reset_token))
    update_attribute(:reset_sent_at, Time.zone.now)
  end

  def send_password_reset_email
    UserMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 2.hours.ago
  end

  private
   def downcase_email
    self.email = email.downcase
   end

   def create_activation_digest
    self.activation_token = User.new_token
    self.activation_digest = User.digest(activation_token)
   end



end

require 'digest'
class User < ActiveRecord::Base
  attr_accessor :password
  attr_accessible :username, :email, :password, :password_confirmation

  has_many :workouts, :dependent => :destroy

  validates :username, :presence => true,
            :length => { :maximum => 50 },
            :uniqueness => { :case_sensitive => false }
  validates :email, :presence => true,
            :uniqueness => { :case_senstive => false }
  validates :password, :presence => true, :length => { :within => 6..40 }, :confirmation => true

  before_save :encrypt_password

  def has_password?(submitted_password)
    encrypted_password == encrypt(submitted_password)
  end

  def self.authenticate(username,submitted_password)
		user = find(:first, :conditions => [ "lower(username) = ?", username.downcase])
		return nil if user.nil?
		return user if user.has_password?(submitted_password)
  end

	def self.authenticate_with_salt(id, cookie_salt)
		user = find_by_id(id)
		(user && user.salt == cookie_salt) ? user : nil
  end

  def has_bodyweight?
    workouts.each do |workout|
      return true unless workout.bodyweight.blank?
    end
    return false
  end

  def has_exercise?(name)
    workouts.each do |workout|
      if w = workout.find_exercise_by_name(name)
        return true unless w.exercise_sets.empty?
      end
    end
    return false
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!(:validate => false)
    UserMailer.password_reset(self).deliver
  end

  private

    def encrypt_password
      self.salt = make_salt unless has_password?(password)
      self.encrypted_password = encrypt(password)
    end

    def encrypt(string)
      secure_hash("#{salt}--#{string}")
    end

    def make_salt
      secure_hash("#{Time.now.utc}--#{password}")
    end

    def secure_hash(string)
      Digest::SHA2.hexdigest(string)
    end

    def generate_token(column)
      begin
        self[column] = SecureRandom.urlsafe_base64
      end while User.exists?(column => self[column])
    end
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[azure_activedirectory_v2]


  belongs_to :faculty, optional: true
  belongs_to :subject, optional: true
  has_many :reports
  has_many :notifications

  def self.from_omniauth(auth)
	  where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.name = auth.info.name
      user.password = Devise.friendly_token[0,20]
      user.reset_password_token = "#{user.email}#{user.password}"
	  end
  end

  def read_notification!
    notifications.update_all(have_read: true)
  end

  def get_role
    user_roles = ""
    if role.include?("staff")
      user_roles += "Nhan Vien, "
    end
    if role.include?("teacher")
      user_roles += "Giang Vien, "
    end
    if role.include?("subject")
      user_roles += "Bo Mon, "
    end
    if role.include?("faculty")
      user_roles += "Ban Chu Nhiem Khoa, "
    end
    if role.include?("admin")
      user_roles += "Administrator"
    end
    user_roles
  end
end

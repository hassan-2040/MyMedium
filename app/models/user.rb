class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :stories, dependent: :destroy
         has_many :likes, dependent: :destroy
         has_many :bookmarks, dependent: :destroy

         has_many :following_followships, class_name: 'Followship', foreign_key: 'follower_id', dependent: :destroy
         has_many :followings, through: :following_followships, dependent: :destroy

         has_many :follower_followships, class_name: 'Followship', foreign_key: 'following_id', dependent: :destroy
         has_many :followers, through: :follower_followships, dependent: :destroy


         def likes?(story)
           story.likes.where(user_id: id).any?
         end
         def bookmarks?(story)
           story.bookmarks.where(user_id: id).any?
         end
end

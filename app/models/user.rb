class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

         has_many :stories, dependent: :destroy
         has_many :likes, dependent: :destroy
         has_many :bookmarks, dependent: :destroy

         def likes?(story)
           story.likes.where(user_id: id).any?
         end
         def bookmarks?(story)
           story.bookmarks.where(user_id: id).any?
         end
end

class Story < ActiveRecord::Base
    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :bookmarks, dependent: :destroy
end

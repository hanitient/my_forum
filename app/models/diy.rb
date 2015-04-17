class Diy < ActiveRecord::Base
    belongs_to :user
    default_scope -> { order(created_at: :desc) }
    validates :user_id, presence: true
    

	validates :name    , presence: true
	validates :describe, presence: true
end

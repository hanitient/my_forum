class Tea < ActiveRecord::Base
  #验证
  validates :name, presence: true,uniqueness: true
  validates :kind, presence: true
  validates :describe, presence: true
  validates :price, presence: true

  #按照时间倒序排列
  default_scope -> { order(created_at: :desc) }




end


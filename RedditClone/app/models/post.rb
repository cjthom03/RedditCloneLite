# == Schema Information
#
# Table name: posts
#
#  id         :bigint(8)        not null, primary key
#  title      :string           not null
#  url        :string
#  content    :text
#  author_id  :integer          not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Post < ApplicationRecord
  validates :title, presence:true
  belongs_to :author,
    class_name: :User
  
  has_many :post_subs,
    foreign_key: :post_id,
    class_name: :PostSub,
    inverse_of: :post,
    dependent: :destroy
      
  has_many :subs,
    through: :post_subs,
    source: :sub
    
  has_many :moderators, #might not be needed yet
    through: :subs,
    source: :moderator
    
  has_many :comments,
    dependent: :destroy
end

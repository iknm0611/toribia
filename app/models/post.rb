class Post < ApplicationRecord

   belongs_to :user

   attachment :image

   has_many :favorites, dependent: :destroy
   has_many :users, through: :favorites
   has_many :favorited_users, through: :favorites, source: :user
   has_many :comments, dependent: :destroy

   def favorited_by?(user)
		favorites.where(user_id: user.id).exists?
	end

	def self.search(keyword)
      where(["title LIKE? OR body LIKE?", "%#{keyword}%", "%#{keyword}%"])
   end

   def self.sort(selection)
    case selection
    when 'new'
      return all.order(created_at: :DESC)
    when 'old'
      return all.order(created_at: :ASC)
    when 'likes'
      return find(Favorite.group(:post_id).order(Arel.sql('count(post_id) desc')).pluck(:post_id))
    when 'dislikes'
      return find(Favorite.group(:post_id).order(Arel.sql('count(post_id) asc')).pluck(:post_id))
    end
  end

end

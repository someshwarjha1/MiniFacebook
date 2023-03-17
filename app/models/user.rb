class User < ApplicationRecord
    has_many :messagee, foreign_key: :receiver_id, class_name: 'Message'  
    has_many :senders, through: :messagee
    has_many :messaged, foreign_key: :sender_id, class_name: 'Message'
    has_many :receivers, through: :messaged
  has_many :posts
    has_many :comments 
    has_many :likes
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:trackable,:confirmable

  has_many :friendships
  has_many :friends, through: :friendships
  # has_many :pending_friendships, -> { where(status: 'pending') }, class_name: 'Friendship', foreign_key: 'friend_id'
  
  def send_friend_request(friend_id)
    friendships.create(friend: friend_id, status: 'pending')

  end

  def pending_friends
    # pending_friendships.map(&:user)
    Friendship.where("friend_id = ? and status = 'pending'",self.id).map do |friendship|
      friendship.user
    end
  end

  def all_friends
 
    Friendship.where("(user_id = ? OR friend_id = ?) and status = 'accepted'", self.id, self.id).map do |friendship|
      friendship.user == self ? friendship.friend : friendship.user
    end
  end



  # def accept_friend_request(user_id, friend_id)
  #   frnd = friendships.where(user_id:user_id, friend_id: friend_id)
  #   frnd.update(status:'accepted')
  # end
end

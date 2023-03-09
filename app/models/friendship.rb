class Friendship < ApplicationRecord
    belongs_to :user
    belongs_to :friend, class_name: "User"

    
    def accept_friend_request
        Friendship.update(status: 'accepted')
    end

    def decline_friend_request
        Friendship.update(status: 'declined')
    end
end

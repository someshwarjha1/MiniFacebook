class Users::DisplayController < ApplicationController
    def index
        @users = User.all     
    end

    def send_friend_request
        friend_id = User.find(params[:friend_id])
        current_user.send_friend_request(friend_id)
        friend_request = Friendship.where("user_id = ? and friend_id = ?",current_user.id, friend_id).select("status")
        requested_friend = Friendship.where("user_id = ? and friend_id = ?",current_user.id, friend_id)
        puts requested_friend[0].friend
        puts friend_request
        if friend_request == 'pending'
            FriendRequestMailer.friend_request_reminder(requested_friend[0].friend).delay(run_at: 1.minute.from_now).deliver_later
        end
        redirect_to root_path, notice: 'Friend request sent!'
    end

    def accept_friend_request
        friend = Friendship.where(user_id:set_params["format"],friend_id:current_user.id)
        friend.update(status:'accepted')
        redirect_to friend_requests_path
    end

    def show_friend_request
        # friend_requests = current_user.friendships.where("status like 'pending'") 
        # friend_ids = friend_requests.select("friend_id") 
        # lst_of_ids = friend_ids.pluck(:friend_id) 
        # @pending_friends = User.where(id:lst_of_ids) 

        # @pending_friends = current_user.pending_friends

    end

    def show_friends 
#         friends_ids_1 = Friendship.where(user_id:current_user.id,status:'accepted').pluck('friend_id')
#         friends = User.where(id:friends_ids_1)
        
#         friends_ids_2 = Friendship.where(friend_id:current_user.id,status:'accepted').pluck('user_id')
#         friends_2 = User.where(id:friends_ids_2)

# \
#         if !friends.empty? && !friends_2.empty?
#             @friend = friends.merge(friends_2)
#         else 
#             if friends.empty?
#                 @friend = friends_2 
#             elsif friends_2.empty?
#                 @friend = friends 
#             end
            
#         end

    
    end


    private

    def set_params
        params.permit(:format)
    end
end

class FriendshipsController < ApplicationController

    def destroy
        friendship = Friendship.where("(user_id=? or friend_id= ?) AND (user_id = ? or friend_id = ?)", current_user.id, current_user.id,params[:id], params[:id])
        if friendship[0].destroy
            redirect_to root_path, notice: 'Un friend attempt successfull'
        else 
            render home_path

        end
    end
    

end

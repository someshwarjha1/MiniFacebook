class FriendRequestMailer < ApplicationMailer
    def friend_request_reminder(user)
        @user = user
        mail to: user.email, subject: "Reminder: friend request pending"
    end
end

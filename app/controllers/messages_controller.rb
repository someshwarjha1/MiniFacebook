class MessagesController < ApplicationController
    def show 
        @sender = User.find(current_user.id)
        @receiver = User.find(params[:id])
        @messages = Message.where(sender_id: @sender.id, receiver_id: @receiver.id).or(Message.where(sender_id: @receiver.id, receiver_id: @sender.id))
        @chat_id = [@sender.id, @receiver.id].sort.join("") 
    end 
    def create 
        message = Message.create(sender_id: params[:sender_id], receiver_id: params[:receiver_id], text: params[:message])
        SendMessageJob.perform_later(message)
    end 
end



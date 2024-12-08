class Api::SubscriptionsController < ApplicationController

    def destroy 
        subscription = current_user.subscriptions.find_by(author_id: params[:id])
        subscription.destroy if subscription
        render json: { message: "Subscription has been cancelled." }
    end

    def create
        author = User.find(params[:author_id])
        current_user.subscriptions.create(author: author)
        render json: { message: "You have successfully subscribed." }
    end
end

module Api
  module V1
  	class DustbinsController < ApplicationController
      #before_action :is_developer_registered, only: [:create, :update, :destroy]
      before_action :set_dustbin, only: [:show, :update, :destroy, :install, :uninstall]
      before_action :set_dustbin_by_uid, only: [:update_status]

      #before_action :require_developer, only: [:update, :destroy]

      ITEMS_PER_PAGE = 10

  	  def index
        @dustbins = Dustbin.all

        if @dustbins.count == 0
          render json: { errors: ["Empty."] }, status: 400 and return
        end

  	  	@dustbins = @dustbins.offset((@page_no - 1) * ITEMS_PER_PAGE).limit(ITEMS_PER_PAGE)
        render json: { :data => @dustbins }
  	  end

  	  def show
        render json: @dustbin
  	  end

      def create
        @dustbin = Dustbin.new(dustbin_params)
        #@dustbin.developer = current_user

        if @dustbin.save
          render json: @dustbin
        else
           render json: { errors: ["Invalid attributes."] }, status: 400
        end
      end

      def update
        if @dustbin.update(dustbin_params)
          render json: @dustbin
        else
          render json: { errors: ["Invalid attributes."] }, status: 400
        end
      end

      def update_status
        @dustbin.status = params[:status]
        if @dustbin.save
          render json: @dustbin
        else
          render json: { errors: ["Invalid attributes."] }, status: 400
        end
      end

      def destroy
        if @dustbin.destroy
          render json: { messages: ["Deletion successful."] }, status: 200
        else
          render json: { errors: ["Deletion failed."] }, status: 500
        end
      end

      private

      def set_dustbin
        begin
          @dustbin = Dustbin.find(params[:id]) #Any response when wrong id
        rescue
          render status: :not_found, json: { errors: ["Not Found."] }
        end
      end

      def set_dustbin_by_uid
        @dustbin = Dustbin.where(unique_id: 1234).first #Any response when wrong id
        if @dustbin == nil
          render status: :not_found, json: { errors: ["Not Found."] }
        end
      end

      #def is_developer_registered
      #  if current_user.is_developer == false
      #    render json: { errors: ["Authorized users only."] }, status: :unauthorized
      #  end
      #end

      #def require_developer
      #  if current_user != @dustbin.developer
      #    render json: { errors: ["Authorized users only."] }, status: :unauthorized
      #  end
      #end

      def dustbin_params
        params.require(:dustbin).permit(:name, :gps_longitude, :gps_latitude, :worker, :city, :support_number, :status, :unique_id)
      end

  	end
  end
end
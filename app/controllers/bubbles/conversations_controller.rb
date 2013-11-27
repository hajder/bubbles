require_dependency "bubbles/application_controller"

module Bubbles
  class ConversationsController < ApplicationController
    include ConversationsHelper
    before_action :set_conversation, only: [:show, :update]
    before_action :authorize_member!, only: [:show, :update]

    # GET /conversations
    def index
      @conversations = current_sender.conversations
    end

    # GET /conversations/1
    def show
      @conversation.mark_as_read!(current_sender)
    end

    # GET /conversations/new
    def new
      @conversation = Conversation.new
      if params[:to]
        @conversation.members << Bubbles.messagable_type.constantize.find(params[:to])
      end
    end
    
    # POST /conversations
    def create
      @conversation = Conversation.new(conversation_params)
      @conversation.members << current_sender
      msg = @conversation.messages.build(message_params)
      msg.sender = current_sender
      msg.conversation = @conversation
      
      if @conversation.save
        redirect_to @conversation, notice: 'Conversation was successfully created.'
      else
        render action: 'new'
      end
    end

    # PATCH/PUT /conversations/1
    def update
      unless message_params[:body].blank?
        @conversation.messages.build(message_params).sender = current_sender
      end
      @conversation.members << conversation_params[:member_ids].map do |id|
        Bubbles.messagable_type.constantize.find(id)
      end
      
      if @conversation.save
        redirect_to @conversation, notice: 'Conversation was successfully updated.'
      else
        render action: 'edit'
      end
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_conversation
        @conversation = Conversation.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def conversation_params
        params.fetch(:conversation, {member_ids: []}).permit(member_ids: [])
      end
      
      def message_params
        params.require(:message).permit(:body)
      end
      
      def authorize_member!
        unless @conversation.members.include? current_sender
          redirect_to conversations_path, status: 401
        end
      end
  end
end

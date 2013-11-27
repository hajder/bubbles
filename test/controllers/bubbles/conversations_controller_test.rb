require 'test_helper'

module Bubbles
  class ConversationsControllerTest < ActionController::TestCase
    setup do
      @conversation = bubbles_conversations(:one)
    end

    test "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:conversations)
    end

    test "should get new" do
      get :new
      assert_response :success
    end

    test "should create conversation" do
      assert_difference('Conversation.count') do
        post :create, conversation: { member_ids: [users(:two).id] }, message: { body: 'asdf' }
      end

      assert_redirected_to conversation_path(assigns(:conversation))
    end

    test "should show conversation" do
      get :show, id: @conversation
      assert_response :success
    end

    test "should update conversation" do
      @conversation.members << users(:two)
      assert_difference('Message.count') do
        patch :update, id: @conversation, conversation: { member_ids: [] }, message: { body: 'asdf' }
      end
      assert_redirected_to conversation_path(assigns(:conversation))
    end
    
    test "should not add new message if body is blank" do
      @conversation.members << users(:two)
      assert_no_difference('Message.count') do
        patch :update, id: @conversation, conversation: { member_ids: [] }, message: { body: '' }
      end
    end
    
    test "should update adding new members to conversation" do
      @conversation.members << users(:two)
      patch :update, id: @conversation, conversation: { member_ids: [users(:three).id] }, message: { body: '' }
      assert_redirected_to conversation_path(assigns(:conversation))
      assert assigns(:conversation).members.include?(users(:three))
    end
    
    test "should authorize conversation member before show" do
      get :show, id: bubbles_conversations(:two)
      assert_response 401
    end
    
    test "should authorize conversation member before update" do
      patch :update, id: bubbles_conversations(:two), conversation: { member_ids: [] }, message: { body: 'asdf' }
      assert_response 401
    end
  end
end

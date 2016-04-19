class ChatController < ApplicationController
  def index
    @viewModel = CharViewModel.new
    case params[:lang]
    when 'cn'
      @viewModel.title = '小白'
      @viewModel.message_placeholder = '输入消息...'
      @viewModel.message_button = '发送'
    else
      @viewModel.title = 'baibai'
      @viewModel.message_placeholder = 'Type message...'
      @viewModel.message_button = 'Send'
    end
  end
end

class CharViewModel
  attr_accessor :title, :message_placeholder, :message_button
end
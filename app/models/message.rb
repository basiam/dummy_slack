class Message < ApplicationRecord
  #after_create_commit { MessageBroadcastJob.perform_later self }
  after_create_commit { ActionCable.server.broadcast 'room_channel', message: render_message(self) }

  private

  def render_message(message)
    ApplicationController.renderer.render(partial: 'messages/message', locals: { message: message })
  end
end

class DashboardController < ApplicationController
  def index
    @consultations = policy_scope(Consultation)
    @consultations = Consultation.where(asker_id: current_user.id)
    authorize @consultations
    @chatroom = Chatroom.first
  end
end

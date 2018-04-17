class EventsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :authenticate_user!
  before_action :user_is_admin?
  before_action :find_events, only: %i[index]
  before_action :find_event, only: %i[edit update destroy]

  def index; end

  def new; end

  def create
    event = Event.new(event_param)
    if event.save
      redirect_to edit_event_path(event)
    else
      render :new
    end
  end

  def edit; end

  def update
    @event.update(event_param)
    redirect_to events_path
  end

  def destroy
    @event.destroy
    redirect_to events_path, status: 303
  end

  private def find_events
    @events = Event.order(id: :asc).with_attached_image
  end

  private def find_event
    @event = Event.find_by(id: params[:id])
    render_not_found if @event.nil?
  end

  private def event_param
    params.require(:event).permit(:name, :link, :description, :started_at, :finished_at, :image)
  end
end

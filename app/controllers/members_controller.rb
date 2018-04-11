class MembersController < ApplicationController
  skip_before_action :verify_authenticity_token, only: %i[create update destroy]
  before_action :authenticate_user!
  before_action :user_is_admin?
  before_action :find_members, only: %i[index]
  before_action :find_member, only: %i[edit update destroy]

  def index; end

  def create
    member = Member.new(member_params)
    redirect_to edit_member_path(member) if member.save
  end

  def edit; end

  def update
    @member.update(member_params)
    redirect_to members_path
  end

  def destroy
    @member.destroy
    redirect_to members_path, status: 303
  end

  private def find_members
    @members = Member.order(id: :asc).with_attached_avatar
  end

  private def find_member
    @member = Member.find_by(id: params[:id])
    render_not_found if @member.nil?
  end

  private def member_params
    params.require(:member).permit(:name, :description, :date_from, :date_to, :active, :avatar, :user_id)
  end
end

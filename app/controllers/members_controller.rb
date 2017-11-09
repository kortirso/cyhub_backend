class MembersController < ApplicationController
    skip_before_action :verify_authenticity_token, only: %i[create update destroy]
    before_action :authenticate_user!
    before_action :user_is_admin?
    before_action :find_members, only: %i[index]
    before_action :find_member, only: %i[edit update destroy]

    def index; end

    def create
        member = Member.new(member_params.merge(user_id: params[:user_id]))
        if member.save!
            redirect_to edit_member_path(member)
        end
    end

    def edit; end

    def update
        @member.update(member_params)
        redirect_to members_path
    end

    def destroy
        @member.destroy
    end

    private

    def find_members
        @members = Member.order(id: :asc)
    end

    def find_member
        @member = Member.find_by(id: params[:id])
        render_not_found if @member.nil?
    end

    def member_params
        params.permit(:name, :description)
    end
end

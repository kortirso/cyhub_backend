module Api
    module V1
        class MembersController < Api::V1::BaseController
            skip_before_action :authenticate

            def index
                render json: { members: ActiveModel::Serializer::CollectionSerializer.new(Member.active, each_serializer: MemberSerializer) }, status: 200
            end
        end
    end
end

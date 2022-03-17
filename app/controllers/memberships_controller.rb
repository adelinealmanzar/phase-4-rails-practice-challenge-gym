class MembershipsController < ApplicationController
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_res

    def index
        memberships = Membership.all
        render json: memberships, include: :client, status: :ok
    end

    def create
        new_membership = Membership.create!(membership_params)
        render json: new_membership, status: :created
    end

    private

    def membership_params
        params.permit(:gym_id, :client_id, :charge)
    end

    def render_invalid_res(invalid)
        render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end
end

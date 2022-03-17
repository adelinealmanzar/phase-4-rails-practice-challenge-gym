class ClientsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_res

    def index
        clients = Client.all
        render json: clients, status: :ok
    end


    def show
        client = find_client
        render json: client, only: [:name, :age], methods: [:membership_total], status: :ok
    end

    def create
        new_client = Client.create(client_params)
        render json: new_client, status: :created
    end

    def update
        client = find_client
        client.update(client_params)
        render json: client, status: :accepted
    end


    private

    def find_client
        Client.find(params[:id])
    end

    def client_params
        params.permit(:name, :age)
    end

    # why isn't this working?
    def membership_total
        client = find_client
        client.memberships.pluck(:charge).sum
    end

    def render_not_found_res
        render json: { errors: "Client not found" }, status: :not_found
    end

end

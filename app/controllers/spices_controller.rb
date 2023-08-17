class SpicesController < ApplicationController
    def index
        spices = Spice.all
        render json: spices, status: :ok
    end

    def create
        spice = Spice.create(spice_params)
        render json: spice, status: :created
    end

    def update
        spice = find_spice_by_id
        if spice
            spice.update(spice_params)
            render json: spice, status: :ok
        else
            render_not_found
        end
    end

    def destroy
        spice = find_spice_by_id
        if spice 
            spice.destroy
            head :no_content
        else
            render_not_found
        end
    end

    private

    def spice_params
        params.permit(:title, :image, :description, :notes, :rating)
    end

    def find_spice_by_id
        Spice.find_by(id: params[:id])
    end

    def render_not_found
        render json: {error: "Spice not found"}, status: :not_found
    end
end

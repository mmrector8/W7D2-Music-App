class BandsController < ApplicationController
    before_action :set_band, only: [:show, :edit, :update, :destroy]

    def set_band
        @band = Band.find_by(id: params[:id])
    end

    def show
        set_band
        @band = Band.find_by(id: params[:id])
        render :show
    end

    def new
        @band = Band.new
    end

    def index
        @bands = Band.all
        render :index
    end

    def create 
        @band = Band.new(band_params)
        if @band.save
            render json: 'saved!'
        else
            render json: 'whoops!'
        end
    end

    def edit
        render :edit
    end

    def update
        set_band

        if @band.update(band_params)
            redirect_to band_url(@band)
        else
            render :edit
        end
    end

    def destroy
        band = Band.find_by(id: params[:id])
        band.destroy
    end

    private

    def band_params
        params.require(:band).permit(:name)
    end
    
end
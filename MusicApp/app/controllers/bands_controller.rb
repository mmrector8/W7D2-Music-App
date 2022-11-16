class BandsController < ApplicationController
    before_action :set_band, only: [:show, :edit, :update, :destroy]

    def set_band
        @band = Band.find_by(name: params[:name])
    end

    def show
        set_band
    end
end
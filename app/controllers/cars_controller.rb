class CarsController < ApplicationController

    def index
        render json: Car.all
    end

    def showSingle
        render json: Car.findSingle(params["id"])
    end

    def show
        render json: Car.find(params["id"])
    end

    def create
        render json: Car.create(params["car"])
    end

    def delete
        render json: Car.delete(params["id"])
    end

    def update
        render json: Car.update(params["id"], params["car"])
    end

    # FILTERS

    def filterType
        render json: Car.filterType(params["id"], params["type"])
    end
end
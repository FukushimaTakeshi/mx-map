class OffRoadCircuitsController < ApplicationController
  def show
    @off_road_circuit = OffRoadCircuit.find(params[:id])
  end

  def edit
    @off_road_circuit = OffRoadCircuit.find(params[:id])
  end

  def update
    @off_road_circuit = OffRoadCircuit.find(params[:id])

    if @off_road_circuit.update(off_road_circuit_params)
      redirect_to @off_road_circuit
    else
      render 'edit'
    end
  end

  def destroy
    OffRoadCircuit.find(params[:id]).destroy
  end

  private

  def off_road_circuit_params
    params.require(:off_road_circuit).permit(
      :name,
      :address,
      :url,
      :place_id,
      :prefecture_id,
      :region_id
    )
  end
end

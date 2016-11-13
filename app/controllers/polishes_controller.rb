class PolishesController < ApplicationController
  def new
    @polish = Polish.new
    @polish_types = ['Metallics', 'Mattes', 'Effects', 'None']
    @brands = ['Essie', 'butter London', 'OPI']
    @color_groups = ['Pinks', 'Neutrals', 'Grays', 'Corals', 'Reds', 'Plums', 'Deeps', 'Blues', 'Greens']
  end

  def index
    @polishes = Polish.all
  end

  def create
    @polish = Polish.new(polish_params)
    @polish_types = ['Metallics', 'Mattes', 'Effects', 'None']
    @brands = ['Essie', 'butter London', 'OPI']
    @color_groups = ['Pinks', 'Neutrals', 'Grays', 'Corals', 'Reds', 'Plums', 'Deeps', 'Blues', 'Greens']
    if @polish.save
      redirect_to :action => :index
    else
      Rails.logger.info(@polish.errors.inspect)
      render 'new'
    end
  end

  def destroy
    Polish.find(params[:id]).destroy
    redirect_to polishes_path
  end

  private

  def polish_params
    params.require(:polish).permit(
    :brand_name,
    :color_name,
    :brand_number,
    :upc,
    :color_group,
    :polish_type,
    :hex_color,
    :description,
    :image_url)
  end
end

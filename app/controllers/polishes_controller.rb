class PolishesController < ApplicationController
  def new
    @polish = Polish.new
    @polish_types = ['Metallics', 'Mattes', 'Effects', 'None']
    @brands = ['Essie', 'butter London', 'OPI']
    @color_groups = ['Pinks', 'Neutrals', 'Grays', 'Corals', 'Reds', 'Plums', 'Deeps', 'Blues', 'Greens']
  end

  def index
    @polishes = Polish.all
    @button_strings = ['FTW!', 'are the best', 'are for winners', 'are for beautiful people', '- the best thing since sliced bread', 'brighten up any look', 'are so hot right now', 'look fabulous with your skin tone', 'are perfect for this season', 'are a winning choice', 'command respect']
  end

  def show
    @polish = Polish.find(params[:id])
  end

  def edit
    @polish = Polish.find(params[:id])
    @polish_types = ['Metallics', 'Mattes', 'Effects', 'None']
    @brands = ['Essie', 'butter London', 'OPI']
    @color_groups = ['Pinks', 'Neutrals', 'Grays', 'Corals', 'Reds', 'Plums', 'Deeps', 'Blues', 'Greens']
  end

  def update
    @polish = Polish.find(params[:id])
    if @polish.update(polish_params)
      flash[:notice] = "Successfully updated nail polish"
      redirect_to polishes_path
    else
      Rails.logger.info(@polish.errors.inspect)
      render :edit
    end
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

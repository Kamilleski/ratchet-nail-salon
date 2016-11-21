class PolishesController < ApplicationController
  def new
    @polish = Polish.new
    @polish_types = ['Metallics', 'Mattes', 'Effects', 'None']
    @brands = ['Essie', 'butter London', 'OPI']
    @color_groups = ['Pinks', 'Neutrals', 'Grays', 'Corals', 'Reds', 'Plums', 'Deeps', 'Blues', 'Greens']
  end

  def index
    @button_strings = ['FTW!', 'are the best', 'are for winners', 'are for beautiful people', ': best thing since sliced bread?', 'brighten up any look', 'are so hot right now', 'look fabulous with your skin tone', 'are perfect for this season', 'are a winning choice', 'command respect', 'work with any nail shape', 'increase productivity', 'are a festive choice', 'enhance any style']
    @polish_types = ['Metallics', 'Mattes', 'Effects', 'None']
    @brands = ['Essie', 'butter London', 'OPI']
    @color_groups = ['Pinks', 'Neutrals', 'Grays', 'Corals', 'Reds', 'Plums', 'Deeps', 'Blues', 'Greens']

    @filterrific = initialize_filterrific(
      Polish,
      params[:filterrific],
      select_options: {
        sorted_by: Polish.options_for_sorted_by,
        with_color_group: @color_groups,
        with_polish_type: @polish_types,
        with_brand_name: @brands
      },
    ) or return
    @polishes = @filterrific.find.page(params[:page])

    respond_to do |format|
      format.html
      format.js
    end
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

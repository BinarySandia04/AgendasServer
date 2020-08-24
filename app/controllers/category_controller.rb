class CategoryController < ApplicationController
  def create
    @user = current_user
    @group = get_group(params[:groupcode])

    unless Group.has_right_permissions(@group, @user, [0, 1])
      flash[:red] = "Error"
      redirect_to root_url
    end
  end

  def create_post
    @user = current_user
    @group = get_group(params[:groupcode])

    unless Group.has_right_permissions(@group, @user, [0, 1])
      flash[:red] = "Error"
      redirect_to root_url
    end

    if params[:name].include? '>' or params[:name].include? '<'
      flash[:red] = "El nom no es vàlid"
      redirect_to '/group/create/' + params[:groupcode] + '/category'
      return
    end

    unless Category.where(group_id: @group.id, name: params[:name]).present?
      # Crear la categoria
      category = Category.new
      category.accentcolor = Utils::Color.fromHex(params[:color]).toInt
      category.group_id = @group.id
      category.name = params[:name]
      category.desc = params[:desc]

      if category.save
        # TODO: API
        flash[:green] = "S'ha creat la categoria " + params[:name] + " correctament!"
        redirect_to '/group/view/' + params[:groupcode]
      else
        flash[:red] = "Error"
        redirect_to root_url
      end
    else
      flash[:red] = "Ja existeix una categoria amb aquest nom!"
      redirect_to '/group/create/' + params[:groupcode] + '/category'
    end
  end
end

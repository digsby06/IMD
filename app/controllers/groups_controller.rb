class GroupsController < ApplicationController
before_filter :authenticate_user!, except: [:index, :render_uploads, :groups_count, :render_uploads_pagination]

  def new
    @group = Group.new
    @uploads = Upload.all
  end

  def create
    content_validations

    if @images
      create_gallery
    else
      create_upload
    end
  end

  def index
    @groups = paginate Group.all, per_page: 6
    @groups_count = Group.all.count
    @ambient_content_count = Upload.ambient_content.count
    @last_updated = Upload.last_updated
    render :layout => 'display'
  end

  def groups_count
    @groups_count = Group.all
    render :json => @groups_count.count.to_json
  end

  def render_uploads
    @groups = paginate Group.all, per_page: 6
    render partial: 'uploads.html.slim', locals: { groups: @groups}
  end

  def render_uploads_pagination
    @groups = paginate Group.all, per_page: 6
    render partial: 'pagination.html.slim', locals: { groups: @groups}
  end


  protected

  def create_gallery
    @group = Group.new
    if @group.save
      if params[:upload][:files]
        params[:upload][:files].each { |file|
          if has_image file
            @upload = Upload.create(user_id: current_user.id, file: file, group_id: @group.id, name: params[:upload][:name])
          else
            save_upload file
          end
        }
        flash[:success] = "Upload Succesful."
      else
        flash[:danger] = "Select at least a file to proceed."
      end
      redirect_to new_group_path and return
    end
  end

  def create_upload
    params[:upload][:files].each { |file|
      save_upload file
    }
    flash[:success] = "Upload Succesful."
    redirect_to new_group_path and return
  end

  def save_upload file
    @group2 = Group.new
    if @group2.save
      @upload = Upload.create!(user_id: current_user.id, file: file, group_id: @group2.id, name: params[:upload][:name])
      if !@upload.valid?
        @group2.destroy
      end
    end
  end

  def content_validations
    @images = false
    params[:upload][:files].each { |file|
      if !correct_content_type file
        flash[:danger] = 'Only Images, Videos, or PDF files are allowed.'
        redirect_to new_group_path and return
      else
        if has_image file
          @images = true
        end
      end
    }
  end

  def correct_content_type file
    acceptable_types = ['image/jpg', 'image/jpeg', 'image/gif', 'image/png', 'video/mp4', 'video/m4v', 'video/webm', 'video/ogg', 'application/pdf']
    acceptable_types.include? file.content_type.chomp
  end

  def has_image file
    file.content_type.include? 'image'
  end

end

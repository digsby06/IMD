class UploadsController < ApplicationController
  skip_before_filter :verify_authenticity_token, only: [:destroy, :update]
  before_filter :find_upload, except: [:ambient_content, :ambient_content_count, :last_updated]

  def new
  end

  def update
    @upload.update_attributes(upload_params)
    render :json => @upload.to_json
  end

  def destroy
    @upload.destroy
    @group = Group.find(@upload.group_id)
    if @group.uploads.count < 1
      @group.destroy
    end
    redirect_to new_group_path and return
  end

  def ambient_content
    @uploads = Upload.ambient_content
    render :json => @uploads.to_json
  end

  def ambient_content_count
    @ambient_content_count = Upload.ambient_content
    render :json => @ambient_content_count.count.to_json
  end

  def last_updated
    @upload = Upload.last_updated
    render :json => @upload.to_json
  end

  protected

  def find_upload
    @upload = Upload.find(params[:id])
  end

  def upload_params
    params.require(:upload).permit(
      :name,
      :file,
      :user_id,
      :upload_type,
      :group_id,
      :ambient_content)
  end

end

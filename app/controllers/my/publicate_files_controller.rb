class My::PublicateFilesController < ApplicationController
  before_action :set_file
  before_action :set_publicate_file, only: %i(destroy)

  def index
    @publicate_files = @file.publicate_files
  end

  def new
    @publicate_file = @file.publicate_files.build
  end

  def create
    @publicate_file = @file.publicate_files.build(publicate_file_params)
    respond_to do |format|
      if @publicate_file.save
        LinkMailer.send_mail(@publicate_file.email, public_file_url(@publicate_file, access_token: @publicate_file.access_token), current_user).deliver
        format.html { redirect_to [:my, @file, :publicate_files], notice: '公開しました' }
      else
        format.html { render 'new' }
      end
    end
  end

  def destroy
    @publicate_file.destroy
    redirect_to [:my, @file, :publicate_files], notice: '公開を解除しました'
  end

  private

  def set_file
    @file = current_user.files.find(params[:fileitem_id])
  end

  def set_publicate_file
    @publicate_file = @file.publicate_files.find(params[:id])
  end

  def publicate_file_params
    return {} if params[:publicate_file].blank?
    params.require(:publicate_file).permit(:email)
  end
end

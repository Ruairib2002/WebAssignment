class FilesController < ApplicationController
  before_action :set_group

  def index
    @files = @group.files
  end

  def new
    @file = @group.files.new
  end

  def create
    @file = @group.files.new(file_params)
    if @file.save
      redirect_to group_files_path(@group), notice: 'File uploaded successfully.'
    else
      render :new
    end
  end

  private

  def set_group
    @group = Group.find(params[:group_id])
  end

  def file_params
    params.require(:file).permit(:file).tap do |whitelisted|
      whitelisted[:file] = sanitize_filename(whitelisted[:file])
    end
  end

  def sanitize_filename(file)
    File.basename(file.original_filename).gsub(/[^\w\.\-]/, '_') if file.present?
  end
end

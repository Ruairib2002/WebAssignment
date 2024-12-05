class FilesController < ApplicationController
  def index
    @group = Group.find(params[:group_id])
    @files = @group.files
  end

  def new
    @group = Group.find(params[:group_id])
    @file = @group.files.new
  end

  def create
    @group = Group.find(params[:group_id])
    @file = @group.files.new(file_params)
    if @file.save
      redirect_to group_files_path(@group), notice: 'File uploaded successfully.'
    else
      render :new
    end
  end

  private

  def file_params
    params.require(:file).permit(:file)
  end
end

class InfoController < ApplicationController
  def index
  end

  def about
  end

  def import_data
    if(params[:file])
=begin
      msg = Role.import(params[:file])
      if(msg.to_s.empty?)
        redirect_to roles_url, notice: "Import successful."
      else
        redirect_to roles_path, flash: {:error=> msg}
      end
    else
      redirect_to roles_path, flash: {:error=> "Oops, no CVS file specified."}
    end
=end
  end


end

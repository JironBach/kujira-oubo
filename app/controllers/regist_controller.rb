class RegistController < ApplicationController
  before_action :sign_in_required, only: [:show]
  
  def new
    render :new
  end
end

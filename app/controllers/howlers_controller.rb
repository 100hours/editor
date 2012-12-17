class HowlersController < ApplicationController

  def index
    @howlers = Howler.all

    respond_to do |format|
      format.html
    end
  end

  def show
    @howler= Howler.find(params[:id])

    respond_to do |format|
      format.html
    end
  end

  def new 
    @howler = Howler.new
  end

  def edit
    @howler = Howler.find(params[:id])
  end

  def create 
    @howler = Howler.new(params[:howler])
    respond_to do |format|
      if @howler.save
        format.html { redirect_to @howler, notice: 'Howler was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def update 
    @howler = Howler.find(params[:id])
    respond_to do |format|
      if @howler.update_attributes(params[:howler])
        format.html { render action: "show" }
      else
        format.html { render action: "edit" }
      end
    end
  end

  def destroy
    @howler = Howler.find(params[:id])
    @howler.destroy

    respond_to do |format|
      format.html { redirect_to howlers_url }
    end
  end
end

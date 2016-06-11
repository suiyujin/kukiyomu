class ChildrenController < ApplicationController
  before_action :set_child, only: [:show, :edit, :update, :destroy]

  # GET /children

  # POST /children/burst
  def burst
    child_id = Child.where(device_token: params['device_token']).first.id
    Burst.create({child_id: child_id})

    update_calm_time(child_id)

    devise_token = 'ba48b1ac7b5d1fbbd9ed2a182e31af156ff52c293d8af2a73629eea3d9fa942b'

    APNS.host = 'gateway.sandbox.push.apple.com'
    APNS.pem = Rails.root.join('config/dev_push.pem')
    APNS.port = 2195
    APNS.send_notification(devise_token, alert: alert, badge: 1, sound: 'default', other: {child_id: child_id})

    render json: {
      user_id: child_id
    }, status: :ok
  end

  # GET /children.json
  def index
    @children = Child.all
  end

  # GET /children/1
  # GET /children/1.json
  def show
  end

  # GET /children/new
  def new
    @child = Child.new
  end

  # GET /children/1/edit
  def edit
  end

  # POST /children
  # POST /children.json
  def create
    @child = Child.new(child_params)

    respond_to do |format|
      if @child.save
        format.html { redirect_to @child, notice: 'Child was successfully created.' }
        format.json { render :show, status: :created, location: @child }
      else
        format.html { render :new }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /children/1
  # PATCH/PUT /children/1.json
  def update
    respond_to do |format|
      if @child.update(child_params)
        format.html { redirect_to @child, notice: 'Child was successfully updated.' }
        format.json { render :show, status: :ok, location: @child }
      else
        format.html { render :edit }
        format.json { render json: @child.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /children/1
  # DELETE /children/1.json
  def destroy
    @child.destroy
    respond_to do |format|
      format.html { redirect_to children_url, notice: 'Child was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_child
      @child = Child.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def child_params
      params.require(:child).permit(:name, :parent_id)
    end

    def update_calm_time child_id
      calm_time_rates = [
        2.5, 2.5, 2.5, 2.5, 3,   3.5,
        3.2, 3,   2.8, 2.5, 2.2, 2.4,
        2.2, 2.3, 2.5, 2.2, 2.2, 2.2,
        2.2, 2.4, 2.4, 2.6, 2.8, 2.7
      ]

      Burst.where(child_id: child_id).each do |burst|
        calm_time_rates[burst.created_at.hour - 1] -= 0.1
      end

      calm_time = 6
      max_calm_time_rate = 0

      calm_time_rates.each_with_index do |rate, index|
        if rate > max_calm_time_rate then
          calm_time = index + 1
          max_calm_time_rate = rate
        end
      end

      child = Child.where(id: child_id).limit(1).first
      child.update(calm_time: "#{calm_time}:00")
    end
end

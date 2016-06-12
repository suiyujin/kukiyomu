class ParentsController < ApplicationController
  before_action :set_parent, only: [:show, :edit, :update, :destroy]

  # GET /parents

  # GET /parents/1/children
  def children
    parent_id = params['parent_id']

    children = Child.includes(:bursts).where(parent_id: parent_id).map{ |child|
      last_burst = child.bursts.last
      burst_rate = last_burst.present? ? calc_burst_rate(last_burst) : 0

      {
        id: child.id,
        name: child.name,
        burst_rate: burst_rate
      }
    }

    render json: children
  end

  # POST /parents/1/worry
  def worry
    Worry.create({parent_id: params['parent_id'], child_id: params['child_id']})
    p Worry.all()

    render json: {
      massage: 'ok',
    }, status: :ok
  end

  # GET /parents.json
  def index
    @parents = Parent.all
  end

  # GET /parents/1
  # GET /parents/1.json
  def show
  end

  # GET /parents/new
  def new
    @parent = Parent.new
  end

  # GET /parents/1/edit
  def edit
  end

  # POST /parents
  # POST /parents.json
  def create
    @parent = Parent.new(parent_params)

    respond_to do |format|
      if @parent.save
        format.html { redirect_to @parent, notice: 'Parent was successfully created.' }
        format.json { render :show, status: :created, location: @parent }
      else
        format.html { render :new }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parents/1
  # PATCH/PUT /parents/1.json
  def update
    respond_to do |format|
      if @parent.update(parent_params)
        format.html { redirect_to @parent, notice: 'Parent was successfully updated.' }
        format.json { render :show, status: :ok, location: @parent }
      else
        format.html { render :edit }
        format.json { render json: @parent.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parents/1
  # DELETE /parents/1.json
  def destroy
    @parent.destroy
    respond_to do |format|
      format.html { redirect_to parents_url, notice: 'Parent was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parent
      @parent = Parent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def parent_params
      params.fetch(:parent, {})
    end

    def calc_burst_rate burst
      burst_rates = [100, 60, 40, 20, 150, 10, 10, 10, 10]
      # 実際にサービスとして動かす時はこっち
      # term = ((Time.now - burst.created_at) / 60 / 15).to_i
      # minute = ((Time.now - burst.created_at) / 60 % 15).to_i
      term = ((Time.now - burst.created_at) / 60).to_i
      minute = ((Time.now - burst.created_at) % 60).to_i
      p minute
      term = 7 if term > 7
      burst_rate = burst_rates[term + 1] + (burst_rates[term] - burst_rates[term + 1]) * (60 - minute) / 60
      burst_rate > 100 ? 100 : burst_rate
    end
end

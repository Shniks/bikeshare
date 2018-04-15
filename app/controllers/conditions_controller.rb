class ConditionsController < ApplicationController
  before_action :set_condition, only: [:show]

  def index
    @conditions = Condition.all
  end

  def show
  end

  def dashboard
    @conditions = Condition.all
  end

  private

  def set_condition
    @condition = Condition.find(params[:id])
  end
end

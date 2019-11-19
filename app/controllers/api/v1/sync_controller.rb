class Api::V1::SyncController < DeviseTokenAuth::ApplicationController
  include DeviseTokenAuth::Concerns::SetUserByToken
  skip_before_filter :verify_authenticity_token,
                     :if => Proc.new { |c| c.request.format == 'application/json' }

  respond_to :json

  def create
    user = User.find_by_uid(params['uid'])
    if user && user.valid_token?(params['token'], params['client'])
      @versions = VersionHistory.where("version > ?", params[:version]).order(:id)
      respond_to do |format|
        format.json
      end
    else
      failure
    end
  end

  def get_server_date
    # user = User.find_by_uid(params['uid'])
    # render :status => 200,
    #       :json => { :success => true, :date => }
  end

  def failure
    render :status => 401,
           :json => { :success => false,
                      :info => "Login Failed",
                      :data => {} }
  end
end

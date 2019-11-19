class CreateAndreyUserService
  def call
    user = User.find_or_create_by!(email: "andrey2ag@hotmail.com") do |user|
        user.password = "Aynerd2ag"
        user.password_confirmation = "Aynerd2ag"
        user.admin!
      end
  end
end

ActiveAdmin.register User do
  form do |f|
    f.inputs "User Details" do
      f.input :email
      f.input :name
      f.input :roles, :as => :check_boxes, :collection => User::ROLES.map { |role| [role, role] }
    end
    f.actions
  end
end

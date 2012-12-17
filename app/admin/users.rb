# ActiveAdmin.register User do
#   menu parent: 'Users'
# end

ActiveAdmin.register User do
  menu parent: I18n.t("activerecord.models.user.other")
  
  filter :email
  filter :first_name
  
  controller do
    before_filter :manage_password_submission , only: [:update, :create]
    
    def manage_password_submission
      admin_user  = params[:user]
      edit        = admin_user[:edit_password]
      
      if !edit or edit.to_s == "0"
        admin_user.delete :password
        admin_user.delete :password_confirmation
      end
      
      true
    end
  end
  
  index do
    selectable_column
    column :first_name
    column :last_name
    column :email
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end
  
  form do |f|
    admin = f.object
    
    f.inputs "User Details" do      
      edit_password_options = { class: 'password_edit_switcher' }
      password_part_options = { class: 'password_part'}
      
      if admin.new_record?
        edit_password_options[:style] = 'display:none'
      else
        password_part_options[:style] = 'display:none'
      end
      
      f.input :email
      f.input :first_name
      f.input :last_name
      f.input :edit_password , as: :boolean, wrapper_html: edit_password_options
      f.input :password, wrapper_html: password_part_options
      f.input :password_confirmation, wrapper_html: password_part_options
    end
    f.buttons
  end
  
  show do
    attributes_table do
      row :id
      row :email
      row :first_name
      row :last_name
      row :created_at
      row :sign_in_count
      row :last_sign_in_at
    end
  end
  
end
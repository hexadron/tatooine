# encoding: utf-8

ActiveAdmin.register_page "Dashboard" do
  
  controller do
    def set_locale
      locale = params[:locale].to_s
      if ['es', 'en'].include?(locale)
        I18n.locale = locale
        redirect_to "/admin"
      end
    end
  end

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Cambio de Idioma" do
          ul do
            li link_to 'español', '/admin/locale/es'
            li link_to 'inglés', '/admin/locale/en'
          end
        end
      end
    end
  end
end

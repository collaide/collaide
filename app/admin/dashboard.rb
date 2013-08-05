ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  content :title => proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        span do
          h1 "Bienvenue dans le back-end"
        end
      end
    end
  end # content
end

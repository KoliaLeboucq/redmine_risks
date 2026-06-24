require_relative 'lib/redmine_risks/patches/project_patch'

ActiveSupport.on_load(:active_record) do
  Project.include RedmineRisks::Patches::ProjectPatch
end

Redmine::Plugin.register :redmine_risks do
  name        'Redmine Risks'
  author      'Kolia Leboucq'
  description 'Module de gestion des risques projet'
  version     '1.0.0'
  requires_redmine version_or_higher: '5.0'

  project_module :risks do
    permission :view_risks,              { risks: [:index, :show] }, public: true
    permission :manage_risks,            { risks: [:new, :create, :edit, :update, :destroy],
                                           risk_reviews: [:new, :create],
                                           risk_mitigation_actions: [:new, :create, :edit, :update, :destroy] }
  end

  menu :project_menu, :risks,
       { controller: 'risks', action: 'index' },
       caption:    :label_risks,
       after:      :issues,
       param:      :project_id
end

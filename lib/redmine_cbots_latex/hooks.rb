module RedmineCbotsLatex
  class Hooks < Redmine::Hook::ViewListener
    def view_layouts_base_html_head(_context = {})
      javascript_include_tag('redmine_cbots_latex', plugin: 'redmine_cbots_latex')
    end
  end
end

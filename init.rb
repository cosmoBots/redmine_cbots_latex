Redmine::Plugin.register :redmine_cbots_latex do
  name        'Redmine Cbots LaTeX'
  author      'cosmoBots'
  description 'Renders LaTeX macros in Redmine content and provides static HTML formula rendering.'
  version     '0.1.1'
  author_url  'https://github.com/cosmoBots'

  settings default: {
    'python_bin' => ENV['LATEX_PYTHON_BIN'] || '/usr/bin/python3',
    'cache_dir'  => ENV['LATEX_CACHE_DIR'] || File.join(Rails.root, 'tmp', 'redmine_cbots_latex')
  }, partial: 'settings/redmine_cbots_latex_settings'
end

require File.join(__dir__, 'lib', 'redmine_cbots_latex', 'latex_renderer')
require File.join(__dir__, 'lib', 'redmine_cbots_latex', 'hooks')
require File.join(__dir__, 'config', 'macros_registration')

# This file is a part of Redmine ZenEdit (redmine_zenedit) plugin,
# editing enhancement plugin for Redmine
#
# Copyright (C) 2011-2020 RedmineUP
# http://www.redmineup.com/
#
# redmine_zenedit is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_zenedit is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_zenedit.  If not, see <http://www.gnu.org/licenses/>.

requires_redmine_crm :version_or_higher => '0.0.47' rescue raise "\n\033[31mRedmine requires newer redmine_crm gem version.\nPlease update with 'bundle update redmine_crm'.\033[0m"
require 'redmine_zenedit'

ZENEDIT_VERSION_NUMBER = '2.0.0'
ZENEDIT_VERSION_TYPE = "Light version"

Redmine::Plugin.register :redmine_zenedit do
  name "Redmine Zen Edit plugin (#{ZENEDIT_VERSION_TYPE})"
  author 'RedmineUP'
  description 'Zen editing plugin for Redmine'
  version ZENEDIT_VERSION_NUMBER
  url 'https://www.redmineup.com/pages/plugins/zenedit'
  author_url 'mailto:support@redmineup.com'
end

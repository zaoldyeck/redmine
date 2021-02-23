# encoding: utf-8
#
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

require File.expand_path('../../test_helper', __FILE__)

class ZeneditControllerTest < ActionController::TestCase
  fixtures :projects, :issues, :issue_statuses, :issue_categories, :trackers, :projects_trackers,
           :users, :roles, :member_roles, :members, :enabled_modules, :workflows,
           :enumerations, :journals, :journal_details

  fixtures :email_addresses if Redmine::VERSION.to_s >= '3.0'

  def setup
    @request.session[:user_id] = 1
  end
end

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

class ZenDraftControllerTest < ActionController::TestCase
  fixtures :projects,
           :users,
           :roles,
           :members,
           :member_roles,
           :issues,
           :issue_statuses,
           :versions,
           :trackers,
           :projects_trackers,
           :issue_categories,
           :enabled_modules,
           :enumerations,
           :attachments,
           :workflows,
           :custom_fields,
           :custom_values,
           :custom_fields_projects,
           :custom_fields_trackers,
           :time_entries,
           :journals,
           :journal_details,
           :queries,
           :wikis,
           :wiki_pages

  def setup
    User.current = User.find(1)
    @request.session[:user_id] = 1
  end

  #<LIGHT>
  def test_draft_is_not_saved
    # We won't get ActionNotFound because in light mode controller
    # does not exist
    assert_raise RuntimeError do
      compatible_xhr_request :post, :create, issue: { subject: 'hello' }
    end
  end
  #</LIGHT>
end

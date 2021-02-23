# encoding: utf-8
#
# This file is a part of Redmine CRM (redmine_contacts) plugin,
# customer relationship management plugin for Redmine
#
# Copyright (C) 2010-2020 RedmineUP
# http://www.redmineup.com/
#
# redmine_contacts is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_contacts is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_contacts.  If not, see <http://www.gnu.org/licenses/>.

require File.expand_path(File.dirname(__FILE__) + '/../../test_helper')

class Redmine::ApiTest::ContactsTest < ActiveRecord::VERSION::MAJOR >= 4 ? Redmine::ApiTest::Base : ActionController::IntegrationTest
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
           :queries

  RedmineContacts::TestCase.create_fixtures(Redmine::Plugin.find(:redmine_contacts).directory + '/test/fixtures/', [:contacts,
                                                                                                                    :contacts_projects,
                                                                                                                    :deals,
                                                                                                                    :notes,
                                                                                                                    :tags,
                                                                                                                    :taggings,
                                                                                                                    :queries])

  def setup
    Setting.rest_api_enabled = '1'
    RedmineContacts::TestCase.prepare
  end

  def test_get_contacts_xml
    # Use a private project to make sure auth is really working and not just
    # only showing public issues.
    Redmine::ApiTest::Base.should_allow_api_authentication(:get, '/projects/private-child/contacts.xml') if ActiveRecord::VERSION::MAJOR < 4

    compatible_api_request :get, '/contacts.xml', {}, credentials('admin')

    att = { :type => 'array', :total_count => 5, :limit => 25, :offset => 0 }
    assert_select 'contacts', :attributes => att
  end

  def test_post_contacts_xml
    if ActiveRecord::VERSION::MAJOR < 4
      Redmine::ApiTest::Base.should_allow_api_authentication(:post, '/contacts.xml', { :contact => { :project_id => 1, :first_name => 'API test' } },
                                                                                     { :success_code => :created })
    end

    assert_difference('Contact.count') do
      compatible_api_request :post, '/contacts.xml', { :contact => { :project_id => 1, :first_name => 'API test' } }, credentials('admin')
    end

    contact = Contact.order('id DESC').first
    assert_equal 'API test', contact.first_name

    assert_response :created
    assert_equal 'application/xml', @response.content_type
    assert_select 'contact', :child => { :tag => 'id', :content => contact.id.to_s }
  end

  def test_post_contacts_xml_redirect
    if ActiveRecord::VERSION::MAJOR < 4
      Redmine::ApiTest::Base.should_allow_api_authentication(:post, '/contacts.xml', { :contact => { :project_id => 1, :first_name => 'API test' } },
                                                                                     { :success_code => :created })
    end

    assert_difference('Contact.count') do
      compatible_api_request :post, '/contacts.xml', { :contact => { :project_id => 1, :first_name => 'API test' }, :redirect_on_success => 'http://ya.ru' }, credentials('admin')
    end

    assert_redirected_to 'http://ya.ru'
  end

  # Issue 6 is on a private project
  def test_put_contacts_1_xml
    parameters = { :contact => { :first_name => 'API update' } }

    if ActiveRecord::VERSION::MAJOR < 4
      Redmine::ApiTest::Base.should_allow_api_authentication(:put, '/contacts/1.xml', { :contact => { :first_name => 'API update' } },
                                                                                      { :success_code => :ok })
    end

    assert_no_difference('Contact.count') do
      compatible_api_request :put, '/contacts/1.xml', parameters, credentials('admin')
    end

    contact = Contact.where(:id => 1).first
    assert_equal 'API update', contact.first_name
  end
end

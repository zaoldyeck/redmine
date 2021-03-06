# This file is a part of Redmine Products (redmine_products) plugin,
# customer relationship management plugin for Redmine
#
# Copyright (C) 2011-2020 RedmineUP
# http://www.redmineup.com/
#
# redmine_products is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_products is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_products.  If not, see <http://www.gnu.org/licenses/>.

module RedmineOrders
  module Patches
    module ContactsHelperPatch
      def self.included(base)
        base.send(:include, InstanceMethods)

        base.class_eval do
          alias_method :contact_tabs_without_orders, :contact_tabs
          alias_method :contact_tabs, :contact_tabs_with_orders
        end
      end

      module InstanceMethods
        # include ContactsHelper

        def contact_tabs_with_orders(contact)
          tabs = contact_tabs_without_orders(contact)

          if contact.orders.visible.count > 0
            tabs.push(:name => 'orders',
                      :partial => 'contacts/related_orders',
                      :label => l(:label_order_plural) + " (#{contact.orders.visible.count})")
          end
          if contact.products.visible.count > 0
            tabs.push(:name => 'products',
                      :partial => 'contacts/related_products',
                      :label => l(:label_product_plural) + " (#{contact.products.visible.count})")
          end
          tabs
        end
      end
    end
  end
end

unless ContactsHelper.included_modules.include?(RedmineOrders::Patches::ContactsHelperPatch)
  ContactsHelper.send(:include, RedmineOrders::Patches::ContactsHelperPatch)
end

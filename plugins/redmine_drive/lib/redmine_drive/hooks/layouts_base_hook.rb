# This file is a part of Redmin Drive (redmine_drive) plugin,
# Filse storage plugin for redmine
#
# Copyright (C) 2011-2020 RedmineUP
# http://www.redmineup.com/
#
# redmine_drive is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# redmine_drive is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with redmine_drive.  If not, see <http://www.gnu.org/licenses/>.

module RedmineDrive
  module Hooks
    class LayoutBaseHook < Redmine::Hook::ViewListener
      def view_layouts_base_sidebar(context = {})
        return unless drive_entry_page?(context)

        context[:hook_caller].send(:render, { locals: context, partial: 'attachments/drive_entry_sidebar' })
      end

      def view_layouts_base_content(context = {})
        return unless drive_entry_page?(context)

        context[:hook_caller].send(:render, { locals: context, partial: 'attachments/drive_entry_comments' })
      end

      def view_layouts_base_html_head(context = {})
        return unless drive_entry_page?(context)

        context[:hook_caller].send(:render, { locals: context, partial: 'attachments/drive_entry_heads' })
      end

      private

      def drive_entry_page?(context)
        context[:controller].params[:controller] == 'attachments' &&
        context[:controller].params[:action] == 'show' &&
        !!context[:controller].params[:drive_entry]
      end
    end
  end
end

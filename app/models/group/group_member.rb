# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: group_group_members
#
#  id                       :integer          not null, primary key
#  group_id                 :integer
#  member_id                :integer
#  member_type              :string(255)
#  role                     :string(255)
#  joined_method            :string(255)
#  invited_or_added_by_id   :integer
#  invited_or_added_by_type :string(255)
#  created_at               :datetime
#  updated_at               :datetime
#

# -*- encoding : utf-8 -*-
class Group::GroupMember < ActiveRecord::Base
  #attr_accessible :is_admin
  extend Enumerize
  enumerize :role,
            in: [Group::Roles::ADMIN,
                Group::Roles::WRITER,
                Group::Roles::MEMBER,
                Group::Roles::ALL]

  # Comment il a rejoint le groupe
  enumerize :joined_method, in: [:was_invited,
                                  :was_added,
                                  :was_invited_by_email,
                                  :by_itself], default: :by_itself
  def self.get_a_member(member, group)
    where(group: group, member_id: member.id, member_type: member.class.name).take
  end

  # Le membre qui l'a ajouté ou invité
  belongs_to :invited_or_added_by, polymorphic: true

  # Les membres du group
  belongs_to :member, polymorphic: true

  # Le group
  belongs_to :group, :class_name => 'Group::Group'

end

class Group::WorkGroup < Group::Group

  def init
    super
    self.can_index_members << Group::Roles::MEMBER
    self.can_read_member << Group::Roles::MEMBER
    self.can_write_file << Group::Roles::MEMBER
    self.can_index_files << Group::Roles::MEMBER
    self.can_read_file << Group::Roles::MEMBER
    self.can_delete_file << Group::Roles::MEMBER
    self.can_index_statuses << Group::Roles::MEMBER
    self.can_write_status << Group::Roles::MEMBER
    self.can_create_invitation << Group::Roles::MEMBER
  end
end

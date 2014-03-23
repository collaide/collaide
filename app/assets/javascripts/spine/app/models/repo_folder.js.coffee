class App.RepoFolder extends Spine.Model
  @configure 'RepoFolder', 'name', 'file_size', 'content_type', 'is_folder', 'download'
  @extend Spine.Model.Ajax
  @url: $('#folder_url').val()
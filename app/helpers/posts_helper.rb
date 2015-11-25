module PostsHelper
  def fix_url(str)
    str.starts_with?("http://")? str : "http://#{str}"
  end
end

ThinkingSphinx::Middlewares::DEFAULT.delete ThinkingSphinx::Middlewares::UTF8

class ThinkingSphinx::Excerpter
  def excerpt!(text)
    ThinkingSphinx::Connection.take do |connection|
      connection.query(statement_for(text)).first['snippet']
    end
  end
end
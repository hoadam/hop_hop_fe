class HophopService
  def self.conn
    conn = Faraday.new(url: 'https://api-hophop-9875038f278b.herokuapp.com/api/v1/') do |f|
      f.request :json
      f.response :raise_error
    end
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)

    JSON.parse(response.body, symbolize_names: true)
  end
end

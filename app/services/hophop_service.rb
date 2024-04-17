class HophopService
  def self.conn
    conn = Faraday.new(url: 'http://127.0.0.1:3000/api/v1') do |f|
      f.request :json
      f.response :raise_error
    end
  end

  def self.get_url(url, params = {})
    response = conn.get(url, params)

    JSON.parse(response.body, symbolize_names: true)
  end
end

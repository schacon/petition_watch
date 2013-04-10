require 'open-uri'

class WePeeps
  URL = "https://api.whitehouse.gov/v1/petitions/"

  def initialize(key)
    @key = key
  end

  def get_before(date)
    petitions("created_before=#{date.to_i}")
  end

  def get_after(date)
    petitions("created_after=#{date.to_i}")
  end

  def each
    offset = 0
    size = 100
    while size == 100
      size = 0
      res = petitions("limit=100&offset=#{offset}")
      res['results'].each do |r|
        yield r
        size += 1
      end
      offset += size
    end
  end

  def petitions(extra)
    point = URL + "petitions.json?key=#{@key}"
    point += "&#{extra}"
    do_call(point)
  end

  def do_call(uri)
    body = nil
    open(uri) do |f|
      body = f.read
    end
    JSON.parse(body)
  end
end

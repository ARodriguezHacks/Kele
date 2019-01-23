class Kele
  include HTTParty
  base_uri 'https://www.bloc.io/api/v1'

  def initialize(u, p)
    @options = { query: { username: u, password: p } }
  end

end

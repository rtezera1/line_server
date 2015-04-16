require_relative '../server.rb'
require 'typhoeus'

describe 'LiveServer' do
  it 'returns 200 and text of requested line' do
    request = Typhoeus.get(
      'http://localhost:9393/lines/10', followlocation: true
    )
    expect(request.response_body).to eq(
      "HTTP status 200 \n expected by the end of the year, Mr. Lianos said.\n"
    )
  end

  it 'returns 413 if line is beyond the end of the file' do
    request = Typhoeus.get(
      'http://localhost:9393/lines/100', followlocation: true
    )
    expect(request.response_body).to eq(
      "HTTP status 413 \n Line out of range"
    )
  end

  it 'serves multiple simultaneous clients' do
    responses = []
    hydra = Typhoeus::Hydra.new
    10.times do
      request = Typhoeus::Request.new(
        'http://localhost:9393/lines/10', followlocation: true
      )
      request.on_complete do |response|
        responses << response.response_body
      end
      hydra.queue(request)
    end
    hydra.run
    expect(responses.length).to eq(10)
    expect(responses[0]).to eq(
      "HTTP status 200 \n expected by the end of the year, Mr. Lianos said.\n"
    )
    expect(responses[-1]).to eq(
      "HTTP status 200 \n expected by the end of the year, Mr. Lianos said.\n"
    )
  end

  it 'server various multiple clients' do
    requests = []
    responses = []
    hydra = Typhoeus::Hydra.new
    counter = 1
    while counter <= 10
      request = Typhoeus::Request.new(
        "http://localhost:9393/lines/#{counter}"
      )
      counter += 1
      requests << request
    end
    requests.each do |one|
      hydra.queue one
      hydra.run
      responses << one.response.options[:response_body]
    end
    expect(responses[0]).to eq(
      "HTTP status 200 \n News Corp, publisher of The Wall Street Journal\n"
    )
    expect(responses[-1]).to eq(
      "HTTP status 200 \n expected by the end of the year, Mr. Lianos said.\n"
    )
    expect(responses.length).to eq(10)
  end
end

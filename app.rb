require 'sinatra'
require 'twilio-ruby'



# Twilio configuration
TWILIO_SID      = ENV['TWILIO_KEY']
TWILIO_TOKEN    = ENV['TWILIO_TOKEN']
TWILIO_NUMBER   = ENV['TWILIO_NUMBER']

# Url configuration
HANDLER_URL     = ENV['HANDLER_URL']
ACTION_URL      = ENV['HANGUP_URL']




get '/make-call' do
  content_type 'text/html'
  
  return 'missing user' unless params[:user]
  return 'missing dest' unless params[:destination]

  user        = params[:user]         || ENV['FALLBACK_PHONE'] 
  destination = params[:destination]  || ENV['FALLBACK_PHONE']


  @client     = Twilio::REST::Client.new TWILIO_SID, TWILIO_TOKEN
  @client.account.calls.create(
    from: TWILIO_NUMBER,
    to:   "+#{user}",
    url:  "#{HANDLER_URL}/#{destination}/#{user}",
  )

  return @client

end


post '/handle/:destination/:user' do
  content_type 'text/xml'


  from      = "+" + params[:user]
  outbound  = "+" + params[:destination]

  response = Twilio::TwiML::Response.new do |r|
    r.Say "Aguarde um momento, vamos te conectar com o alvo", voice: 'alice', language: 'pt-BR'
    r.Dial callerId: from do |d|
      d.Number(outbound)
    end
  end

  return response.text
end


get '/voice' do
  content_type 'text/xml'
  response = Twilio::TwiML::Response.new do |r|
    r.Say "Obrigado por ligar", voice: 'alice', language: 'pt-BR'
  end

  return response.text
end

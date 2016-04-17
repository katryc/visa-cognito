class Post < ActiveRecord::Base
  has_attached_file :image, styles: {

		large: "400x400"
	}

	# Validate the attached image is image/jpg, image/png, etc
	validates_attachment :image, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
  def self.recognize(url)

   gallery = 'BioCheck'
   lookup = url
   threshold = '0.75'

   body = {:image => lookup, :gallery_name => gallery, :threshold => threshold}
   body = body.to_json

   headers = {
     :content_type => 'application/json',
     :app_id => ENV['KAIROS_ID'],
     :app_key => ENV['KAIROS_KEY']
   }

   response = HTTParty.post('https://api.kairos.com/recognize', { body: body, headers: headers})

   response_short = response.parsed_response

   successtest = response_short['images'][0]['transaction']['status']
   p successtest
   successtest
 end

 def ctc_post_on
   url = 'https://sandbox.api.visa.com/vctc/customerrules/v1/consumertransactioncontrols/5712ac8be4b00e8e02d9bdca/rules'
   user_id = 'S9OBAQ2UMPTZDA2ESCVT21hU5dcsA8vAoiE2PTY-OrwpwIViM'
   password = 'IORFVTTRF3gD64j6iYuCWMs4Du5I5LxD'
   key_path = 'privateKey2.pem'
   cert_path = 'faceCheck2.pem'
   headers = {'content-type'=> 'application/json', 'accept'=> 'application/json'}
   body = '{"transactionControls": [{"alertThreshold": 300, "controlType": "TCT_E_COMMERCE", "isControlEnabled": true, "shouldAlertOnDecline": true, "shouldDeclineAll": true}]}'
   begin
     response = RestClient::Request.execute(
     :method => :post,
     :url => url,
     :headers => headers,
     :payload => body,
     :user => user_id, :password => password,
     :ssl_client_key => OpenSSL::PKey::RSA.new(File.read(key_path)),
     :ssl_client_cert =>  OpenSSL::X509::Certificate.new(File.read(cert_path))
     )
   rescue RestClient::ExceptionWithResponse => e
     response = e.response
   end
   return response
 end

 def ctc_post_off
   url = 'https://sandbox.api.visa.com/vctc/customerrules/v1/consumertransactioncontrols/5712ac8be4b00e8e02d9bdca/rules'
   user_id = 'S9OBAQ2UMPTZDA2ESCVT21hU5dcsA8vAoiE2PTY-OrwpwIViM'
   password = 'IORFVTTRF3gD64j6iYuCWMs4Du5I5LxD'
   key_path = 'privateKey2.pem'
   cert_path = 'faceCheck2.pem'
   headers = {'content-type'=> 'application/json', 'accept'=> 'application/json'}
   body = '{"transactionControls": [{"alertThreshold": 300, "controlType": "TCT_E_COMMERCE", "isControlEnabled": true, "shouldAlertOnDecline": true, "shouldDeclineAll": false}]}'
   begin
     response = RestClient::Request.execute(
     :method => :post,
     :url => url,
     :headers => headers,
     :payload => body,
     :user => user_id, :password => password,
     :ssl_client_key => OpenSSL::PKey::RSA.new(File.read(key_path)),
     :ssl_client_cert =>  OpenSSL::X509::Certificate.new(File.read(cert_path))
     )
   rescue RestClient::ExceptionWithResponse => e
     response = e.response
   end
   return response
 end

end

package panhelios.facebook
{
	import com.hurlant.crypto.hash.HMAC;
	import com.hurlant.crypto.hash.SHA256;
	import com.hurlant.util.Base64;
	
	import flash.utils.ByteArray;

	public class SignedRequest
	{
		protected var _signature:String;
		protected var _request:String;
		
		protected var _payload:Object;
		
		/** A Signed Request is a data package with a verifiable origin
		 *  
		 *  <p>The SignedRequest class makes parsing and verfying signed requests easier. Signed requests
		 *  are used by Facebook and Kongregate to enable a communication through the client. By using a 
		 *  shared secret, the app secret, a developer can verify the origin of a request to be Facebook
		 *  or Kongregate. Without knowing the shared secret it is near impossible for a user to manipulate
		 *  a request.
		 */
		public function SignedRequest(request:String)
		{
			// split request at period into signature and payload
			var requestElements:Array = request.split(".");
			
			_signature = base64UrlDecode(requestElements[0]);
			// the raw request is stored to verify the signature
			_request = requestElements[1];
			
			var payloadJSON:String = base64UrlDecode(requestElements[1]);
			_payload = JSON.parse(payloadJSON);
			
			if (_payload.algorithm != "HMAC-SHA256")
				throw new Error("Signed Request: Unknown hash algorithm ('"+ _payload.algorithm +"')");
		}
		
		protected function base64UrlDecode(input:String):String
		{
			input = input.replace(/-/g, "+").replace(/_/g, "/");
			
			return Base64.decode(input);
		}
		
		/** Use a shared secret, the app secret, to confirm the requests origin. */
		public function verifySignature(appSecret:String):Boolean
		{
			var request:ByteArray = new ByteArray();
			request.writeUTFBytes(_request);
			
			var key:ByteArray = new ByteArray();
			key.writeUTFBytes(appSecret);
			
			var hmac:HMAC = new HMAC(new SHA256);
			var digest256:ByteArray = hmac.compute(key, request);
			
			return digest256.toString() == _signature;
		}

		public function get payload():Object
		{
			return _payload;
		}

		public function set payload(value:Object):void
		{
			_payload = value;
		}

	}
}
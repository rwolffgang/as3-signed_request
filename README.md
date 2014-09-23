# as3-signed_request

Easily parse and verify signed requests from Facebook and Kongregate.

The SignedRequest class makes parsing and verfying signed requests easier. Signed requests are used by Facebook and Kongregate to enable a communication through the client. By using a shared secret, the app secret, a developer can verify the origin of a request to be Facebook or Kongregate. Without knowing the shared secret it is near impossible for a user to manipulate a request.

## Dependencies
This class relies on the [ActionScript 3 Cryptography Library](https://github.com/timkurvers/as3-crypto) to calculate hashes. So make sure to get it as well.

## Documentation of Signed Request
Kongregate has a good description of how a signed request works: [Kongregate's description with PHP example](http://developers.kongregate.com/docs/all/signed-requests)

## Usage
Usage is fairly simple: Pass a signed request as string to the class and you can start accessing the payload. To verify the request, call `verifySignature(appSecret:String)` with your application's secrent.

    var testRequest:String = "zvUZIJbHmjZUfg5PvVeU4xEpqdfgzlcVCIvpW-2OZV8.eyJhbGdvcml0aG0iOiJITUFDLVNIQTI1NiIsImFtb3VudCI6IjQuOTkiLCJjdXJyZW5jeSI6IkVVUiIsImlzc3VlZF9hdCI6MTQxMTM4OTQwMiwicGF5bWVudF9pZCI6NTMxNTIzNDMzNjQ0NDE5LCJxdWFudGl0eSI6IjEiLCJzdGF0dXMiOiJjb21wbGV0ZWQifQ";
	var testAppSecret:String = "8b0d5bd5fe5dc3bec1ef9848563695e3";
			
	var request:SignedRequest = new SignedRequest(testRequest);

	// read data from payload
	trace("Request status:", request.payload.status);
	
	// verify signature
	trace("Signature is valid:", request.verifySignature(testAppSecret));
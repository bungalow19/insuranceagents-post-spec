InsuranceAgents.com Price Presentation API
=================================

Description:
-----------

The price presentation API is a way for our partners to present leads to Insuranceagents.com, and facilitate mutually profitable trading of insurance leads.

This API facilitates two different selling modes:

Ping-Post
---------

Price Presentation	allows you to send a lead information without consumer contact information to request a price quote (called ping). If the payout is accepted,  you can sell (called  post) the lead with consumer contact information and ID within a few minutes of price quote.

Partners can test their ping requests using the following URL: 

		http://pingtest.insuranceagents.com/pingtest

 Once you have finished ping testing to your satisfaction, please contact us to arrange for certification testing (includes ping and post).  After your submission process is certified, you will be provided with the production URL and will be able to go live with ping posting.

If you receive anything other than 200 OK or Successful 2xx http response, go to 
		http://www.w3.org/Protocols/rfc2616/rfc2616-sec10.html 
website to look up the error code.  Contact us for errors that are indicative of problems on our servers.

or a ping request, you must provide the following parameters:

    key	Password for posting 
    action	Set to "ping" 
    xml	Actual lead data in XML

While testing your ping, The following fields may be left out or left blank in order to ping:
fname, lname, addr, city, state, email, phone

These fields will be required to be included if the lead is sent for purchase.  All other fields are required per the schema for the pinged lead to be evaluated.

You will receive a response to your ping in the following format:

    <?xml version="1.0" encoding="utf-8"?>
    <reply>
    	<code>Response code</code>
    	<comment>Comments</comment>
    	<id>Your provided id (if available)</id>
    	<lead>Our ping tracking ID</lead>
    	<payout>Our offered price</payout>
    </reply>

Response codes (<code>Response code</code>)
    1   Success 
    -2  Failed login verification.  May also be missing affiliate login or missing password
    -3  Bad XML, either invalid XML formatting or schema violations.  
    See <comment>Comments</comment> for details.

The id parameter (<id>Your provided id (if available)</id>), containing your id for the lead, is an optional field.  If it is provided, it will be echoed in the return offer we make.

Our ping tracking ID (<lead>Our ping tracking ID</lead>) will have to be returned to us if you sell us the lead.  If you send the full lead without the ping tracking ID, we will deny the purchase for incomplete data.

Our offered price (<payout>Our offered price</payout>) may be zero (0.00).  If this is the case, your ping has been successful but we are declining to make an offer to purchase the lead.

CAVEATS

Use POST, do NOT use GET for http post method of choice. 
Use lower case, the parameters and values we receive via http post are case sensitive.

Leg Bidding
-----------

To use leg bidding, use the same procedure as before, but pass an additional HTTP parameter: `leg_bid=1`, on both the PING and the POST.
  
Instead of buying exclusive rights to the league, we will return with an XML response as follows:

    <?xml version="1.0" encoding="utf-8"?>
    <reply xmlns="http://ping.insuranceagents.com/ping">
      <code>1</code>
      <comments></comments>
      <legs>
        <leg id="125560">
          <company_id>6</company_id>
          <price>6.00</price>
        </leg>
        <leg id="125561">
          <company_id>5</company_id>
          <price>5.00</price>
        </leg>
        <leg id="125562">
          <agent_fname>A</agent_fname>
          <agent_lname>BAR</agent_lname>
          <agent_phone>5309</agent_phone>
          <agent_license>4430091</agent_license>
          <price>2.00</price>
        </leg>
      </legs>
      <price>13.00</price>
    </reply>
    
This indicates that we will pay $5.00 for a leg sold to company id 4, $6.00 for a leg sold to company id 6, and $2.00 for a leg sold to an independent agent, identifiable by license number, beginning of her first and last name, and license number.

You have the right to sell us whatever legs you wish through the `sell_to_legs` HTTP parameter. If this field is absent, we will buy every leg we bid on during the PING.

If this field is present, it should be a comma-separated list of leg ids. In this example, if you wanted to sell us the leg for the independent agent, and company ID 6, you would send:

    sell_to_legs=125560,125562&leg_bid=1
    
...in addition to the normal ping-posting parameters. We would buy and take action on only these two legs listed.

You can examine our company ID list at any time at:

API Keys
--------

Contact us for a testing/production API key.

Distribution Directives
-----------------------

The `<distribution>` element of the schema directs our sales. Normally when you are using the Price Presentation mode, you do not declare a type on the distribution and you turn the lead over to us with the understanding that we will not sell to the people listed in the directive.

You have the option of either excluding an individual Agent by passing the first letter of her first name, the first three numbers of her last name, the last four digits of her phone number, and her license number through the `<agent_directive>` tag, or a whole insurance company through the `<company_directive>` tag. Any directive must fall into one of these two categories. If we do not have the company you are attempting to pass in our list, you MUST pass the agent directive instead.
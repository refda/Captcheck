Captcheck
=========

Easy, light, self-hostable CAPTCHA service.  Works on all modern browsers and 
IE9+.  Uses icons from Font-Awesome.


How to use
----------

In your form, put an empty div with the class "captcheck_container". 
Add `captcheck.js` (or `captcheck.dist.js`) into your page.

    <!DOCTYPE html>
    <html>
        <head>
            <title>Captcheck Sample Form</title>
            <meta charset="UTF-8">
            <meta name="viewport" content="width=device-width, initial-scale=1.0">
            <script src="captcheck.js"></script>
        </head>
        <body>
            <form action="submit.php">
                <input type="text" name="form_field" placeholder="Some random form field" />
                <div class="captcheck_container">
                </div>
                <button type="submit">Submit Form</button>
            </form>
        </body>
    </html>

When the form is submitted, your server will receive two extra form fields: 
`captcheck_session_code` and `captcheck_selected_answer`.
In your form handling code, send a request to `http(s)://captcheck-url/api.php`. 
Pass the variables `session_id` and `answer_id` with the values sent with the form, 
and also pass the variable `action` with the value `verify`.  
You will receive a JSON response with (among other things) `"result": true` or 
`"result": false`.  If result is false, the user failed the test, and another 
variable `msg` is available with an explanation.

Example URL:  
`http(s)://captcheck-url/api.php?action=verify&session_id=<captcheck_session_code>&answer_id=<captcheck_selected_answer>`

Example responses:  
`{"session":"some_session_id","result":true}`  
`{"session":"some_session_id","result":false,"msg":"Answer incorrect."}`


Installation
------------

1. Run composer install.
2. Copy settings.template.php to settings.php and plug in your settings.
3. Install the database.
4. Customize captcheck.js with the correct api_url.
5. Follow the How to Use section and the example setup in test.html and test.php.


Execution Flow
--------------

    JS = captcheck.js, API = api.php, FORM = parent form, 
    SITE = form processing code, -> = some action taken on the right by the left

    JS -> API:      Request session ID, question, and answers (with scrambled random codes)
    API -> JS:      Sends info, saves session ID, correct answer, and scrambled answer codes in DB
    JS -> API:      Requests answer images by sending scrambled value and session ID
    JS -> FORM:     Adds hidden field with value=session ID, displays question and images (or text box)
    [USER SUBMITS FORM]
    SITE -> API:    Sends session ID and answer
    API -> SITE:    Responds with true/false to indicate if the answer is valid, marks session as expired to prevent CAPTCHA reuse

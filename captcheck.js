window.onload = function () {
    var api_url = "https://captcheck.netsyms.com/api.php";
    var getJSON = function (url, callback) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', url, true);
        xhr.onreadystatechange = function () {
            if (this.readyState == 4) {
                callback(this.status, this.responseText);
            }
        };
        xhr.send();
    };
    getJSON(api_url + "?action=new", function (status, json) {
        /* Add custom styles */
        var styles = document.createElement('style');
        styles.innerHTML = ".captcheck_box {font-family: Ubuntu, Arial, sans-serif; color: black; border: 1px solid #e0e0e0; border-radius: 3px; display: inline-block; padding: 3px; margin: 5px 2px 5px 1px; background-color: #f5f5f5;} .captcheck_label_message {color: black;} .captcheck_answer_label > input {visibility: hidden; position: absolute;} .captcheck_answer_label > input + img {cursor: pointer; border: 2px solid transparent; border-radius: 3px; min-width: 32px; width: 18%; max-width: 64px;} .captcheck_answer_label > input:checked + img {cursor: pointer; border: 2px solid #424242; border-radius: 3px;} .captcheck_error_message {color: red;}";
        document.body.appendChild(styles);

        /* Get captcha container div */
        var container = document.getElementById("captcheck_container");
        /* Create captcha div */
        var captcha = document.createElement("div");
        captcha.setAttribute("class", "captcheck_box");
        container.appendChild(captcha);
        
        if (status == 200) {
            var data = JSON.parse(json);
            /* Create answer buttons */
            var answers = "";
            for (var i = 0, len = data.answers.length; i < len; i++) {
                var src = api_url + "?action=img&s=" + data.session + "&c=" + data.answers[i];
                answers += "<span class='captcheck_answer_label' onclick='chooseAnswer(\"" + data.answers[i] + "\")'><input id='captcheck_answer_" + data.answers[i] + "' type='radio' name='captcheck_selected_answer' value='" + data.answers[i] + "' /><img src='" + src + "' /></span>";
            }
            var answer_div = document.createElement("div");
            answer_div.innerHTML = answers;
            /* Create question */
            var question_div = document.createElement("div");
            question_div.setAttribute("class", "captcheck_label_message");
            question_div.innerHTML = "Click on the <b>" + data.question + "</b>:";

            /* Add question and answers */
            captcha.appendChild(question_div);
            captcha.appendChild(answer_div);

            /* Add hidden session ID element */
            var skey_input = document.createElement("span");
            skey_input.innerHTML = "<input type='hidden' name='captcheck_session_code' value='" + data.session + "' />";
            captcha.appendChild(skey_input);
        } else {
            /* Add error message */
            captcha.innerHTML = "<span class='captcheck_error_message'>There was a problem loading the CAPTCHA.</span>";
        }
    });
}

function chooseAnswer(ans) {
    var box = document.getElementById("captcheck_answer_" + ans);
    box.checked = true;
}
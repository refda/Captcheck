window.onload = function () {
    var api_url = "https://captcheck.netsyms.com/api.php";

    /* Add custom styles */
    var styles = document.createElement('style');
    /* Remove newlines/comments from captcheck.css and put it here */
    styles.innerHTML = ".captcheck_box,.captcheck_label_message,.captcheck_label_message b{color:#000;font-family:Ubuntu,Arial,sans-serif}.captcheck_box{border:1px solid #e0e0e0;border-radius:3px;display:inline-block;padding:3px;margin:5px 2px 5px 1px;background-color:#f5f5f5}.captcheck_answer_label>input{visibility:hidden;position:absolute}.captcheck_answer_label>input+img{cursor:pointer;border:2px solid transparent;border-radius:3px;min-width:32px;width:18%;max-width:64px}.captcheck_answer_label>input:checked+img{cursor:pointer;border:2px solid #424242;border-radius:3px}.captcheck_error_message{color:red}.captcheck_question_image{display:initial}.captcheck_question_access{display:none}.captcheck_alt_question_button{float:right;font-size:80%;cursor:pointer;color:inherit;text-decoration:inherit}.captcheck_answer_images{display:initial}.captcheck_answer_access{display:none}";
    document.body.appendChild(styles);

    /* Loop over all the CAPTCHA containers on the page, setting up a different CAPTCHA in each */
    Array.prototype.forEach.call(document.getElementsByClassName("captcheck_container"), function (container) {
        var xhr = new XMLHttpRequest();
        xhr.open('GET', api_url + "?action=new", true);
        xhr.onreadystatechange = function () {
            if (this.readyState == 4) {
                var status = this.status;
                var json = this.responseText;
                /* Create captcha div */
                var captcha = document.createElement("div");
                captcha.setAttribute("class", "captcheck_box");
                container.appendChild(captcha);

                if (status == 200) {
                    var data = JSON.parse(json);
                    // ID prefix to use for this instance
                    var idp = data.id_prefix;
                    /* Create answer buttons */
                    var answers = "<div class='captcheck_answer_images' id='captcheck_" + idp + "_answer_images'>";
                    for (var i = 0, len = data.answers.length; i < len; i++) {
                        var src = api_url + "?action=img&s=" + data.session + "&c=" + data.answers[i];
                        answers += "<a class='captcheck_answer_label' href='' tabindex='0' onClick='chooseAnswer(\"" + idp + "\",\"" + data.answers[i] + "\"); return false;' onEnter='chooseAnswer(\"" + idp + "\",\"" + data.answers[i] + "\"); return false;'><input id='captcheck_" + idp + "_answer_" + data.answers[i] + "' type='radio' name='captcheck_selected_answer' value='" + data.answers[i] + "' /><img src='" + src + "' /></a>";
                    }
                    answers += "</div>";
                    var answer_div = document.createElement("div");
                    answer_div.innerHTML = answers + "<div class='captcheck_answer_access' id='captcheck_" + idp + "_answer_access'></div>";
                    /* Create question */
                    var question_div = document.createElement("div");
                    question_div.setAttribute("class", "captcheck_label_message");
                    question_div.setAttribute("id", "captcheck_" + idp + "_label_message")
                    question_div.innerHTML = "<span class='captcheck_question_image' id='captcheck_" + idp + "_question_image'>" + data.question_i + "</span><span class='captcheck_question_access' id='captcheck_" + idp + "_question_access'>" + data.question_a + "</span><a href='' class='captcheck_alt_question_button' onClick='switchMode(\"" + idp + "\"); return false;' onEnter='switchMode(\"" + idp + "\"); return false;' id='captcheck_" + idp + "_alt_question_button' aria-label='Switch between image and text question' tabindex='0'>&gt; Text mode</a>";

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
            }
        };
        xhr.send();
    });
}

function chooseAnswer(idp, ans) {
    var box = document.getElementById("captcheck_" + idp + "_answer_" + ans);
    box.checked = true;
    return false;
}

function switchMode(idp) {
    var switch_label = document.getElementById("captcheck_" + idp + "_alt_question_button");
    var img_q = document.getElementById("captcheck_" + idp + "_question_image");
    var acc_q = document.getElementById("captcheck_" + idp + "_question_access");
    var img_a = document.getElementById("captcheck_" + idp + "_answer_images");
    var acc_a = document.getElementById("captcheck_" + idp + "_answer_access");
    if (switch_label.innerHTML == "&gt; Text mode") {
        switch_label.innerHTML = "&gt; Image mode";
        img_q.style.display = "none";
        acc_q.style.display = "initial";
        img_a.style.display = "none";
        acc_a.style.display = "initial";
        acc_a.innerHTML = "<input type='text' name='captcheck_selected_answer' aria-label='Type your answer here.' autocomplete='off' autofill='off'/>";
    } else {
        switch_label.innerHTML = "&gt; Text mode";
        img_q.style.display = "initial";
        acc_q.style.display = "none";
        img_a.style.display = "initial";
        acc_a.style.display = "none";
        acc_a.innerHTML = "";
    }
}
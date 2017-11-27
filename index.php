<!DOCTYPE html>
<title>Captcheck Sample Form</title>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<script src="captcheck.dist.js"></script>
<form action="test.php" method="POST">
    <input type="hidden" name="form_id" value="1" />
    <input type="text" name="form_field" placeholder="Some random form field" />
    <div class="captcheck_container">
    </div>
    <button type="submit">Submit Form 1</button>
</form>

<hr />

<form action="test.php" method="POST">
    <input type="hidden" name="form_id" value="2" />
    <input type="text" name="form_field" placeholder="Some random form field" />
    <div class="captcheck_container">
    </div>
    <button type="submit">Submit Form 2</button>
</form>

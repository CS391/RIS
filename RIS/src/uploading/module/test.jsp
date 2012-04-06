<%@ include file="/src/header/module/header.jsp" %>
<html>

<head>
<title>Upload</title>
</head>

<body>

<form  action="upload.jsp"  method="post"  enctype="multipart/form-data">
Select File <input type="file" name="file1">
<p>
Select Filename <input type="text" size="20" name="filename">
<p>
<input type=submit value="Upload">
</form>

</body>

</html>
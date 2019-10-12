<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改个人信息页面</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/editor.md-master/css/editormd.min.css"/>


    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/editor.md-master/editormd.js"></script>
    <script type="text/javascript">

        var mdEditor;
        /**初始化marckdown*/
        $(function () {
            mdEditor = editormd("info-editor", {
                width: "100%",
                height: "350",
                path: getRootPath() + "/static/editor.md-master/lib/",
                watch: true,
                placeholder: "填写自我介绍",
                saveHTMLToTextarea: true,
                imageUpload: true,
                imageFormats: ["jpg", "jpeg", "gif", "png", "bmp", "webp"],
                imageUploadURL: getRootPath() + "/upload/image.do"
            });

        });
        /**提交博主信息*/
        function submitData(){
            var nickName=$("#nickName").val();
            var sign=$("#sign").val();
            var proFile=mdEditor.getMarkdown();

            if(nickName==null||nickName===""){
                $.messager.alert("系统提示","请输入昵称！");
            }else if(sign==null||sign===""){
                $.messager.alert("系统提示","请输入个性签名！");
            }else if(proFile==null||proFile===""){
                $.messager.alert("系统提示","请输入简介！");
            }else{
                $("#profile").val(proFile);
                $("#form1").submit();
            }
        }

        /**获取项目路径*/
        function getRootPath() {
            var curWwwPath = window.document.location.href;
            var pathName = window.document.location.pathname;
            var pos = curWwwPath.indexOf(pathName);
            var localhostPaht = curWwwPath.substring(0, pos);
            var projectName = pathName
                .substring(0, pathName.substr(1).indexOf('/') + 1);
            return (localhostPaht + projectName);
        }
    </script>
</head>
<body style="margin: 10px">
<div id="p" class="easyui-panel" title="修改个人信息" style="padding: 10px">
    <form id="form1" action="${pageContext.request.contextPath}/admin/blogger/save.do" method="post" enctype="multipart/form-data">
        <input type="hidden" id="id" name="id" value="${currentUser.id}"/>
        <input type="hidden" id="profile" name="profile"/>
        <table cellspacing="20px">
            <tr>
                <td width="80px">用户名：</td>
                <td><input type="text" id="userName" name="userName" style="width: 200px;" value="${currentUser.userName}" readonly="readonly"/></td>
            </tr>
            <tr>
                <td>昵称：</td>
                <td><input type="text" id="nickName" name="nickName" style="width: 200px;" value="${currentUser.nickName}"/></td>
            </tr>
            <tr>
                <td>个性签名：</td>
                <td><input type="text" id="sign" name="sign" style="width: 400px;" value="${currentUser.sign}"/></td>
            </tr>

            <tr>
                <td>个人头像：</td>
                <td><input type="file" id="imageFile" name="imageFile" style="width: 400px;"/></td>
            </tr>

            <tr>
                <td>个人简介：</td>
                <div id="info-editor">
                    <label for="description">个人简介</label>
                    <textarea id="description" style="display:none;" cols="30" rows="10">${currentUser.profile}</textarea>
                </div>
            </tr>

            <tr>
                <td></td>
                <td><a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">提交</a></td>
            </tr>
        </table>
    </form>
</div>
</body>
</html>
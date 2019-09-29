<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>修改个人信息页面</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/themes/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/static/jquery-easyui-1.3.3/locale/easyui-lang-zh_CN.js"></script>

    <script type="text/javascript">

        /**提交博主信息*/
        function submitData(){
            var nickName=$("#nickName").val();
            var sign=$("#sign").val();
            var proFile=editor.txt.html();
            // var proFile=UE.getEditor("editor").getContent();

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
                <td>
                    <div id="editor">
                        ${currentUser.profile}
                    </div>
                </td>
            </tr>

            <tr>
                <td></td>
                <td><a href="javascript:submitData()" class="easyui-linkbutton" data-options="iconCls:'icon-submit'">提交</a></td>
            </tr>
        </table>
    </form>
</div>
<script type="text/javascript">
    var E = window.wangEditor;
    var editor = new E('#editor');
    // 或者 var editor = new E( document.getElementById('editor') )
    editor.customConfig.zIndex = 100;
    //插入网络图片回调
    editor.customConfig.linkImgCallback = function (url) {
        console.log(url); //TODO: url 即插入图片的地址
    }

    //TODO:插入链接校验
    editor.customConfig.linkCheck = function (text, link) {
        console.log(text); // 插入的文字
        console.log(link); // 插入的链接

        return true // 返回 true 表示校验成功
        // return '验证失败' // 返回字符串，即校验失败的提示信息
    }

    //TODO:插入网络图片时，可对图片地址做自定义校验
    editor.customConfig.linkImgCheck = function (src) {
        console.log(src); // 图片的链接

        return true; // 返回 true 表示校验成功
        // return '验证失败' // 返回字符串，即校验失败的提示信息
    }

    // editor.customConfig.uploadImgShowBase64 = true   // 使用 base64 保存图片

    // TODO:配置服务器端地址
    editor.customConfig.uploadImgServer = '${pageContext.request.contextPath}/com.blog.upload/images.do';

    //TODO：其他上传设置
    // 将图片大小限制为 3M
    editor.customConfig.uploadImgMaxSize = 3 * 1024 * 1024;

    // 限制一次最多上传 5 张图片
    editor.customConfig.uploadImgMaxLength = 5;

    //TODO:自定义 fileName
    editor.customConfig.uploadFileName = 'myFileName';

    // 将 timeout 时间改为 3s
    editor.customConfig.uploadImgTimeout = 3000;

    //TODO:监听函数
    editor.uploadImgHooks = {
        success: function (xhr, editor, result) {
            // 图片上传并返回结果，图片插入成功之后触发
            // xhr 是 XMLHttpRequst 对象，editor 是编辑器对象，result 是服务器端返回的结果
            console.log("插入图片成功　success result = " + result.errno + "  path = " + result.data[0] );
        },

        fail: function fail(xhr, editor, result) {
            console.log(" fail result = " + result.errno + "  path = " + result.data[0] );
            // 图片上传并返回结果，但图片插入错误时触发
        },
        error: function error(xhr, editor) {
            // 图片上传出错时触发
            console.log("error result = " + result.errno + "  path = " + result.data[0] );
        },
        timeout: function timeout(xhr, editor) {
            // 图片上传超时时触发
            console.log("timeout result = " + result.errno + "  path = " + result.data );
        },

        customInsert: function (insertImg, result, editor) {
            // 图片上传并返回结果，自定义插入图片的事件（而不是编辑器自动插入图片！！！）
            // insertImg 是插入图片的函数，editor 是编辑器对象，result 是服务器端返回的结果

            // 举例：假如上传图片成功后，服务器端返回的是 {url:'....'} 这种格式，即可这样插入图片：
            var urls = result.data;
            alert("customInsert:" + urls);
            for (var url in urls) {
                insertImg(url)
            }
            // result 必须是一个 JSON 格式字符串！！！否则报错
        }
    }


    editor.create();

    //TODO:全屏预览
    E.fullscreen.init('#editor');
    // editor.txt.html("hello?");
</script>
</body>
</html>
/**发布博客*/
function submitData() {
    var content = mdEditor.getMarkdown();       // 获取 Markdown 源码
    var contentHtml = mdEditor.getHTML();
    var contentNoTag = contentHtml.replace(/<[^>]*>|/g,"");
    var blogId = $("#blogId").val();
    var title = $("#title").val();
    var blogTypeId = $("#blogTypeId").combobox("getValue");
    var keyWord = $("#keyWord").val();
    var url = getRootPath()+"/admin/blog/save.do";
    if (title == null || title === '') {
        $.messager.alert("系统提示", "请输入标题！");
    } else if (blogTypeId == null || blogTypeId === '') {
        $.messager.alert("系统提示", "请输入博客类别！");
    } else if (content == null || content === '') {
        $.messager.alert("系统提示", "请输入内容！");
    } else {
        $.post(url,
            {
                'id': blogId,'title': title, 'blogType.id': blogTypeId, 'content': content,
                'contentNoTag': contentNoTag,
                'summary': contentNoTag.substr(0, 155), 'keyWord': keyWord
            },
            function (result) {
                if (result.success) {
                    $.messager.alert("系统提示", "博客发布成功！");
                } else {
                    $.messager.alert("系统提示", "博客发布失败！");
                }
            }, "json");
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
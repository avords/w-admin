/**
 * @license Copyright (c) 2003-2015, CKSource - Frederico Knabben. All rights reserved.
 * For licensing, see LICENSE.md or http://ckeditor.com/license
 */

CKEDITOR.editorConfig = function( config ) {
	config.height = 500; //高度
	//工具栏
	config.toolbar =
	[
	    ['Bold','Italic','Underline','Strike','-','Subscript','Superscript'],
	    ['NumberedList','BulletedList','-','Outdent','Indent','Blockquote'],
	    ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
	    ['Link','Unlink','Anchor'],
	    ['Image','Table','HorizontalRule','Smiley','SpecialChar','PageBreak'],
	    ['Styles','Format','Font','FontSize'],
	    ['TextColor','BGColor'],
	    ['Maximize', 'ShowBlocks','-','Source','-','Undo','Redo']

	];
	config.enterMode = CKEDITOR.ENTER_BR;
	 // 当输入：shift+Enter是插入的标签
	config.shiftEnterMode = CKEDITOR.ENTER_BR;// 
	 //图片处理
	config.pasteFromWordRemoveStyles = true;
	config.filebrowserImageUploadUrl = "about:blank?type=image";
	 
	// 去掉ckeditor“保存”按钮
	config.removePlugins = 'save';
};

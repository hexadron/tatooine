/*
 Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
*/
CKEDITOR.plugins.add("divarea",{afterInit:function(e){e.addMode("wysiwyg",function(t){var n=CKEDITOR.dom.element.createFromHtml('<div class="cke_wysiwyg_div cke_reset" hidefocus="true"></div>');e.ui.space("contents").append(n),n=e.editable(n),n.detach=CKEDITOR.tools.override(n.detach,function(e){return function(){e.apply(this,arguments),this.remove()}}),e.setData(e.getData(1),t),e.fire("contentDom")})}});
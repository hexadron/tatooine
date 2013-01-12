/*
 Copyright (c) 2003-2012, CKSource - Frederico Knabben. All rights reserved.
 For licensing, see LICENSE.html or http://ckeditor.com/license
*/
CKEDITOR.plugins.add("docprops",{requires:"dialog",lang:"af,ar,bg,bn,bs,ca,cs,cy,da,de,el,en-au,en-ca,en-gb,en,eo,es,et,eu,fa,fi,fo,fr-ca,fr,gl,gu,he,hi,hr,hu,is,it,ja,ka,km,ko,lt,lv,mk,mn,ms,nb,nl,no,pl,pt-br,pt,ro,ru,sk,sl,sr-latn,sr,sv,th,tr,ug,uk,vi,zh-cn,zh",icons:"docprops,docprops-rtl",init:function(e){var t=new CKEDITOR.dialogCommand("docProps");t.modes={wysiwyg:e.config.fullPage},e.addCommand("docProps",t),CKEDITOR.dialog.add("docProps",this.path+"dialogs/docprops.js"),e.ui.addButton&&e.ui.addButton("DocProps",{label:e.lang.docprops.label,command:"docProps",toolbar:"document,30"})}});
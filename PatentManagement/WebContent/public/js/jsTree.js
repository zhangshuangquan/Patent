(function ($, undefined) {
	var noop = function () {};
	var slice = Array.prototype.slice;
	var _clearSelect; 
	if (window.getSelection) {
		_clearSelect = function () {
			window.getSelection().removeAllRanges()
		}
	} else {
		_clearSelect = function () {
			document.selection.empty();
		}
	}
	var defaults = {
		filter: function () {
			return true;
		},
		onExpand: function (data, $li, callback) {
			this.loadNode(data.childs, $li);
			callback();
		},
		hasCheckBox: true,
		extendTree: {},
		treeType: 1,
		dragSelector: false,
		clickItem: noop,
		onDragEnd: noop,
		extraHtml: '',
		hasChild: false,
		idKey: 'id',
		nameKey: 'name'
	};
	var $doc = $(document);
	function JsTree($elm, options) {
		this.$elm = $elm;
		this.options = options;
		this.leafMap = {};
		this.nodeMap = {};
		$.extend(this, options.extendTree);
		this.init();
	}
	JsTree.prototype = {
		init: function () {
			var options = this.options;
			this.$elm.html('').addClass('jsTree-warper');
			this.$root = $('<ul class="jsTree-root jsTree-deep1 jsTree-expand" data-deep="1" ></ul>').appendTo(this.$elm);
			this['bindEvent' + options.treeType]();
			if (options.dragSelector) {
				this.bindDrag(options.dragSelector);
			}
			if (options.treeData) {
				this.loadData(options.treeData);
			}
		},
		bindDrag: function (dragSelector) {
			var options = this.options;
			var changeCursorTimeId = 0;
			var $warp = this.$elm.on('mousedown', dragSelector, function (event) {
				if (event.which == 1) {
					event.stopPropagation();//防止冒泡，多结点绑定拖动
					var $dragElm = $(this);
					var $siblings = $dragElm.siblings();
					//if ($siblings.length == 0) return;
					var downPos = [event.clientX, event.clientY];
					var startIndex = $dragElm.index();
					var statrDrag = false;
					var $dragElmClone;
					var $placeHolder;
					var downElm;
					var $siblingsTab = [];
					clearTimeout(changeCursorTimeId);
					changeCursorTimeId = setTimeout(function () {
						$dragElm.find('label').css("cursor", "move");
					}, 200);
					var target = event.target;
					if (target.setCapture) {
						target.setCapture();
					} else {
						document.body.setCapture();
					}
					var moveTrigger = function (event) {
						_clearSelect();
						if (!statrDrag) {
							statrDrag = true;
							var height = $dragElm.height();
							var width = $dragElm.width();
							var offset = $dragElm.offset();
							downElm = [$dragElm[0].offsetLeft, $dragElm[0].offsetTop];
							$siblings.each(function () {
								$siblingsTab.push($(this));
							});
							$dragElmClone = $dragElm.clone()
													.css({position: "absolute", opacity: 0.8, "z-index": 999, height: height, width: width})
													.insertAfter($dragElm.hide());
							$placeHolder = $('<li class="jsTree-dragHolder" style="height: ' + height + 'px; width: ' + width + 'px;"></li>').insertAfter($dragElm);
						} else {
							var disX = downElm[0] + (event.clientX - downPos[0]);
							var disY = downElm[1] + (event.clientY - downPos[1]);
							$dragElmClone.css({left: disX, top: disY});
							var $elm;
							for (var i = 0, len = $siblingsTab.length; i < len; i++) {
								if (event.clientY > $siblingsTab[i].offset().top) {
									$elm = $siblingsTab[i];
								} else {
									break;
								}
							}
							if ($elm) {
								$elm.after($placeHolder);
							} else {
								$dragElm.parent().prepend($placeHolder);
							}
						}
					};
					$doc.on('mousemove', moveTrigger).one('mouseup', function (event) {
						var target = event.target;
						if (target.setCapture) {
							target.releaseCapture();
						} else {
							document.body.releaseCapture();
						}
						$doc.off('mousemove', moveTrigger);
						clearTimeout(changeCursorTimeId);
						$dragElm.show().find('label').css("cursor", "pointer");
						if ($placeHolder) {
							$placeHolder.after($dragElm);
							$placeHolder.remove();
							$dragElmClone.remove();
							var endIndex = $dragElm.index();
							if (startIndex != endIndex){
								options.onDragEnd($dragElm, startIndex, endIndex);
							}
						}
						$siblings = null;
						$dragElm = null;
						statrDrag = false;
					});
				}
			})
		},
		bindEvent1: function () {
			var self = this;
			this.$elm.on('click', '.jsTree-node>.jsTree-content', function (event) {
				var $label = $(this);
				var $li = $label.parent();
				var $ul = $li.find('ul:eq(0)');
				var target = event.target;
				if (target.tagName.toUpperCase() == 'INPUT') {
					var checked = target.checked;
					$ul.find('input').each(function () {
						this.checked = checked;
					})
					self._checkParent($li, checked);
					return;
				}
				if ($ul.hasClass('jsTree-expand')) {
					$label.removeClass('jsTree-expand');
					$ul.removeClass('jsTree-expand');
				} else {
					$label.addClass('jsTree-expand');
					$ul.addClass('jsTree-expand');
				}
				event.preventDefault();
			}).on('click', '.jsTree-leaf input', function () {
				var $li = $(this).parent().parent();
				self._checkParent($li, this.checked);
			});
		},
		bindEvent2: function () {
			var self = this;
			var options = this.options;
			var leafMap = this.leafMap;
			var nodeMap = this.nodeMap;
			this.$elm.on('click', '.jsTree-content label', function (event) {
				var $content = $(this).parent();
				var $li = $content.parent();
				var $ul = $li.find('ul:eq(0)');
				var $ipt = $content.find('input');
				var $target = $(event.target);
				if ($target.hasClass('jsTree-expandBtn')) {
					if ($ul.hasClass('jsTree-expand')) {
						$content.removeClass('jsTree-expand');
						$ul.removeClass('jsTree-expand');
					} else {
						if (options.onExpand) {
							options.onExpand.call(self, nodeMap[$li.attr('data-id')], $li, function () {
								$content.addClass('jsTree-expand');
								$ul.addClass('jsTree-expand');
							})
						}
					}
				} else {
					if ($li.hasClass('jsTree-node')) {
						options.clickItem(nodeMap[$li.attr('data-id')], 'node', $li);
					} else {
						options.clickItem(leafMap[$li.attr('data-id')], 'leaf', $li);
					}
				}
				event.preventDefault();
			})
		},
		clear: function () {
			this.$root.html('');
			this.leafMap = {};
			this.nodeMap = {};
		},
		_checkParent: function ($li, checked) {
			$li.siblings().find('input').each(function () {
				if (this.checked != checked) {
					checked = false;
					return true;
				}
			})
			var $parentLi = $li.parent().parent();
			if ($parentLi.hasClass('jsTree-warper'))  return;
			$parentLi.find('input')[0].checked = checked;
			this._checkParent($parentLi, checked);
		},
		_loadHtml: function (treeData, deep, opt) {
			opt = opt || {};
			var self = this;
			var leafMap = this.leafMap;
			var nodeMap = this.nodeMap;
			var options = $.extend({}, this.options , opt);
			var hasChild = options.hasChild;
			var isHasChildFn = $.isFunction(hasChild);
			var idKey = options.idKey;
			var nameKey = options.nameKey;
			var extraHtml = options.extraHtml;
			var isExtraHtmlFn = $.isFunction(extraHtml);
			var hasCheckBox = options.hasCheckBox;
			var html = [];
			var cDeep = deep + 1;			
			$.each(treeData, function () {
				if (options.filter(this) === false) return;
				var id = this[idKey], name = this[nameKey]||id;
				this.__deep = deep;
				this.__key = id;
				if (isHasChildFn) {
					if (hasChild(this)) {
						this.childs = this.childs || [];
					}
				} else if (hasChild) {
					this.childs = this.childs || [];
				}
				if (this.childs) {//node				
					nodeMap[id] = this;
					html.push('<li class="jsTree-node" data-id="' + id + '">\
									<div class="jsTree-content  clearfix ' + (options.isExpand?" jsTree-expand ": "") + '" title="' + name + '" >\
										<label>\
											<span class="jsTree-expandBtn"></span>\
											<input type="checkbox" id="jsTree' + id + '" value="' + id + '" autocomplete="off" ' + (hasCheckBox? '' : ' class="hide" ') + '>'+ name + '</label>'
											+ (isExtraHtmlFn?extraHtml(this):extraHtml) +
									'</div>' +
									(options.isExpand? '<ul class="jsTree-deep' + cDeep + ' jsTree-expand" data-deep="' + cDeep + '" >' + self._loadHtml(this.childs, cDeep, opt) + '</ul>' : '') +
								'</li>');
				} else {//leaf
					leafMap[id] = this;
					html.push('<li class="jsTree-leaf" data-id="' + id + '">\
									<div class="jsTree-content clearfix" title="' + name + '" >\
										<label title="' + name + '" >\
											<input type="checkbox" id="jsTree' + id + '" value="' + id + '" autocomplete="off" ' + (hasCheckBox? '' : ' class="hide" ') + '>' + name + '</label>'
											+ (isExtraHtmlFn?extraHtml(this):extraHtml) +
									'</div>\
								</li>');
				}
			});
			return html.join('');
		},
		rushLeafCheck: function (map) {
			var self = this;
			$('.jsTree-leaf input').each(function () {
				var flag = false;
				var checked = this.checked;
				if (map[this.value]) {
					this.checked = true;
					if (checked == false) {
						flag = true;
					}
				} else {
					this.checked = false;
					if (checked == true) {
						flag = true;
					}
				}
				if (flag) {
					self._checkParent($(this).parent().parent(), true);
				}
			})
		},
		loadData: function (treeData, $ul) {
			$ul = $ul || this.$root;
			$ul.html(this._loadHtml(treeData, $ul.attr('data-deep')*1));
		},
		loadNode: function (treeData, $li, opt) {
			opt = opt || {};
			var leafMap = this.leafMap;
			var nodeMap = this.nodeMap;
			var id = $li.attr('data-id');
			var $ul = $li.parent();
			var deep = $ul.attr('data-deep')*1 + 1;
			if ($li.hasClass('jsTree-leaf')) {
				var node = leafMap[id];
				node.childs = treeData;
				delete leafMap[id];
				nodeMap[id] = node;
				$li.removeClass('jsTree-leaf').addClass('jsTree-node');
				$li.children('.jsTree-content').addClass('jsTree-expand').children('label').prepend('<span class="jsTree-expandBtn"></span>');
			} else {
				var node = nodeMap[id];
				node.childs = treeData;
				$li.children('.jsTree-content').addClass('jsTree-expand');
			}
			$ul = $li.children('ul');
			if ($ul.length == 0) {
				$ul = $('<ul class="jsTree-deep' + deep + ' jsTree-expand" data-deep="' + deep + '" ></ul>').appendTo($li);
			}
			$ul.html(this._loadHtml(treeData, deep, opt));
		},
		extendOpt: function (opt) {
			if (typeof opt == "object" ) {
				$.extend(this.options, opt);
			} else {
				return this.options[opt];
			}
		},
		getAllLeafData: function () {
			var data = [];
			var data2 = [];
			var leafMap = this.leafMap;
			this.$elm.find('.jsTree-leaf input').each(function () {
				if (this.checked)
					data.push(leafMap[this.value]);
				else 
					data2.push(leafMap[this.value]);
			});
			return [data, data2];
		},
		getLeafData: function (flag) {
			flag = flag || false;
			var data = [];
			var leafMap = this.leafMap;
			this.$elm.find('.jsTree-leaf input').each(function () {
				if (this.checked || flag)
					data.push(leafMap[this.value]);
			});
			return data;
		}
	}
	
	$.fn.jsTree = function (options) {
		var args = slice.call(arguments, 1);
		var res;
		var flag = false;
		this.each(function () {
			var $elm = $(this);
			var jsTree = $elm.data('jsTree');
			if (typeof options == "string" ) {
				if (jsTree && jsTree[options]) {
					var opt = jsTree[options];
					if ($.isFunction(opt)) {
						res = opt.apply(jsTree, args);
						if (res !== undefined) {
							flag = true;
							return true;
						}
					} else {
						if (args.length == 0) {
							res = opt;
							flag = true;
							return true;
						} else if (args.length == 1) {
							jsTree[options] = args[0];
						}
					}
				}
			} else {
				$elm.data('jsTree', new JsTree($elm, $.extend({}, defaults, options)));
				}
			})
		if (flag) {
			return res;
		} else {
			return this;
		}
	}

	$.fn.jsTree.tab2Tree = function (tab, opt) {//ordery by parentId, sort
		opt = opt || {};
		var _opt = $.extend({idKey: 'id',nameKey: 'name', parentKey: 'parentId'}, opt);
		var parentKey = _opt.parentKey;
		var idKey = _opt.idKey;
		var nameKey = _opt.nameKey;
		var nMap = {};
		var pMap = {};
		var haaNoParentMap = {};
		for (var i = 0, len = tab.length; i < len; i++) {
			var obj = tab[i];
			nMap[obj[idKey]] = obj;
			var parentId = obj[parentKey];
			if (pMap[parentId]) {
				pMap[parentId].childs.push(obj);
			} else {
				pMap[parentId] = {
					childs: [obj]
				}
			}
			if (nMap[parentId]) {
				nMap[parentId].childs = pMap[parentId].childs;
			}
		}
		return pMap;
	}
 })(jQuery);
/***
var treeData = [
	{
		id:'g0',
		name: '老师',
		childs : [
			{id:'t1', name: '老师1'},
			{id:'t2', name: '老师2'}
		]
	},
	{
		id:'c1',
		name: '年级',
		childs : [
			{id:'g1', name: '班级1', childs: [{id:'s1', name: '学生1'},{id:'s2', name: '学生2'}] },
			{id:'g2', name: '班级2', childs: [{id:'s3', name: '学生3'}]},
			{id:'g3', name: '班级3', childs: []}
		]
	}
];
$('div').jsTree({
	treeData: treeData,
	hasCheckBox: false,
	treeType: 1,
	extraHtml: '<div class="jsTree-operate">删除 添加 修改</div>',
	dragSelector: '.jsTree-node,.jsTree-leaf'
});
***/
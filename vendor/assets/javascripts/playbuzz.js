(function() {
	/**
	 * Light
	 *
	 * This is an extreme small and easy JavaScript library. It can
	 * be used for small websites which won't be needing all the
	 * functionality of the bigger libraries around. Or use it to
	 * learn how to create your own library or framework.
	 *
	 * @author    Victor Villaverde Laan <info@freelancephp.net>
	 * @link      http://www.freelancephp.net/light-4kb-min-jquery-light/
	 * @license   Dual licensed under the MIT and GPL licenses
	 */
	if (window.PlayBuzz || (window.PlayBuzz = {}), !window.PlayBuzz || !window.PlayBuzz.jQuery) {
		window.PlayBuzz.jQuery = function(t, i) {
			return new n.core.init(t, i)
		};
		var n = window.PlayBuzz.jQuery;
		n.core = n.prototype = {
			init : function(t, i) {
				var r;
				if ( t = t || window, i = i || document, r = typeof t == "string" ? n.selector(t, i) : r = t, this.els = [], r && typeof r.length != "undefined")
					for (var u = 0, f = r.length; u < f; u++)
						this.els.push(r[u]);
				else
					this.els.push(r);
				return this
			},
			get : function(n) {
				return typeof n == "undefined" ? this.els : this.els[n]
			},
			count : function() {
				return this.els.length
			},
			each : function(n) {
				for (var t = 0, i = this.els.length; t < i; t++)
					n.call(this, this.els[t]);
				return this
			},
			attr : function(n, t, i) {
				if ( typeof t == "undefined") {
					var r = this.get(0);
					if (r)
						return r.attributes[n].value
				}
				return this.each(function(r) {
					typeof i == "undefined" ? r[n] = t : r[i][n] = t
				}), this
			},
			css : function(n) {
				var t = this;
				return this.each(function() {
					for (var i in n)
					t.attr(i, n[i], "style")
				}), this
			},
			addClass : function(n) {
				return this.each(function(t) {
					t.className += " " + n
				}), this
			},
			removeClass : function(n) {
				return this.each(function(t) {
					t.className = t.className.replace(n, "")
				}), this
			},
			on : function(n, t) {
				var i = function(i) {
					window.addEventListener ? i.addEventListener(n, t, !1) : window.attachEvent && i.attachEvent("on" + n, function() {
						t.call(i, window.event)
					})
				};
				return this.each(function(n) {
					i(n)
				}), this
			},
			ready : function(n) {
				return t.add(n), this
			},
			remove : function() {
				return this.each(function(n) {
					try {
						n.parentNode.removeChild(n)
					} catch(t) {
					}
				}), this
			},
			offset : function() {
				var i = {
					top : 0,
					left : 0
				}, n = this.get(0);
				if ( doc = n && n.ownerDocument, doc) {
					var t = doc.documentElement;
					return n.getBoundingClientRect != undefined && ( i = n.getBoundingClientRect()), {
						top : i.top + (window.pageYOffset || t.scrollTop) - (t.clientTop || 0),
						left : i.left + (window.pageXOffset || t.scrollLeft) - (t.clientLeft || 0)
					}
				}
			},
			parent : function() {
				var n = this.get(0).parentNode;
				return PlayBuzz.jQuery(n)
			},
			width : function(n) {
				var i = {
					top : 0,
					left : 0
				}, t = this.get(0);
				if ( doc = t && t.ownerDocument, doc) {
					if (n)
						return t.style.width = n, n;
					t.getBoundingClientRect != undefined && ( i = t.getBoundingClientRect());
					return i.width || t.offsetWidth
				}
			},
			height : function() {
				var t = {
					top : 0,
					left : 0
				}, n = this.get(0);
				if ( doc = n && n.ownerDocument, doc) {
					var i = doc.documentElement;
					return n.getBoundingClientRect != undefined && ( t = n.getBoundingClientRect()), t.height
				}
			}
		};
		n.selector = function(n, t) {
			for (var h = n.split(","), u, e, o, s = 0; s < h.length; s++) {
				var f = h[s].replace(/ /g, "");
				typeof f == "string" && ( e = f.substr(0, 1), o = f.substr(1), e == "#" ? ( u = document.getElementById(o), u = i(u, t) ? u : null) : u = e == "." ? r(o, t) : t.getElementsByTagName(f))
			}
			return u
		};
		n.core.init.prototype = n.core;
		var t = function() {
			var n = [], t = !1, i = function() {
				t = !0;
				for (var i = 0; i < n.length; i++)
					n[i].call()
			};
			return this.add = function(i) {
				if (i.constructor == String) {
					var u = i, r = window[i];
					if (!r || typeof r != "function")
						return;
					i = function() {
						r()
					}
				}
				t ? i.call() : n[n.length] = i
			}, window.addEventListener ? document.addEventListener("DOMContentLoaded", function() {
				i()
			}, !1) : function() {
				if (document.uniqueID || !document.expando) {
					var n = document.createElement("document:ready");
					try {
						n.doScroll("left");
						i()
					} catch(t) {
						setTimeout(arguments.callee, 0)
					}
				}
			}(), this
		}();
		n.ready = t.add;
		function i(n, t) {
			try {
				return n.parentNode == t || n.parentNode != document && i(n.parentNode, t)
			} catch(r) {
				return !1
			}
		}

		function r(n, t) {
			var u = [], f = new RegExp("\\b" + n + "\\b"), r = t.getElementsByTagName("*");
			t = t || document.getElementsByTagName("body")[0];
			for (var i = 0, e = r.length; i < e; i++)
				f.test(r[i].className) && u.push(r[i]);
			return u
		}

	}
})(), function() {
	var o = PlayBuzz.jQuery.DomReady = {}, n = navigator.userAgent.toLowerCase(), u = {
		version : (n.match(/.+(?:rv|it|ra|ie)[\/: ]([\d.]+)/)||[])[1],
		safari : /webkit/.test(n),
		opera : /opera/.test(n),
		msie : /msie/.test(n) && !/opera/.test(n),
		mozilla : /mozilla/.test(n) && !/(compatible|webkit)/.test(n)
	}, f = !1, t = !1, i = [];
	function r() {
		if (!t && ( t = !0, i)) {
			for (var n = 0; n < i.length; n++)
				i[n].call(window, []);
			i = []
		}
	}

	function s(n) {
		var t = window.onload;
		window.onload = typeof onload != "function" ? n : function() {
			t && t();
			n()
		}
	}

	function e() {
		if (!f) {
			if ( f = !0, document.addEventListener && !u.opera && document.addEventListener("DOMContentLoaded", r, !1), u.msie && window == top && function() {
				if (!t) {
					try {
						document.documentElement.doScroll("left")
					} catch(n) {
						setTimeout(arguments.callee, 0);
						return
					}
					r()
				}
			}(), u.opera && document.addEventListener("DOMContentLoaded", function() {
				if (!t) {
					for (var n = 0; n < document.styleSheets.length; n++)
						if (document.styleSheets[n].disabled) {
							setTimeout(arguments.callee, 0);
							return
						}
					r()
				}
			}, !1), u.safari) {
				var n;
				(function() {
					if (!t) {
						if (document.readyState != "loaded" && document.readyState != "complete") {
							setTimeout(arguments.callee, 0);
							return
						}
						if (n === undefined) {
							for (var u = document.getElementsByTagName("link"), i = 0; i < u.length; i++)
								u[i].getAttribute("rel") == "stylesheet" && n++;
							var f = document.getElementsByTagName("style");
							n += f.length
						}
						if (document.styleSheets.length != n) {
							setTimeout(arguments.callee, 0);
							return
						}
						r()
					}
				})()
			}
			s(r)
		}
	}
	o.ready = function(n) {
		e();
		t ? n.call(window, []) : i.push(function() {
			return n.call(window, [])
		})
	};
	e()
}();
window.PlayBuzz || (window.PlayBuzz = {});
PlayBuzz.Partners = function() {
	var n, t, i = {
		funniest : function() {
		}
	};
	function r() {
		if ( n = PlayBuzz.jQuery("#pb_feed").get(0) || PlayBuzz.jQuery(".pb_feed").get(0), n)
			try {
				t = function() {
					var t = n.attributes["data-key"];
					return t ? t.value : null
				}();
				i[t] && i[t]()
			} catch(r) {
			}
	}
	return {
		render : r
	}
}();
window.JSON || (window.JSON = {}, function() {
	"use strict";
	function i(n) {
		return n < 10 ? "0" + n : n
	}
	typeof Date.prototype.toJSON != "function" && (Date.prototype.toJSON = function() {
		return isFinite(this.valueOf()) ? this.getUTCFullYear() + "-" + i(this.getUTCMonth() + 1) + "-" + i(this.getUTCDate()) + "T" + i(this.getUTCHours()) + ":" + i(this.getUTCMinutes()) + ":" + i(this.getUTCSeconds()) + "Z" : null
	}, String.prototype.toJSON = Number.prototype.toJSON = Boolean.prototype.toJSON = function() {
		return this.valueOf()
	});
	var f = /[\u0000\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, e = /[\\\"\x00-\x1f\x7f-\x9f\u00ad\u0600-\u0604\u070f\u17b4\u17b5\u200c-\u200f\u2028-\u202f\u2060-\u206f\ufeff\ufff0-\uffff]/g, n, r, s = {
		"\b" : "\\b",
		"\t" : "\\t",
		"\n" : "\\n",
		"\f" : "\\f",
		"\r" : "\\r",
		'"' : '\\"',
		"\\" : "\\\\"
	}, t;
	function o(n) {
		return e.lastIndex = 0, e.test(n) ? '"' + n.replace(e, function(n) {
			var t = s[n];
			return typeof t == "string" ? t : "\\u" + ("0000" + n.charCodeAt(0).toString(16)).slice(-4)
		}) + '"' : '"' + n + '"'
	}

	function u(i, f) {
		var s, l, h, a, v = n, c, e = f[i];
		e && typeof e == "object" && typeof e.toJSON == "function" && ( e = e.toJSON(i));
		typeof t == "function" && ( e = t.call(f, i, e));
		switch(typeof e) {
		case"string":
			return o(e);
		case"number":
			return isFinite(e) ? String(e) : "null";
		case"boolean":
		case"null":
			return String(e);
		case"object":
			if (!e)
				return "null";
			if (n += r, c = [], Object.prototype.toString.apply(e) === "[object Array]") {
				for ( a = e.length, s = 0; s < a; s += 1)
					c[s] = u(s, e) || "null";
				return h = c.length === 0 ? "[]" : n ? "[\n" + n + c.join(",\n" + n) + "\n" + v + "]" : "[" + c.join(",") + "]", n = v, h
			}
			if (t && typeof t == "object")
				for ( a = t.length, s = 0; s < a; s += 1)
					typeof t[s] == "string" && ( l = t[s], h = u(l, e), h && c.push(o(l) + ( n ? ": " : ":") + h));
			else
				for (l in e)Object.prototype.hasOwnProperty.call(e, l) && ( h = u(l, e), h && c.push(o(l) + ( n ? ": " : ":") + h));
			return h = c.length === 0 ? "{}" : n ? "{\n" + n + c.join(",\n" + n) + "\n" + v + "}" : "{" + c.join(",") + "}", n = v, h
		}
	}
	typeof JSON.stringify != "function" && (JSON.stringify = function(i, f, e) {
		var o;
		if ( n = "", r = "", typeof e == "number")
			for ( o = 0; o < e; o += 1)
				r += " ";
		else
			typeof e == "string" && ( r = e);
		if ( t = f, f && typeof f != "function" && ( typeof f != "object" || typeof f.length != "number"))
			throw new Error("JSON.stringify");
		return u("", {
			"" : i
		})
	});
	typeof JSON.parse != "function" && (JSON.parse = function(n, t) {
		var i;
		function r(n, i) {
			var f, e, u = n[i];
			if (u && typeof u == "object")
				for (f in u)Object.prototype.hasOwnProperty.call(u, f) && ( e = r(u, f), e !== undefined ? u[f] = e :
				delete u[f]);
			return t.call(n, i, u)
		}

		if ( n = String(n), f.lastIndex = 0, f.test(n) && ( n = n.replace(f, function(n) {
				return "\\u" + ("0000" + n.charCodeAt(0).toString(16)).slice(-4)
			})), /^[\],:{}\s]*$/.test(n.replace(/\\(?:["\\\/bfnrt]|u[0-9a-fA-F]{4})/g, "@").replace(/"[^"\\\n\r]*"|true|false|null|-?\d+(?:\.\d*)?(?:[eE][+\-]?\d+)?/g, "]").replace(/(?:^|:|,)(?:\s*\[)+/g, "")))
			return i = eval("(" + n + ")"), typeof t == "function" ? r({
				"" : i
			}, "") : i;
		throw new SyntaxError("JSON.parse");
	})
}());
window.PlayBuzz || (window.PlayBuzz = {});
PlayBuzz.core || (PlayBuzz.core = function() {
	var u = {
		init : function() {
			this.browser = this.searchString(this.dataBrowser) || "An unknown browser";
			this.version = this.searchVersion(navigator.userAgent) || this.searchVersion(navigator.appVersion) || "an unknown version";
			this.OS = this.searchString(this.dataOS) || "an unknown OS"
		},
		searchString : function(n) {
			for (var t = 0; t < n.length; t++) {
				var i = n[t].string, r = n[t].prop;
				if (this.versionSearchString = n[t].versionSearch || n[t].identity, i) {
					if (i.indexOf(n[t].subString) != -1)
						return n[t].identity
				} else if (r)
					return n[t].identity
			}
		},
		searchVersion : function(n) {
			var t = n.indexOf(this.versionSearchString);
			if (t != -1)
				return parseFloat(n.substring(t + this.versionSearchString.length + 1))
		},
		dataBrowser : [{
			string : navigator.userAgent,
			subString : "Chrome",
			identity : "Chrome"
		}, {
			string : navigator.userAgent,
			subString : "OmniWeb",
			versionSearch : "OmniWeb/",
			identity : "OmniWeb"
		}, {
			string : navigator.vendor,
			subString : "Apple",
			identity : "Safari",
			versionSearch : "Version"
		}, {
			prop : window.opera,
			identity : "Opera",
			versionSearch : "Version"
		}, {
			string : navigator.vendor,
			subString : "iCab",
			identity : "iCab"
		}, {
			string : navigator.vendor,
			subString : "KDE",
			identity : "Konqueror"
		}, {
			string : navigator.userAgent,
			subString : "Firefox",
			identity : "Firefox"
		}, {
			string : navigator.vendor,
			subString : "Camino",
			identity : "Camino"
		}, {
			string : navigator.userAgent,
			subString : "Netscape",
			identity : "Netscape"
		}, {
			string : navigator.userAgent,
			subString : "MSIE",
			identity : "Explorer",
			versionSearch : "MSIE"
		}, {
			string : navigator.userAgent,
			subString : "Gecko",
			identity : "Mozilla",
			versionSearch : "rv"
		}, {
			string : navigator.userAgent,
			subString : "Mozilla",
			identity : "Netscape",
			versionSearch : "Mozilla"
		}],
		dataOS : [{
			string : navigator.platform,
			subString : "Win",
			identity : "Windows"
		}, {
			string : navigator.platform,
			subString : "Mac",
			identity : "Mac"
		}, {
			string : navigator.userAgent,
			subString : "iPhone",
			identity : "iPhone/iPod"
		}, {
			string : navigator.platform,
			subString : "Linux",
			identity : "Linux"
		}]
	};
	u.init();
	var n = {}, c = document.getElementById("pb_iframe_con") != null && document.getElementById("pb_iframe_con") != undefined, f = new Image;
	f.src = "//cdn.playbuzz.com/content/images/spinnerSmall.gif";
	var r = function() {
		var n = [];
		return {
			postMessage : function(n, t) {
				try {
					if (window.postMessage) {
						if (n.postMessage) {
							n.postMessage(t, "*");
							return
						}
						if (n.contentWindow) {
							n.contentWindow.postMessage(t, "*");
							return
						}
					}
				} catch(i) {
				}
				try {
					n.pbFrameListener(t)
				} catch(i) {
				}
			},
			listen : function(t) {
				window.postMessage ? e(window, "message", t) : n.push(t)
			}
		}
	}();
	function s() {
		var n = new Image;
		return n.src = f.src, n.style.position = "absolute", n.style.left = "50%", n.style.top = "50%", n.style.marginLeft = "-16px", n.style.marginTop = "-16px", n.style.setProperty("width", "auto", "important"), n.style.setProperty("height", "auto", "important"), n
	}

	function h(n, t) {
		try {
			return n.getElementsByClassName(t)
		} catch(o) {
			for (var u = [], f = new RegExp("(^| )" + t + "( |$)"), r = n.getElementsByTagName("div"), i = 0, e = r.length; i < e; i++)
				f.test(r[i].className) && u.push(r[i]);
			return u
		}
	}

	function t() {
		try {
		} catch(n) {
		}
	}

	function e(n, t, i) {
		n.addEventListener ? n.addEventListener(t, i) : n.attachEvent("on" + t, i)
	}

	function o(i, r) {
		if (n[i])
			for (var u = 0; u < n[i].length; u++)
				try {
					typeof n[i][u] == "function" && n[i][u](r)
				} catch(f) {
					t(n[i][u] + " is not a valid callback")
				}
	}

	var i = {
		browser : u,
		isMobile : function() {
			return navigator.userAgent.match(/Android/i) || navigator.userAgent.match(/webOS/i) || navigator.userAgent.match(/iPhone/i) || navigator.userAgent.match(/iPad/i) || navigator.userAgent.match(/iPod/i) || navigator.userAgent.match(/BlackBerry/i) || navigator.userAgent.match(/Windows Phone/i) ? !0 : !1
		}(),
		getURLParam : function(n) {
			n && ( n = n.toLowerCase());
			var r = document.location.toString(), u = r.split("?");
			if (u.length <= 1)
				return null;
			var c = u[0], f = r.substr(c.length + 1), e = {};
			if (f) {
				var o = f.split("&");
				try {
					for (var t = 0; t < o.length; t++) {
						var i = o[t].split("=");
						if (i.length > 1) {
							var s = i[0], h = i[1].toLowerCase();
							if (n == s.toLowerCase())
								return h;
							e[s] = h
						}
					}
				} catch(l) {
				}
			} else
				return null;
			return n == undefined ? e : null
		},
		getDivsByClassName : h,
		dispatchEvent : o,
		listen : function(t, i) {
			n[t] || (n[t] = []);
			n[t].push(i)
		},
		ajax : function(n, t, i, r) {
			var u = function() {
				var n = !1;
				if ( typeof ActiveXObject != "undefined")
					try {
						n = new ActiveXObject("Msxml2.XMLHTTP")
					} catch(t) {
						try {
							n = new ActiveXObject("Microsoft.XMLHTTP")
						} catch(i) {
							n = !1
						}
					}
				else if (window.XMLHttpRequest)
					try {
						n = new XMLHttpRequest
					} catch(t) {
						n = !1
					}
				return n
			}();
			if (u && n) {
				if (u.overrideMimeType && u.overrideMimeType("text/xml"), !r)
					var r = "text";
				r = r.toLowerCase();
				var f = "uid=" + (new Date).getTime();
				n += n.indexOf("?") + 1 ? "&" : "?";
				n += f;
				u.open("GET", n, !0);
				u.onreadystatechange = function() {
					if (u.readyState == 4 && u.status == 200) {
						var n = "";
						u.responseText && ( n = u.responseText);
						r.charAt(0) == "j" && ( n = n.replace(/[\n\r]/g, ""), n = eval("(" + n + ")"));
						i && i(n, t)
					}
				};
				u.send(null)
			}
		},
		loadDiv : function(n, i, r) {
			var u;
			if (window.XDomainRequest) {
				u = new XDomainRequest;
				u.onerror = function() {
					t("there was an error loading data")
				};
				u.onload = function() {
					r && r(u, i, !0)
				};
				u.open("get", n);
				u.send();
				return
			}
			if (window.XMLHttpRequest) {
				u = new XMLHttpRequest;
				u.onreadystatechange = function() {
					r && r(u, i)
				};
				try {
					u.open("GET", n, !0);
					u.send(null)
				} catch(f) {
					t(f)
				}
			} else
				u = new ActiveXObject("Microsoft.XMLHTTP"), u && (u.onreadystatechange = function() {
					r && r(u, i)
				}, u.open("GET", n, !0), u.send());
			return !1
		},
		render : function() {
			PlayBuzz.Partners && PlayBuzz.Partners.render();
			PlayBuzz.Feed && PlayBuzz.Feed.renderFeed(!0);
			PlayBuzz.Widget && PlayBuzz.Widget.renderWidget();
			PlayBuzz.Hub && PlayBuzz.Hub.renderHub()
		},
		sendAnalyticsEvent : function(n) {
			PlayBuzz.core.sendMessageToParent({
				name : "analyticsEvent",
				event : n,
				id : PlayBuzz.core.getURLParam("divId")
			}, 1)
		},
		sendMessageToParent : function(n) {
			var u = document.getElementById("pb_iframe_com");
			try {
				typeof n != "string" && ( n = JSON.stringify(n));
				r.postMessage(parent, n)
			} catch(i) {
				t(i)
			}
		},
		sendMessageToIframe : function(n, i) {
			try {
				typeof n != "string" && ( n = JSON.stringify(n));
				var u = i || PlayBuzz.jQuery(".pb_feed_iframe", document).get(0);
				r.postMessage(u, n, !0)
			} catch(f) {
				t(f)
			}
		},
		onFrameMessage : function(t) {
			var f = t.data ? t.data : t;
			try {
				var r = JSON.parse(f);
				switch(r.name) {
				case"analyticsEvent":
					if (n.analyticsEvent)
						for (var u = 0; u < n.analyticsEvent.length; u++)
							n.analyticsEvent[u](r.event);
					break;
				case"isAlive":
					if (PlayBuzz.Feed) {
						var e = PlayBuzz.Feed.getFeedContainer(r.id);
						i.stopSpinner(e)
					}
				}
			} catch(t) {
			}
			o("onMessage", f)
		},
		spin : function(n) {
			n && (n.spinner || (n.spinner = s(), n.appendChild(n.spinner), n.style.position == "" && (n.style.position = "relative")))
		},
		stopSpinner : function(n) {
			if (n && n.spinner) {
				try {
					n.removeChild(n.spinner)
				} catch(t) {
				}
				n.spinner = null
			}
		}
	};
	return setTimeout(function() {
		try {
			PlayBuzz.jQuery.DomReady.ready(i.render)
		} catch(n) {
			e(window, "load", i.render)
		}
	}, 10), r.listen(i.onFrameMessage), i
}());
window.PlayBuzz || (window.PlayBuzz = {});
PlayBuzz.Feed = function() {
	var f = !1, e, t = [], r = {}, o = document.location.toString().split("#")[0], l = !1, s = function() {
		var u = o, n = u.split("?")[1];
		if (n == undefined || n.toLowerCase(), n && n.indexOf(!1))
			for (var i = n.split("&"), t = 0; t < i.length; t++) {
				var f = i[t].split("=")[0], r = i[t].split("=")[1];
				if (f == "pbprefix" && r != undefined)
					return r
			}
		return "www"
	}(), n = {
		width : "data-width",
		height : "data-height",
		tags : "data-tags",
		profiles : "data-profiles",
		language : "data-language",
		rating : "data-rating",
		hubId : "data-hubid",
		socialUrl : "data-social-url",
		appData : "data-app-data",
		recommend : "data-recommend",
		game : "data-game",
		key : "data-key",
		params : "data-params",
		social : "data-social",
		useShares : "data-shares",
		useComments : "data-comments",
		analyticsListener : "data-analytics-callback",
		gameInfo : "data-game-info",
		targetPage : "data-target-page",
		specificItem : "data-specific-item",
		singleItemMode : "data-single-item",
		marginTop : "data-margin-top",
		asyncLoading : "data-async",
		shareParam : "data-share-param",
		socialReferrer : "data-social-referrer"
	}, i = {};
	function a(t, r, u) {
		var f = i[u], e = {
			src : t,
			comments : f[n.comments],
			iframeWidth : PlayBuzz.jQuery(r).width(),
			divId : u
		};
		for (var s in n) {
			var o = n[s];
			f[o] && f[o] != undefined && (e[s] = f[o])
		}
		e.social || (e.social = "true");
		try {
			var c = document.location.host;
			c.search("localhost.playbuzz") >= 0 && console.log(e)
		} catch(l) {
		}
		if (f[n.appData] != "" && f[n.appData] != null && f[n.appData] != undefined && (e.appData = f[n.appData]), e.socialReferrer = f[n.socialReferrer] == "true" ? "true" : "false", PlayBuzz.iframeCreator.createFeedFrame(e, r.children[0].children[0], function() {
			PlayBuzz.core.stopSpinner(r)
		}), f[n.height] == "auto") {
			var h = null;
			setInterval(function() {
				var n = document.documentElement.scrollTop || window.pageYOffset;
				if (n != undefined && n != null && n != h) {
					h = n;
					var t = function() {
						try {
							return Math.round(PlayBuzz.jQuery(".pb_feed_iframe").offset().top)
						} catch(n) {
							return 0
						}
					}();
					PlayBuzz.core.sendMessageToIframe({
						event : "scroll",
						scroll : n,
						offsetTop : t
					})
				}
			}, 250)
		}
	}

	function b(t, r) {
		var u = i[r];
		for (var f in n)
		u[n[f]] = t.attributes[n[f]] != undefined ? t.attributes[n[f]].value : u[n[f]];
		if (t.attributes.pbprefix != undefined && ( s = t.attributes.pbprefix.value), isNaN(u[n.width]) && (u[n.width] = 640), PlayBuzz.core.isMobile) {
			var v = PlayBuzz.jQuery(t).width(), y = Math.min(640, window.innerWidth);
			u[n.width] = Math.min(v, y)
		}
		if ((isNaN(u[n.height]) || u[n.height] == "") && (u[n.height] = "auto"), (isNaN(u[n.marginTop]) || u[n.marginTop] == "") && (u[n.marginTop] = 0), u[n.game] != "auto" && u[n.game] != undefined && function() {
			var t = u[n.game].split("?").shift();
			if (t.charAt(t.length - 1) == "/") {
				var r = t.split("");
				r.pop();
				t = r.join("")
			}
			var i = t.split("/");
			if (i.length < 2) {
				u[n.game] = "auto";
				return
			}
			var f = i.pop(), e = i.pop();
			if (f == "" || e == "") {
				u[n.game] = "auto";
				return
			}
			u[n.game] = e + "/" + f
		}(), (u[n.socialUrl] == "auto" || u[n.socialUrl] == undefined || u[n.socialUrl] == null) && (u[n.socialUrl] = o), t.attributes["data-links"] && (u[n.targetPage] = t.attributes["data-links"].value), u[n.targetPage] == "auto") {
			var c = document.location.toString().split("?"), l = c[1], e = c[0];
			if (l)
				for (var a = l.split("&"), h = 0; h < a.length; h++)
					try {
						var f = a[h].toLowerCase();
						if (f.search("game") < 0 && f.search("pb_url") < 0) {
							var p = e.indexOf("?") >= 0 ? "&" : "?";
							e += p + f
						}
					} catch(w) {
					}
			u[n.targetPage] = e
		}
	}

	function k(n) {
		var t = "";
		for (var i in n)t != "" && (t += "&"), t += i + "=" + n[i];
		return t
	}

	function h(n) {
		var t = PlayBuzz.core.browser.browser, i = PlayBuzz.core.browser.version, r = t == "Explorer" && parseInt(i) <= 8, u = r ? -10 : 0;
		try {
			var f = PlayBuzz.jQuery(n).width();
			PlayBuzz.jQuery(".pb_hub_texts", n).each(function(n) {
				var t = Math.floor(f - 168 + u);
				PlayBuzz.jQuery(n).css({
					width : t + "px"
				})
			})
		} catch(e) {
		}
	}

	function d(n, t) {
		var r = n.split("<\/style>"), u = r[0].replace("<style>", ""), f = r[1], i = document.createElement("style");
		i.setAttribute("type", "text/css");
		i.styleSheet ? i.styleSheet.cssText = u : i.appendChild(document.createTextNode(u));
		document.getElementsByTagName("head")[0].appendChild(i);
		PlayBuzz.core.stopSpinner(t);
		tt(t, f);
		var e = window.addEventListener ? "addEventListener" : "attachEvent", o = window.addEventListener ? "resize" : "onresize";
		window[e](o, function() {
			h(t)
		});
		h(t);
		var s = 0, c = setInterval(function() {
			s++ >= 10 && clearInterval(c);
			h(t)
		}, 250);
		g(t)
	}

	function g(n) {
		var u = PlayBuzz.jQuery(".pb_hub_item_container", n), i = {
			parentUrl : document.location.toString(),
			parentHost : document.location.host,
			numItems : u.els.length,
			pageNum : PlayBuzz.core.getURLParam("pb_page") || 0,
			articles : []
		};
		(function() {
			var u = n.attributes;
			for (var o in u) {
				var f = u[o].name;
				if (f && f.indexOf("data-") == 0) {
					for (var e = f.replace("data-", ""), t = e.split("-"), r = 1; r < t.length; r++) {
						var s = t[r].charAt(0).toUpperCase();
						t[r] = s + t[r].slice(1)
					}
					e = t.join("");
					i[e] = u[o].value
				}
			}
		})();
		u.each(function(n) {
			$li = PlayBuzz.jQuery(n);
			i.articles.push({
				id : $li.attr("data-article-id"),
				creator : $li.attr("data-creator"),
				article : $li.attr("data-article-name")
			})
		});
		var r = JSON.stringify(i);
		r = encodeURIComponent(r);
		var f = PlayBuzz.core.getURLParam("pbprefix") || "www", t = document.createElement("iframe");
		t.src = "//" + f + ".playbuzz.com/hubReportIframe?data=" + r;
		t.style.width = "0";
		t.style.height = "0";
		t.style.border = "none";
		t.style.position = "absolute";
		document.body.appendChild(t)
	}

	function nt(t, u) {
		if (t) {
			var o = t.attributes[n.tags] == undefined ? "all" : t.attributes[n.tags].value, h = PlayBuzz.core.getURLParam("pb_url"), c = PlayBuzz.core.getURLParam("game");
			t.style.minHeight = "250px";
			try {
				PlayBuzz.core.spin(t)
			} catch(y) {
			}
			if (i[u]["data-game"] != "auto" && i[u]["data-game"] != undefined || h || c) {
				a(document.location.protocol + "//" + s + ".playbuzz.com/tags/" + o, t, u);
				return
			}
			var f = t.id;
			f || ( f = "pb_hub_" + Math.round(Math.random() * 1e4), t.id = f);
			i[u].divId = u;
			var e = {
				tags : i[u]["data-tags"],
				profiles : i[u]["data-profiles"],
				language : "",
				rating : "",
				hubId : "",
				pageNum : PlayBuzz.core.getURLParam("pb_page") || 0,
				numItems : 10,
				template : "defaultCss",
				imageSize : "auto",
				pbPrefix : PlayBuzz.core.getURLParam("pbprefix") || "www",
				targetPage : v(document.location.toString()),
				hostPage : v(document.location.toString()),
				hostName : document.location.hostname,
				key : "Default",
				width : PlayBuzz.jQuery(t).width(),
				random : "false",
				thumbSize : "default",
				divId : f
			}, l = document.location.protocol + "//" + e.pbPrefix + ".playbuzz.com/widget/GetArticlesHub?" + k(e);
			PlayBuzz.core.ajax(l, r[u], d)
		}
	}

	function v(n) {
		try {
			return n ? n.split("#")[0] : n
		} catch(t) {
		}
		return n
	}

	function tt(n, t) {
		var i = n.children[0], r = i.children[0];
		r.innerHTML = t
	}

	function it(u) {
		var f = PlayBuzz.jQuery(".pb_feed").els, e = PlayBuzz.jQuery("#pb_feed").get(0);
		if (f.length > 0 && ( t = f), e && t.push(e), t.length == 0) {
			l = !0;
			typeof c == "object" && (c.requiresAsyncLoading = !0);
			return
		}
		(function() {
			for (var f = 0; f < t.length; f++) {
				try {
					var k = t[f].attributes["data-async"].value == "true";
					if (k && u)
						return
				} catch(d) {
				}
				PlayBuzz.jQuery(t[f]).addClass("pb_identifier_" + f);
				var c = document.createElement("div");
				c.className = "pb_top_content_container";
				c.style.paddingBottom = "30px";
				t[f].innerHTML = "";
				t[f].appendChild(c);
				c.innerHTML = "<div><\/div>";
				t[f].contentInner = c;
				t[f].style.position == "" && (t[f].style.position = "relative");
				var h = "div" + f;
				r[h] = t[f];
				i[h] = {};
				b(t[f], "div" + f);
				ut(t[f]);
				var l = i[h][n.game], p = l != undefined && l != null && l != "auto" && l != "", e = o.split("?")[1];
				if ((e == undefined || e.search("pb_url") == -1 && e.search("game") == -1) && !p) {
					nt(t[f], h);
					continue
				}
				var w = p ? i[h][n.game] : "";
				try {
					e = e.split("&");
					for (var v = 0; v < e.length; v++) {
						var y = e[v].split("=");
						(y[0] == "pb_url" || y[0] == "game") && ( w = y[1])
					}
				} catch(d) {
				}
				t[f].style.minHeight = "250px";
				try {
					PlayBuzz.core.spin(t[f])
				} catch(d) {
				}
				a(document.location.protocol + "//" + s + ".playbuzz.com/" + w, t[f], h)
			}
		})()
	}

	function y() {
		var t = 50, i = Math.abs(window.scrollY - e), n = Math.min(t, i);
		window.scrollY > e && (n *= -1);
		scrollBy(0, n);
		Math.abs(n) == t ? setTimeout(y, 15) : f = !1
	}

	function p(n) {
		if (!window.scrollY)
			try {
				window.scrollTo(0, n);
				return
			} catch(t) {
			}
		(n && ( e = n), f) || ( f = !0, y())
	}

	function rt(n, t, i) {
		var o = r[i], f = document.documentElement.scrollTop || window.pageYOffset, s = o.getElementsByTagName("iframe")[0], e = n == "iframe_top" ? 0 : n, h = function() {
			try {
				return PlayBuzz.jQuery(s).offset().top
			} catch(n) {
				return 0
			}
		}(), u = h + e;
		if (document.location.toString().toLowerCase().search("'isfb':'true'") >= 0)
			FB.Canvas.scrollTo(0, u + 40);
		else if (u < f)
			if (t) {
				var c = n == "iframe_top" ? u : n;
				window.scrollTo(0, c)
			} else
				p(u);
		else
			u > f && ( t ? window.scrollTo(0, e) : p(u))
	}
	PlayBuzz.core.listen("onMessage", function(t) {
		var u = JSON.parse(t), f = u.id;
		if (f && r[f]) {
			if (u.name == "analyticsEvent") {
				try {
					var e = i[f][n.analyticsListener];
					e != "null" && e != null && eval(e)(u.event);
					typeof PlayBuzzCallback == "function" && PlayBuzzCallback(u.event)
				} catch(t) {
				}
				return
			}
			if (u.resize_height) {
				window.FB && (r[f].style.height = "98%", FB.Canvas.setSize({
					height : parseInt(u.resize_height) + 80
				}));
				r[f].getElementsByTagName("iframe")[0].style.height = u.resize_height + "px";
				try {
					r[f].getElementsByTagName("iframe")[0].style.setProperty("max-height", u.resize_height + "px", "important")
				} catch(t) {
					r[f].getElementsByTagName("iframe")[0].style.maxHeight = u.resize_height + "px"
				}
			}
			if (u.scroll_y != undefined && u.scroll_y != null)
				try {
					var o = u.noAnimation == !0;
					rt(u.scroll_y, o, f)
				} catch(t) {
				}
		}
	});
	function u(n, t) {
		var i = document.createElement(n);
		for (var r in t)
		i.setAttribute(r, t[r]);
		return i
	}

	function ut(n) {
		var r = u("div", {
			"class" : "pb_iframe_bottom"
		}), f = u("div", {
			"class" : "powered_by_pb"
		}), i = u("a", {
			href : document.location.protocol + "//www.playbuzz.com",
			target : "_blank"
		}), e = u("span", {
			"class" : "powered_by_pb_text"
		}), s = u("img", {
			src : document.location.protocol + "//cdn.playbuzz.com/content/images/logo_micro_partners.png",
			border : "0",
			width : "61",
			height : "30",
			alt : "playbuzz",
			"class" : "pb_feed_small_logo"
		});
		e.innerHTML = "Powered by";
		n.appendChild(r);
		r.appendChild(f);
		f.appendChild(i);
		i.appendChild(e);
		i.appendChild(s);
		var o = ".pb_iframe_bottom .powered_by_pb { padding-top: 10px; float: left; }.pb_iframe_bottom .powered_by_pb a { text-decoration: none; border: 0; outline: none; }.pb_iframe_bottom .powered_by_pb .powered_by_pb_text { padding-right: 5px; color: #999; line-height: 30px; float: left; font-family: helvetica,arial,clean,sans-serif;font-size: 10px; font-style: italic; }.pb_feed_small_logo { width: 61px !important; height: 30px !important; margin-top:0px !important; }.pb_iframe_bottom .powered_by_pb img { float: left; border: 0; outline: none; min-width: 61px !important; max-width: 61px !important; }.pb_iframe_bottom { overflow:hidden; position: absolute; bottom: 0; }", t = document.createElement("style");
		document.getElementsByTagName("head")[0].appendChild(t);
		t.setAttribute("type", "text/css");
		t.styleSheet ? t.styleSheet.cssText = o : t.innerHTML = o
	}

	var c = {
		renderFeed : function(n) {
			it(n)
		},
		getFeedContainer : function(n) {
			return r[n]
		},
		requiresAsyncLoading : l
	};
	return c
}();
window.PlayBuzz || (window.PlayBuzz = {});
PlayBuzz.iframeCreator = function() {
	var n = {};
	function t(n, t) {
		var i = document.createElement(n);
		for (var r in t)
		i.setAttribute(r, t[r]);
		return i
	}
	return n.createFeedFrame = function(n, i, r) {
		n.parentHost = document.location.host;
		n.parentUrl = encodeURIComponent(document.location.toString());
		var c = document.referrer && document.referrer.toString().split("?")[0];
		n.referral = encodeURIComponent(c);
		var o = n.src + "?feed=true", e = n.width, u = n.height, s = "";
		e = e == "auto" ? "100%" : e + "px";
		u == "auto" ? ( u = "100%", s = "no") : u = u + "px";
		var a = parseInt(n.width), v = parseInt(n.height);
		isNaN(parseInt(n.width)) || (n.width = Math.round(parseInt(n.width)));
		isNaN(parseInt(n.height)) || (n.height = Math.round(parseInt(n.height)));
		for (var h in n)
		o += "&" + h + "=" + n[h];
		var l = {
			src : o,
			name : "pb_feed_iframe",
			"class" : "pb_feed_iframe",
			frameBorder : "0",
			scrolling : s,
			height : u
		}, f = t("iframe", l);
		i.appendChild(f);
		PlayBuzz.jQuery(f).css({
			width : "100%",
			maxWidth : "640px",
			height : u,
			border : "none",
			margin : "auto"
		});
		PlayBuzz.core.browser.browser == "Explorer" && PlayBuzz.core.browser.version <= 9 || PlayBuzz.jQuery(f).css("display", "table");
		try {
			if (n.key && n.key.toLowerCase() == "mlb" && document.location.hostname.toLowerCase().search("mlb.com") >= 0)
				return
		} catch(y) {
		}
		f.attachEvent ? f.attachEvent("onload", function() {
			r && r()
		}) : f.onload = function() {
			r && r()
		}
	}, n.createWidgetFrame = function(n, i) {
		var r = t("iframe", {
			src : n
		});
		r.onload = function() {
			PlayBuzz.core.dispatchEvent("widgetReady", i)
		};
		PlayBuzz.jQuery(r).css({
			width : "100%",
			border : "none",
			scrolling : "no"
		});
		i.appendChild(r)
	}, n
}()
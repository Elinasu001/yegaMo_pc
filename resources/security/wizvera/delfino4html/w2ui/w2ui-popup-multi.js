
/************************************************************************
* w2ui-popup을 멀티로 쓸수 있도록 최소한의 수정을 가함
************************************************************************/

var w2popup = {};

(function (GLOBAL) {
    var $ = GLOBAL.$;
    // ====================================================
    // -- Registers as a jQuery plugin

    $.fn.w2popup = function(method, options) {
        if (typeof method === 'undefined') {
            options = {};
            method  = 'open';
        }
        if ($.isPlainObject(method)) {
            options = method;
            method  = 'open';
        }
        method = method.toLowerCase();
        if (method === 'load' && typeof options === 'string') {
            options = $.extend({ url: options }, arguments.length > 2 ? arguments[2] : {});
        }
        if (method === 'open' && options.url != null) method = 'load';
        options = options || {};
        // load options from markup
        var dlgOptions = {};
        if ($(this).length > 0) {
            if ($(this).find('div[rel=title], div[rel=body], div[rel=buttons]').length > 0) {
                if ($(this).find('div[rel=title]').length > 0) {
                    dlgOptions['title'] = $(this).find('div[rel=title]').html();
                }
                if ($(this).find('div[rel=body]').length > 0) {
                    dlgOptions['body']  = $(this).find('div[rel=body]').html();
                    dlgOptions['style'] = $(this).find('div[rel=body]')[0].style.cssText;
                }
                if ($(this).find('div[rel=buttons]').length > 0) {
                    dlgOptions['buttons'] = $(this).find('div[rel=buttons]').html();
                }
            } else {
                dlgOptions['title'] = '&nbsp;';
                dlgOptions['body']  = $(this).html();
            }
            if (parseInt($(this).css('width')) != 0)  dlgOptions['width']  = parseInt($(this).css('width'));
            if (parseInt($(this).css('height')) != 0) dlgOptions['height'] = parseInt($(this).css('height'));
        }
        // show popup
        return w2popup[method]($.extend({}, dlgOptions, options));
    };

    // ====================================================
    // -- Implementation of core functionality (SINGELTON)

    var id= 0;
    w2popup.open = function (options) {
        var _id = "_" + id;
        var w2popup = {
            _id : _id,
            defaults: {
                title     : '',
                body      : '',
                buttons   : '',
                style     : '',
                color     : '#000',
                opacity   : 0.01,
                speed     : 0.3,
                modal     : false,
                maximized : false,
                keyboard  : false,     // will close popup on esc if not modal
                width     : 500,
                height    : 300,
                showClose : false,
                showMax   : false,
                transition: null
            },
            status    : 'closed',     // string that describes current status
            handlers  : [],
            onOpen    : null,
            onClose   : null,
            onMax     : null,
            onMin     : null,
            onToggle  : null,
            onKeydown : null,

            open: function (options) {
                var obj = this;
                if (w2popup.status == 'closing') {
                    setTimeout(function () { obj.open.call(obj, options); }, 100);
                    return;
                }
                // get old options and merge them
                var old_options = $('#w2ui-popup'+_id+'').data('options');
                var options = $.extend({}, this.defaults, old_options, { title: '', body : '', buttons: '' }, options, { maximized: false });
                // need timer because popup might not be open
                setTimeout(function () { $('#w2ui-popup'+_id+'').data('options', options); }, 100);
                // if new - reset event handlers
                if ($('#w2ui-popup'+_id+'').length == 0) {
                    w2popup.handlers  = [];
                    w2popup.onMax     = null;
                    w2popup.onMin     = null;
                    w2popup.onToggle  = null;
                    w2popup.onOpen    = null;
                    w2popup.onClose   = null;
                    w2popup.onKeydown = null;
                }
                if (options.onOpen)    w2popup.onOpen    = options.onOpen;
                if (options.onClose)   w2popup.onClose   = options.onClose;
                if (options.onMax)     w2popup.onMax     = options.onMax;
                if (options.onMin)     w2popup.onMin     = options.onMin;
                if (options.onToggle)  w2popup.onToggle  = options.onToggle;
                if (options.onKeydown) w2popup.onKeydown = options.onKeydown;

                if (options.title != '') {
                    options.height += 32;
                }

                if (window.innerHeight == undefined) {
                    var width  = document.documentElement.offsetWidth;
                    var height = document.documentElement.offsetHeight;
                    if (w2utils.engine === 'IE7') { width += 21; height += 4; }
                } else {
                    var width  = window.innerWidth;
                    var height = window.innerHeight;
                }
                //if (parseInt(width)  - 10 < parseInt(options.width))  options.width  = parseInt(width)  - 10;
                //if (parseInt(height) - 10 < parseInt(options.height)) {
                    //options.height = parseInt(height) - 10;
                    //options.width += 15; // for vertical scrollbar space
                //}

                var top ;
                var left;

                if (options.top !== undefined) {
                    top = options.top;
                } else {
                    top  = Math.max(parseInt(((parseInt(height) - parseInt(options.height)) / 2) * 0.6), 10);
                }

                if (options.left !== undefined) {
                    left = options.left;
                } else {
                    left = Math.max(parseInt((parseInt(width) - parseInt(options.width)) / 2), 10);
                }

                // check if message is already displayed
                //if ($('#w2ui-popup').length == 0)
                if (true) {
                    // trigger event
                    var eventData = this.trigger({ phase: 'before', type: 'open', target: 'popup', options: options, present: false });
                    if (eventData.isCancelled === true) return;
                    w2popup.status = 'opening';
                    // output message
                    w2popup.lockScreen(options);
                    var btn = '';
                    if (options.showClose) {
                        btn += '<div class="w2ui-msg-button w2ui-msg-close" onmousedown="event.stopPropagation()" onclick="//w2popup'+_id+'.close()">Close</div>';
                    }
                    if (options.showMax) {
                        btn += '<div class="w2ui-msg-button w2ui-msg-max" onmousedown="event.stopPropagation()" onclick="w2popup.toggle()">Max</div>';
                    }
                    var msg='<div id="w2ui-popup'+_id+'" class="w2ui-popup" style="opacity: 0; left: '+ left +'px; top: '+ top +'px;'+
                            '     width: ' + parseInt(options.width) + 'px; height: ' + parseInt(options.height) + 'px; '+
                            '    -webkit-transform: scale(0.8); -moz-transform: scale(0.8); -ms-transform: scale(0.8); -o-transform: scale(0.8); "'+
                            '    role="dialog"'+
                            '>'+
                            '   <div class="w2ui-msg-title" style="'+ (options.title == '' ? 'opacity:0; /* display: none */' : '') +'">' + btn + options.title + '</div>'+
                            '   <div class="w2ui-box1" style="'+ (options.title == '' ? 'top: 0px !important;' : '') +
                                        (options.buttons == '' ? 'bottom: 0px !important;' : '') + '">'+
                            '       <div class="w2ui-msg-body' + (!options.title != '' ? ' w2ui-msg-no-title' : '') +
                                        (!options.buttons != '' ? ' w2ui-msg-no-buttons' : '') + '" style="' + options.style + '">' + options.body + '</div>'+
                            '   </div>'+
                            '   <div class="w2ui-box2" style="' + (options.title == '' ? 'top: 0px !important;' : '') +
                                        (options.buttons == '' ? 'bottom: 0px !important;' : '') + '">'+
                            '       <div class="w2ui-msg-body' + (!options.title != '' ? ' w2ui-msg-no-title' : '') +
                                        (!options.buttons != '' ? ' w2ui-msg-no-buttons' : '') + '" style="' + options.style + '"></div>'+
                            '       </div>'+
                            '   <div class="w2ui-msg-buttons" style="'+ (options.buttons == '' ? 'display: none' : '') +'">' + options.buttons + '</div>'+
                            '</div>';
                    $('body').append(msg);
                    // allow element to render
                    setTimeout(function () {
                        $('#w2ui-popup'+_id+' .w2ui-box2').hide();
                        $('#w2ui-popup'+_id+'').css({
                            '-webkit-transition': options.speed + 's opacity, ' + options.speed + 's -webkit-transform',
                            '-webkit-transform': 'scale(1)',
                            '-moz-transition': options.speed + 's opacity, ' + options.speed + 's -moz-transform',
                            '-moz-transform': 'scale(1)',
                            '-ms-transition': options.speed + 's opacity, ' + options.speed + 's -ms-transform',
                            '-ms-transform': 'scale(1)',
                            '-o-transition': options.speed + 's opacity, ' + options.speed + 's -o-transform',
                            '-o-transform': 'scale(1)',
                            'opacity': '1'
                        });
                    }, 1);
                    // clean transform
                    setTimeout(function () {
                        $('#w2ui-popup').css({
                            '-webkit-transform': '',
                            '-moz-transform': '',
                            '-ms-transform': '',
                            '-o-transform': ''
                        });
                        // event after
                        w2popup.status = 'open';
                        setTimeout(function () {
                            obj.trigger($.extend(eventData, { phase: 'after' }));
                        }, 100);
                    }, options.speed * 1000);
                } else {
                    // trigger event
                    var eventData = this.trigger({ phase: 'before', type: 'open', target: 'popup', options: options, present: true });
                    if (eventData.isCancelled === true) return;
                    // check if size changed
                    w2popup.status = 'opening';
                    if (typeof old_options == 'undefined' || old_options['width'] != options['width'] || old_options['height'] != options['height']) {
                        w2popup.resize(options.width, options.height);
                    }
                    if (typeof old_options != 'undefined') {
                        options.prevSize  = options.width + ':' + options.height;
                        options.maximized = old_options.maximized;
                    }
                    // show new items
                    var body = $('#w2ui-popup'+_id+' .w2ui-box2 > .w2ui-msg-body').html(options.body);
                    if (body.length > 0) body[0].style.cssText = options.style;
                    if (options.buttons != '') {
                        $('#w2ui-popup'+_id+' .w2ui-msg-buttons').show().html(options.buttons);
                        $('#w2ui-popup'+_id+' .w2ui-msg-body').removeClass('w2ui-msg-no-buttons');
                        $('#w2ui-popup'+_id+' .w2ui-box1, #w2ui-popup'+_id+' .w2ui-box2').css('bottom', '');
                    } else {
                        $('#w2ui-popup'+_id+' .w2ui-msg-buttons').hide().html('');
                        $('#w2ui-popup'+_id+' .w2ui-msg-body').addClass('w2ui-msg-no-buttons');
                        $('#w2ui-popup'+_id+' .w2ui-box1, #w2ui-popup'+_id+' .w2ui-box2').css('bottom', '0px');
                    }
                    if (options.title != '') {
                        $('#w2ui-popup'+_id+' .w2ui-msg-title').show().html(
                              (options.showClose ? '<div class="w2ui-msg-button w2ui-msg-close" onmousedown="event.stopPropagation()" onclick="w2popup.close()">Close</div>' : '') +
                              (options.showMax ? '<div class="w2ui-msg-button w2ui-msg-max" onmousedown="event.stopPropagation()" onclick="w2popup.toggle()">Max</div>' : '') +
                              options.title);
                        $('#w2ui-popup'+_id+' .w2ui-msg-body').removeClass('w2ui-msg-no-title');
                        $('#w2ui-popup'+_id+' .w2ui-box1, #w2ui-popup'+_id+' .w2ui-box2').css('top', '');
                    } else {
                        $('#w2ui-popup'+_id+' .w2ui-msg-title').hide().html('');
                        $('#w2ui-popup'+_id+' .w2ui-msg-body').addClass('w2ui-msg-no-title');
                        $('#w2ui-popup'+_id+' .w2ui-box1, #w2ui-popup'+_id+' .w2ui-box2').css('top', '0px');
                    }
                    // transition
                    var div_old = $('#w2ui-popup'+_id+' .w2ui-box1')[0];
                    var div_new = $('#w2ui-popup'+_id+' .w2ui-box2')[0];
                    w2utils.transition(div_old, div_new, options.transition);
                    div_new.className = 'w2ui-box1';
                    div_old.className = 'w2ui-box2';
                    $(div_new).addClass('w2ui-current-box');
                    // remove max state
                    $('#w2ui-popup'+_id+'').data('prev-size', null);
                    // call event onChange
                    setTimeout(function () {
                        w2popup.status = 'open';
                        obj.trigger($.extend(eventData, { phase: 'after' }));
                    }, 100);
                }
                // save new options
                options._last_w2ui_name = w2utils.keyboard.active();
                w2utils.keyboard.active(null);
                // keyboard events
                if (options.keyboard) $(document).on('keydown', this.keydown);

                // initialize move
                var tmp = {
                    resizing : false,
                    mvMove   : mvMove,
                    mvStop   : mvStop
                };
                if (!options.embed) $('#w2ui-popup'+_id+' .w2ui-msg-title').on('mousedown', function (event) { mvStart(event); })

                // handlers
                function mvStart(evnt) {
                    if (!evnt) evnt = window.event;
                    if (!window.addEventListener) { window.document.attachEvent('onselectstart', function() { return false; } ); }
                    w2popup.status = 'moving';
                    tmp.resizing = true;
                    tmp.x = evnt.screenX;
                    tmp.y = evnt.screenY;
                    tmp.pos_x = $('#w2ui-popup'+_id+'').position().left;
                    tmp.pos_y = $('#w2ui-popup'+_id+'').position().top;
                    w2popup.lock({ opacity: 0 });
                    $(document).on('mousemove', tmp.mvMove);
                    $(document).on('mouseup', tmp.mvStop);
                    if (evnt.stopPropagation) evnt.stopPropagation(); else evnt.cancelBubble = true;
                    if (evnt.preventDefault) evnt.preventDefault(); else return false;
                }

                function mvMove(evnt) {
                    if (tmp.resizing != true) return;
                    if (!evnt) evnt = window.event;
                    tmp.div_x = evnt.screenX - tmp.x;
                    tmp.div_y = evnt.screenY - tmp.y;
                    $('#w2ui-popup'+_id+'').css({
                        '-webkit-transition': 'none',
                        '-webkit-transform': 'translate3d('+ tmp.div_x +'px, '+ tmp.div_y +'px, 0px)',
                        '-moz-transition': 'none',
                        '-moz-transform': 'translate('+ tmp.div_x +'px, '+ tmp.div_y +'px)',
                        '-ms-transition': 'none',
                        '-ms-transform': 'translate('+ tmp.div_x +'px, '+ tmp.div_y +'px)',
                        '-o-transition': 'none',
                        '-o-transform': 'translate('+ tmp.div_x +'px, '+ tmp.div_y +'px)'
                    });
                }

                function mvStop(evnt) {
                    if (tmp.resizing != true) return;
                    if (!evnt) evnt = window.event;
                    w2popup.status = 'open';
                    tmp.div_x = (evnt.screenX - tmp.x);
                    tmp.div_y = (evnt.screenY - tmp.y);
                    $('#w2ui-popup'+_id+'').css({
                        'left': (tmp.pos_x + tmp.div_x) + 'px',
                        'top':    (tmp.pos_y  + tmp.div_y) + 'px',
                        '-webkit-transition': 'none',
                        '-webkit-transform': 'translate3d(0px, 0px, 0px)',
                        '-moz-transition': 'none',
                        '-moz-transform': 'translate(0px, 0px)',
                        '-ms-transition': 'none',
                        '-ms-transform': 'translate(0px, 0px)',
                        '-o-transition': 'none',
                        '-o-transform': 'translate(0px, 0px)'
                    });
                    tmp.resizing = false;
                    $(document).off('mousemove', tmp.mvMove);
                    $(document).off('mouseup', tmp.mvStop);
                    w2popup.unlock();
                }
                return this;
            },

            keydown: function (event) {
                var options = $('#w2ui-popup'+_id+'').data('options');
                if (!options.keyboard) return;
                // trigger event
                var eventData = w2popup.trigger({ phase: 'before', type: 'keydown', target: 'popup', options: options, originalEvent: event });
                if (eventData.isCancelled === true) return;
                // default behavior
                switch (event.keyCode) {
                    case 27:
                        event.preventDefault();
                        if ($('#w2ui-popup'+_id+' .w2ui-popup-message').length > 0) w2popup.message(); else w2popup.close();
                        break;
                }
                // event after
                w2popup.trigger($.extend(eventData, { phase: 'after'}));
            },

            close: function (options) {
                var obj = this;
                var options = $.extend({}, $('#w2ui-popup'+_id+'').data('options'), options);
                if ($('#w2ui-popup'+_id+'').length == 0) return;
                // trigger event
                var eventData = this.trigger({ phase: 'before', type: 'close', target: 'popup', options: options });
                if (eventData.isCancelled === true) return;
                // default behavior
                w2popup.status = 'closing';
                $('#w2ui-popup'+_id+'').css({
                    '-webkit-transition': options.speed + 's opacity, ' + options.speed + 's -webkit-transform',
                    '-webkit-transform': 'scale(0.9)',
                    '-moz-transition': options.speed + 's opacity, ' + options.speed + 's -moz-transform',
                    '-moz-transform': 'scale(0.9)',
                    '-ms-transition': options.speed + 's opacity, ' + options.speed + 's -ms-transform',
                    '-ms-transform': 'scale(0.9)',
                    '-o-transition': options.speed + 's opacity, ' + options.speed + 's -o-transform',
                    '-o-transform': 'scale(0.9)',
                    'opacity': '0'
                });
                w2popup.unlockScreen(options);
                //setTimeout(function () {
                    $('#w2ui-popup'+_id+'').remove();
                    w2popup.status = 'closed';
                    // event after
                    obj.trigger($.extend(eventData, { phase: 'after'}));
                //}, options.speed * 1000);
                // restore active
                w2utils.keyboard.active(options._last_w2ui_name);
                // remove keyboard events
                if (options.keyboard) $(document).off('keydown', this.keydown);
            },

            toggle: function () {
                var obj     = this;
                var options = $('#w2ui-popup'+_id+'').data('options');
                // trigger event
                var eventData = this.trigger({ phase: 'before', type: 'toggle', target: 'popup', options: options });
                if (eventData.isCancelled === true) return;
                // defatul action
                if (options.maximized === true) w2popup.min(); else w2popup.max();
                // event after
                setTimeout(function () {
                    obj.trigger($.extend(eventData, { phase: 'after'}));
                }, (options.speed * 1000) + 50);
            },

            max: function () {
                var obj = this;
                var options = $('#w2ui-popup'+_id+'').data('options');
                if (options.maximized === true) return;
                // trigger event
                var eventData = this.trigger({ phase: 'before', type: 'max', target: 'popup', options: options });
                if (eventData.isCancelled === true) return;
                // default behavior
                w2popup.status   = 'resizing';
                options.prevSize = $('#w2ui-popup'+_id+'').css('width') + ':' + $('#w2ui-popup'+_id+'').css('height');
                // do resize
                w2popup.resize(10000, 10000, function () {
                    w2popup.status    = 'open';
                    options.maximized = true;
                    obj.trigger($.extend(eventData, { phase: 'after'}));
                });
            },

            min: function () {
                var obj = this;
                var options = $('#w2ui-popup'+_id+'').data('options');
                if (options.maximized !== true) return;
                var size = options.prevSize.split(':');
                // trigger event
                var eventData = this.trigger({ phase: 'before', type: 'min', target: 'popup', options: options });
                if (eventData.isCancelled === true) return;
                // default behavior
                w2popup.status = 'resizing';
                // do resize
                w2popup.resize(size[0], size[1], function () {
                    w2popup.status = 'open';
                    options.maximized = false;
                    options.prevSize  = null;
                    obj.trigger($.extend(eventData, { phase: 'after'}));
                });
            },

            get: function () {
                return $('#w2ui-popup'+_id+'').data('options');
            },

            set: function (options) {
                w2popup.open(options);
            },

            clear: function() {
                $('#w2ui-popup'+_id+' .w2ui-msg-title').html('');
                $('#w2ui-popup'+_id+' .w2ui-msg-body').html('');
                $('#w2ui-popup'+_id+' .w2ui-msg-buttons').html('');
            },

            reset: function () {
                w2popup.open(w2popup.defaults);
            },

            load: function (options) {
                w2popup.status = 'loading';
                if (String(options.url) == 'undefined') {
                    console.log('ERROR: The url parameter is empty.');
                    return;
                }
                var tmp = String(options.url).split('#');
                var url = tmp[0];
                var selector = tmp[1];
                if (String(options) == 'undefined') options = {};
                // load url
                var html = $('#w2ui-popup'+_id+'').data(url);
                if (typeof html != 'undefined' && html != null) {
                    popup(html, selector);
                } else {
                    $.get(url, function (data, status, obj) { // should always be $.get as it is template
                        popup(obj.responseText, selector);
                        $('#w2ui-popup'+_id+'').data(url, obj.responseText); // remember for possible future purposes
                    });
                }
                function popup(html, selector) {
                    delete options.url;
                    $('body').append('<div id="w2ui-tmp" style="display: none">' + html + '</div>');
                    if (typeof selector != 'undefined' && $('#w2ui-tmp #'+selector).length > 0) {
                        $('#w2ui-tmp #' + selector).w2popup(options);
                    } else {
                        $('#w2ui-tmp > div').w2popup(options);
                    }
                    // link styles
                    if ($('#w2ui-tmp > style').length > 0) {
                        var style = $('<div>').append($('#w2ui-tmp > style').clone()).html();
                        if ($('#w2ui-popup'+_id+' #div-style').length == 0) {
                            $('#w2ui-popup'+_id+'').append('<div id="div-style" style="position: absolute; left: -100; width: 1px"></div>');
                        }
                        $('#w2ui-popup #div-style').html(style);
                    }
                    $('#w2ui-tmp').remove();
                }
            },

            message: function (options) {
                $().w2tag(); // hide all tags
                if (!options) options = { width: 200, height: 100 };
                if (parseInt(options.width) < 10)  options.width  = 10;
                if (parseInt(options.height) < 10) options.height = 10;
                if (typeof options.hideOnClick == 'undefined') options.hideOnClick = false;
                var poptions = $('#w2ui-popup'+_id+'').data('options') || {};
                if (typeof options.width == 'undefined' || options.width > poptions.width - 10) options.width = poptions.width - 10;
                if (typeof options.height == 'undefined' || options.height > poptions.height - 40) options.height = poptions.height - 40; // title is 30px or so

                var head     = $('#w2ui-popup'+_id+' .w2ui-msg-title');
                var pwidth   = parseInt($('#w2ui-popup'+_id+'').width());
                var msgCount = $('#w2ui-popup'+_id+' .w2ui-popup-message').length;
                // remove message
                if ($.trim(options.html) == '') {
                    $('#w2ui-popup'+_id+' #w2ui-message'+ (msgCount-1)).css('z-Index', 250);
                    var options = $('#w2ui-popup'+_id+' #w2ui-message'+ (msgCount-1)).data('options') || {};
                    $('#w2ui-popup'+_id+' #w2ui-message'+ (msgCount-1)).remove();
                    if (typeof options.onClose == 'function') options.onClose();
                    if (msgCount == 1) {
                        w2popup.unlock();
                    } else {
                        $('#w2ui-popup'+_id+' #w2ui-message'+ (msgCount-2)).show();
                    }
                } else {
                    // hide previous messages
                    $('#w2ui-popup'+_id+' .w2ui-popup-message').hide();
                    // add message
                    $('#w2ui-popup'+_id+' .w2ui-box1')
                        .before('<div id="w2ui-message' + msgCount + '" class="w2ui-popup-message" style="display: none; ' +
                                    (head.length == 0 ? 'top: 0px;' : 'top: ' + w2utils.getSize(head, 'height') + 'px;') +
                                    (typeof options.width  != 'undefined' ? 'width: ' + options.width + 'px; left: ' + ((pwidth - options.width) / 2) + 'px;' : 'left: 10px; right: 10px;') +
                                    (typeof options.height != 'undefined' ? 'height: ' + options.height + 'px;' : 'bottom: 6px;') +
                                    '-webkit-transition: .3s; -moz-transition: .3s; -ms-transition: .3s; -o-transition: .3s;"' +
                                    (options.hideOnClick === true ? 'onclick="w2popup.message();"' : '') + '>' +
                                '</div>');
                    $('#w2ui-popup'+_id+' #w2ui-message'+ msgCount).data('options', options);
                    var display = $('#w2ui-popup'+_id+' #w2ui-message'+ msgCount).css('display');
                    $('#w2ui-popup'+_id+' #w2ui-message'+ msgCount).css({
                        '-webkit-transform': (display == 'none' ? 'translateY(-' + options.height + 'px)' : 'translateY(0px)'),
                        '-moz-transform': (display == 'none' ? 'translateY(-' + options.height + 'px)' : 'translateY(0px)'),
                        '-ms-transform': (display == 'none' ? 'translateY(-' + options.height + 'px)' : 'translateY(0px)'),
                        '-o-transform': (display == 'none' ? 'translateY(-' + options.height + 'px)' : 'translateY(0px)')
                    });
                    if (display == 'none') {
                        $('#w2ui-popup'+_id+' #w2ui-message'+ msgCount).show().html(options.html);
                        // timer needs to animation
                        setTimeout(function () {
                            $('#w2ui-popup'+_id+' #w2ui-message'+ msgCount).css({
                                '-webkit-transform': (display == 'none' ? 'translateY(0px)' : 'translateY(-' + options.height + 'px)'),
                                '-moz-transform': (display == 'none' ? 'translateY(0px)' : 'translateY(-' + options.height + 'px)'),
                                '-ms-transform': (display == 'none' ? 'translateY(0px)' : 'translateY(-' + options.height + 'px)'),
                                '-o-transform': (display == 'none' ? 'translateY(0px)' : 'translateY(-' + options.height + 'px)')
                            });
                        }, 1);
                        // timer for lock
                        setTimeout(function() {
                            $('#w2ui-popup'+_id+' #w2ui-message'+ msgCount).css({
                                '-webkit-transition': '0s',    '-moz-transition': '0s', '-ms-transition': '0s', '-o-transition': '0s',
                                'z-Index': 1500
                            }); // has to be on top of lock
                            if (msgCount == 0) w2popup.lock();
                            if (typeof options.onOpen == 'function') options.onOpen();
                        }, 300);
                    }
                }
            },

            lock: function (msg, showSpinner) {
                var args = Array.prototype.slice.call(arguments, 0);
                args.unshift($('#w2ui-popup'+_id+''));
                w2utils.lock.apply(window, args);
            },

            unlock: function () {
                w2utils.unlock($('#w2ui-popup'+_id+''));
            },

            // --- INTERNAL FUNCTIONS

            lockScreen: function (options) {
                if ($('#w2ui-lock').length > 0) return false;
                if (typeof options == 'undefined') options = $('#w2ui-popup'+_id+'').data('options');
                if (typeof options == 'undefined') options = {};
                options = $.extend({}, w2popup.defaults, options);
                if (options.embed) {
                    options.opacity = 0;
                    w2uiAlertLock.embed = true;
                }
                // show element
                $('body').append('<div id="w2ui-lock" ' +
                    '    onmousewheel="if (event.stopPropagation) event.stopPropagation(); else event.cancelBubble = true; if (event.preventDefault) event.preventDefault(); else return false;"'+
                    '    style="position: ' + (w2utils.engine == 'IE5' ? 'absolute' : 'fixed') + '; z-Index: 1200; left: 0px; top: 0px; ' +
                    '           padding: 0px; margin: 0px; background-color: ' + options.color + '; width: 100%; height: 100%; opacity: 0;"></div>');

                // show transparent lock
                $('body').append('<div id="w2ui-lock-transparent" ' +
                    '    style="position: ' + (w2utils.engine == 'IE5' ? 'absolute' : 'fixed') + '; z-Index: 1400; left: 0px; top: 0px; ' +
                    '           padding: 0px; margin: 0px; background-color: ' + options.color + '; width: 100%; height: 100%; opacity: 0;"></div>');
                // lock screen
                setTimeout(function () {
                    $('#w2ui-lock').css({
                        '-webkit-transition': options.speed + 's opacity',
                        '-moz-transition': options.speed + 's opacity',
                        '-ms-transition': options.speed + 's opacity',
                        '-o-transition': options.speed + 's opacity',
                        'opacity': options.opacity
                    });
                }, 1);
                // add events
                if (options.modal == true) {
                    $('#w2ui-lock-transparent').on('mousedown', function () {
                        if (options.opacity === 0) return;
                        $('#w2ui-lock').css({
                            '-webkit-transition': '.1s',
                            '-moz-transition': '.1s',
                            '-ms-transition': '.1s',
                            '-o-transition': '.1s',
                            'opacity': '0.2'
                        });
                        // if (window.getSelection) window.getSelection().removeAllRanges();
                    });
                    $('#w2ui-lock-transparent').on('mouseup', function () {
                        setTimeout(function () {
                            $('#w2ui-lock').css({
                                '-webkit-transition': '.1s',
                                '-moz-transition': '.1s',
                                '-ms-transition': '.1s',
                                '-o-transition': '.1s',
                                'opacity': options.opacity
                            });
                        }, 100);
                        // if (window.getSelection) window.getSelection().removeAllRanges();
                    });
                } else {
                    $('#w2ui-lock').on('mouseup', function () { w2popup.close(); });
                }
                return true;
            },

            unlockScreen: function (options) {
                if ($('.w2ui-popup').length > 0) return false;
                if ($('#w2ui-lock').length == 0) return false;
                if (typeof options == 'undefined') options = $('#w2ui-popup'+_id+'').data('options');
                if (typeof options == 'undefined') options = {};
                options = $.extend({}, w2popup.defaults, options);
                $('#w2ui-lock').css({
                    '-webkit-transition': options.speed + 's opacity',
                    '-moz-transition': options.speed + 's opacity',
                    '-ms-transition': options.speed + 's opacity',
                    '-o-transition': options.speed + 's opacity',
                    'opacity': 0
                });
                setTimeout(function () {
                    $('#w2ui-lock').remove();
                }, options.speed * 1000);
                return true;
            },

            resize: function (width, height, callBack) {
                var options = $('#w2ui-popup'+_id+'').data('options');
                // calculate new position
                if (parseInt($(window).width())  - 10 < parseInt(width))  width  = parseInt($(window).width())  - 10;
                if (parseInt($(window).height()) - 10 < parseInt(height)) height = parseInt($(window).height()) - 10;
                var top  = ((parseInt($(window).height()) - parseInt(height)) / 2) * 0.8;
                var left = (parseInt($(window).width()) - parseInt(width)) / 2;
                // resize there
                $('#w2ui-popup'+_id+'').css({
                    '-webkit-transition': options.speed + 's width, ' + options.speed + 's height, ' + options.speed + 's left, ' + options.speed + 's top',
                    '-moz-transition': options.speed + 's width, ' + options.speed + 's height, ' + options.speed + 's left, ' + options.speed + 's top',
                    '-ms-transition': options.speed + 's width, ' + options.speed + 's height, ' + options.speed + 's left, ' + options.speed + 's top',
                    '-o-transition': options.speed + 's width, ' + options.speed + 's height, ' + options.speed + 's left, ' + options.speed + 's top',
                    'top': top,
                    'left': left,
                    'width': width,
                    'height': height
                });
                setTimeout(function () {
                    options.width  = width;
                    options.height = height;
                    if (typeof callBack == 'function') callBack();
                }, (options.speed * 1000) + 50); // give extra 50 ms
            },

            resizeInWindow: function(evt) {
                var options = $('#w2ui-popup'+_id+'').data('options');
                if(options === undefined) return;
                var width = options.width;
                var height = options.height;
                var windowWidth = parseInt($(window).width()) - 10;
                var windowHeight = parseInt($(window).height()) - 10;
                // if (parseInt($(window).width())  - 10 < parseInt(width))  width  = parseInt($(window).width())  - 10;
                // if (parseInt($(window).height()) - 10 < parseInt(height)) height = parseInt($(window).height()) - 10;
                var top  = parseInt((parseInt($(window).height()) - parseInt(height)) / 2 * 0.6);
                var left = parseInt((parseInt($(window).width()) - parseInt(width)) / 2);

                $('#w2ui-popup'+_id+'').css({
                    '-webkit-transition': options.speed + 's width, ' + options.speed + 's height, ' + options.speed + 's left, ' + options.speed + 's top',
                    '-moz-transition': options.speed + 's width, ' + options.speed + 's height, ' + options.speed + 's left, ' + options.speed + 's top',
                    '-ms-transition': options.speed + 's width, ' + options.speed + 's height, ' + options.speed + 's left, ' + options.speed + 's top',
                    '-o-transition': options.speed + 's width, ' + options.speed + 's height, ' + options.speed + 's left, ' + options.speed + 's top',
                    'top': top,
                    'left': left,
                    'width': width,
                    'height': height
                });

                setTimeout(function () {
                    options.width  = width;
                    options.height = height;
                    if(typeof options.onResizeWindow === 'function') options.onResizeWindow();
                }, (options.speed * 1000) + 50); // give extra 50 ms
            }
        }
        // merge in event handling
        $.extend(w2popup, w2utils.event);
        w2popup.open(options);
        GLOBAL['w2popup'+_id] = w2popup;
        if(isBindedResizeWindow == false) {
            window.addEventListener('resize', w2popup.resizeInWindow, false);
            isBindedResizeWindow = true;
        }
        id++;
        return w2popup;
    }
    var isBindedResizeWindow = false;

})(this);

// ============================================
// --- Common dialogs

var w2alert = function (msg, title, callBack) {
    if (title == null) title = w2utils.lang('Notification');
    if ($('#w2ui-popup').length > 0 && w2popup.status != 'closing') {
        w2popup.message({
            width   : 400,
            height  : 170,
            html    : '<div style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 45px; overflow: auto" role="alert">' +
                      '        <div class="w2ui-centered" style="font-size: 13px;">' + msg + '</div>' +
                      '</div>' +
                      '<div style="position: absolute; bottom: 7px; left: 0px; right: 0px; text-align: center; padding: 5px">' +
                      '        <button onclick="w2popup.message();" class="w2ui-popup-btn btn">' + w2utils.lang('Ok') + '</button>' +
                      '</div>',
            onClose : function () {
                if (typeof callBack == 'function') callBack();
            }
        });
    } else {
        w2popup.open({
            width     : 450,
            height    : 220,
            showMax   : false,
            showClose : false,
            title     : title,
            body      : '<div class="w2ui-centered" style="font-size: 13px;" role="alert">' + msg + '</div>',
            buttons   : '<button onclick="w2popup.close();" class="w2ui-popup-btn btn">' + w2utils.lang('Ok') + '</button>',
            onClose   : function () {
                if (typeof callBack == 'function') callBack();
            }
        });
    }
};

var w2confirm = function (msg, title, callBack) {
    var options  = {};
    var defaults = {
        msg         : '',
        title       : w2utils.lang('Confirmation'),
        width       : ($('#w2ui-popup').length > 0 ? 400 : 450),
        height      : ($('#w2ui-popup').length > 0 ? 170 : 220),
        yes_text    : 'Yes',
        yes_class   : '',
        yes_style   : '',
        yes_callBack: null,
        no_text     : 'No',
        no_class    : '',
        no_style    : '',
        no_callBack : null,
        callBack    : null
    };
    if (arguments.length == 1 && typeof msg == 'object') {
        $.extend(options, defaults, msg);
    } else {
        if (typeof title == 'function') {
            $.extend(options, defaults, {
                msg     : msg,
                callBack: title
            })
        } else {
            $.extend(options, defaults, {
                msg     : msg,
                title   : title,
                callBack: callBack
            })
        }
    }
    if ($('#w2ui-popup').length > 0 && w2popup.status != 'closing') {
        if (options.width > w2popup.get().width) options.width = w2popup.get().width;
        if (options.height > (w2popup.get().height - 50)) options.height = w2popup.get().height - 50;
          w2popup.message({
            width   : options.width,
            height  : options.height,
            html    : '<div style="position: absolute; top: 0px; left: 0px; right: 0px; bottom: 40px; overflow: auto">' +
                      '        <div class="w2ui-centered" style="font-size: 13px;">' + options.msg + '</div>' +
                      '</div>' +
                      '<div style="position: absolute; bottom: 7px; left: 0px; right: 0px; text-align: center; padding: 5px">' +
                      '        <button id="Yes" class="w2ui-popup-btn btn '+ options.yes_class +'" style="'+ options.yes_style +'">' + w2utils.lang(options.yes_text) + '</button>' +
                      '        <button id="No" class="w2ui-popup-btn btn '+ options.no_class +'" style="'+ options.no_style +'">' + w2utils.lang(options.no_text) + '</button>' +
                      '</div>',
            onOpen: function () {
                $('#w2ui-popup .w2ui-popup-message .btn').on('click', function (event) {
                    w2popup.message();
                    if (typeof options.callBack == 'function') options.callBack(event.target.id);
                    if (event.target.id == 'Yes' && typeof options.yes_callBack == 'function') options.yes_callBack();
                    if (event.target.id == 'No'  && typeof options.no_callBack == 'function') options.no_callBack();
                });
            },
            onKeydown: function (event) {
                switch (event.originalEvent.keyCode) {
                    case 13: // enter
                        if (typeof options.callBack == 'function') options.callBack('Yes');
                        if (typeof options.yes_callBack == 'function') options.yes_callBack();
                        w2popup.message();
                        break
                    case 27: // esc
                        if (typeof options.callBack == 'function') options.callBack('No');
                        if (typeof options.no_callBack == 'function') options.no_callBack();
                        w2popup.message();
                        break
                }
            }
        });

    } else {

        if (!w2utils.isInt(options.height)) options.height = options.height + 50;
        w2popup.open({
            width      : options.width,
            height     : options.height,
            title      : options.title,
            modal      : true,
            showClose  : false,
            body       : '<div class="w2ui-centered" style="font-size: 13px;">' + options.msg + '</div>',
            buttons    : '<button id="Yes" class="w2ui-popup-btn btn '+ options.yes_class +'" style="'+ options.yes_style +'">'+ w2utils.lang(options.yes_text) +'</button>'+
                         '<button id="No" class="w2ui-popup-btn btn '+ options.no_class +'" style="'+ options.no_style +'">'+ w2utils.lang(options.no_text) +'</button>',
            onOpen: function (event) {
                event.onComplete = function () {
                    $('#w2ui-popup .w2ui-popup-btn').on('click', function (event) {
                        w2popup.close();
                        if (typeof options.callBack == 'function') options.callBack(event.target.id);
                        if (event.target.id == 'Yes' && typeof options.yes_callBack == 'function') options.yes_callBack();
                        if (event.target.id == 'No'  && typeof options.no_callBack == 'function') options.no_callBack();
                    });
                }
            },
            onKeydown: function (event) {
                switch (event.originalEvent.keyCode) {
                    case 13: // enter
                        if (typeof options.callBack == 'function') options.callBack('Yes');
                        if (typeof options.yes_callBack == 'function') options.yes_callBack();
                        w2popup.close();
                        break
                    case 27: // esc
                        if (typeof options.callBack == 'function') options.callBack('No');
                        if (typeof options.no_callBack == 'function') options.no_callBack();
                        w2popup.close();
                        break
                }
            }
        });
    }

    return {
        yes: function (fun) {
            options.yes_callBack = fun;
            return this;
        },
        no: function (fun) {
            options.no_callBack = fun;
            return this;
        }
    };
};

var w2uiAlertLock= {
    embed : undefined,
    start : '<div id="w2ui-alert-lock" onmousewheel="if (event.stopPropagation) event.stopPropagation(); else event.cancelBubble = true; if (event.preventDefault) event.preventDefault(); else return false;" style="position: fixed; z-index: 2000; left: 0px; top: 0px; padding: 0px; margin: 0px; width: 100%; height: 100%; -webkit-transition: 0.1s; transition: 0.1s; background-color: rgb(0, 0, 0);',
    end : '"></div>',

    tag: function() {
        var opacity = this.embed ? 0 : 0.4;
        return this.start + "opacity:" + opacity + this.end;
    }
};

function w2uiAlertLockShow() {
    if ($('#w2ui-alert-lock').length > 0) return false;

    $('body').append(w2uiAlertLock.tag());
}

function w2uiAlertLockHide() {
    $('#w2ui-alert-lock').remove();
}

function w2uiConfirm(title, message, done) {
    w2uiAlertLockShow();
    w2uiDialog(title, message, { confirm: true } , done);

}
function w2uiAlert(title, message, isError, done) {
    w2uiAlertLockShow();
    w2uiDialog(title, message, { alert: true, error: isError }, done);
}

function w2uiDialogClose(ok) {
    $('#w2ui-alert-dialog').remove();
    w2uiAlertLockHide();
    w2uiDialogClose.done(ok);
}

function w2uiDialog(title, message, option, done) {
    done = done || function() {};
    w2uiDialogClose.done = done;

    if (window.innerHeight == undefined) {
        var width  = document.documentElement.offsetWidth;
        var height = document.documentElement.offsetHeight;
        if (w2utils.engine === 'IE7') { width += 21; height += 4; }
    } else {
        var width  = window.innerWidth;
        var height = window.innerHeight;
    }

    //dialogWidth = Math.max(Math.floor(width * 0.21), 100);
    dialogWidth = 385;
    dialogLeft = Math.floor((width - dialogWidth) / 2);
    if (w2uiAlertLock.embed) {
        dialogTop = Math.floor(height * 0.15);
    } else {
        dialogTop = Math.floor(height * 0.3);
    }
    message = message || "메시지 없음";
    message = message.replace(/\n/g, '<br/>');

    var alertDialog =
        '<div id="w2ui-alert-dialog" role="alertdialog" aria-labelledby="alertDialogTitle" class="w2ui-popup" style="z-index:2400; opacity: 1; margin:auto; width:384px; height:inherit;' + ' left:' + dialogLeft + 'px; top:' + dialogTop + 'px; ' + '">' +
    '   <div class="w2ui-alert-dialog-title" style="text-align:center"><span id="alertDialogTitle">'+ title + '</span></div>' +
    '   <div class="w2ui-alert-dialog-title-bar"><span></div>' +
    '   <div class="w2ui-alert-dialog-body-block" role="document">'+
    '       <img src="images/'+ (option.isError ? 'error.png' : 'alert.png') + '" ' +
                'alt="'+ (option.isError ? '에러 이미지' : '경고 이미지') + '">' +
    '       <p>' + message + '</p>'+
    '   </div>' +
    '   <div class="w2ui-alert-dialog-buttons">' +
        (option.alert? '<button onclick="w2uiDialogClose(true); return false;" tabindex="100">'+ w2uiAlert.okStr+'</button>' :
                    '<button onclick="w2uiDialogClose(false); return false;" tabindex="101">' + w2uiAlert.cancelStr + '</button><button onclick="w2uiDialogClose(true); return false;" tabindex="100">' + w2uiAlert.okStr + '</button>') +

    '   </div>' +
    '</div>';
    $('body').append(alertDialog);
    setTimeout(function() {
        $('#w2ui-alert-dialog button').focus();
    });
}

/************************************************************************
*   Library: Web 2.0 UI for jQuery (using prototypical inheritance)
*   - Following objects defined
*        - w2tabs        - tabs widget
*        - $().w2tabs    - jQuery wrapper
*   - Dependencies: jQuery, w2utils
*
* == NICE TO HAVE ==
*   - on overflow display << >>
*
************************************************************************/

(function () {
    var w2tabs = function (options) {
        this.box       = null;      // DOM Element that holds the element
        this.name      = null;      // unique name for w2ui
        this.active    = null;
        this.tabs      = [];
        this.routeData = {};        // data for dynamic routes
        this.right     = '';
        this.style     = '';
        this.onClick   = null;
        this.onClose   = null;
        this.onRender  = null;
        this.onRefresh = null;
        this.onResize  = null;
        this.onDestroy = null;

        $.extend(this, { handlers: [] });
        $.extend(true, this, w2obj.tabs, options);
    };

    // ====================================================
    // -- Registers as a jQuery plugin

    $.fn.w2tabs = function(method) {
        if (typeof method === 'object' || !method ) {
            // check name parameter
            if (!w2utils.checkName(method, 'w2tabs')) return;
            // extend tabs
            var tabs   = method.tabs || [];
            var object = new w2tabs(method);
            for (var i = 0; i < tabs.length; i++) {
                object.tabs[i] = $.extend({}, w2tabs.prototype.tab, tabs[i]);
            }
            if ($(this).length !== 0) {
                object.render($(this)[0]);
            }
            // register new object
            w2ui[object.name] = object;
            return object;
        } else if (w2ui[$(this).attr('name')]) {
            var obj = w2ui[$(this).attr('name')];
            obj[method].apply(obj, Array.prototype.slice.call(arguments, 1));
            return this;
        } else {
            console.log('ERROR: Method ' +  method + ' does not exist on jQuery.w2tabs' );
            return undefined;
        }
    };

    // ====================================================
    // -- Implementation of core functionality

    w2tabs.prototype = {
        tab : {
            id        : null,        // command to be sent to all event handlers
            text      : '',
            route     : null,
            hidden    : false,
            disabled  : false,
            closable  : false,
            hint      : '',
            onClick   : null,
            onRefresh : null,
            onClose   : null
        },

        add: function (tab) {
            return this.insert(null, tab);
        },

        insert: function (id, tab) {
            if (!$.isArray(tab)) tab = [tab];
            // assume it is array
            for (var i = 0; i < tab.length; i++) {
                // checks
                if (typeof tab[i].id === 'undefined') {
                    console.log('ERROR: The parameter "id" is required but not supplied. (obj: '+ this.name +')');
                    return;
                }
                if (!w2utils.checkUniqueId(tab[i].id, this.tabs, 'tabs', this.name)) return;
                // add tab
                var newTab = $.extend({}, w2tabs.prototype.tab, tab[i]);
                if (id === null || typeof id === 'undefined') {
                    this.tabs.push(newTab);
                } else {
                    var middle = this.get(id, true);
                    this.tabs = this.tabs.slice(0, middle).concat([newTab], this.tabs.slice(middle));
                }
                this.refresh(tab[i].id);
            }
        },

        remove: function () {
            var removed = 0;
            for (var a = 0; a < arguments.length; a++) {
                var tab = this.get(arguments[a]);
                if (!tab) return false;
                removed++;
                // remove from array
                this.tabs.splice(this.get(tab.id, true), 1);
                // remove from screen
                $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(tab.id)).remove();
            }
            return removed;
        },

        select: function (id) {
            if (this.active == id || this.get(id) === null) return false;
            this.active = id;
            this.refresh();
            return true;
        },

        set: function (id, tab) {
            var index = this.get(id, true);
            if (index === null) return false;
            $.extend(this.tabs[index], tab);
            this.refresh(id);
            return true;
        },

        get: function (id, returnIndex) {
            if (arguments.length === 0) {
                var all = [];
                for (var i1 = 0; i1 < this.tabs.length; i1++) {
                    if (this.tabs[i1].id != null) {
                        all.push(this.tabs[i1].id);
                    }
                }
                return all;
            } else {
                for (var i2 = 0; i2 < this.tabs.length; i2++) {
                    if (this.tabs[i2].id == id) { // need to be == since id can be numeric
                        return (returnIndex === true ? i2 : this.tabs[i2]);
                    }
                }
            }
            return null;
        },

        show: function () {
            var obj   = this;
            var shown = 0;
            var tmp   = [];
            for (var a = 0; a < arguments.length; a++) {
                var tab = this.get(arguments[a]);
                if (!tab || tab.hidden === false) continue;
                shown++;
                tab.hidden = false;
                tmp.push(tab.id);
            }
            setTimeout(function () { for (var t in tmp) obj.refresh(tmp[t]); }, 15); // needs timeout 
            return shown;
        },

        hide: function () {
            var obj   = this;
            var hidden= 0;
            var tmp   = [];
            for (var a = 0; a < arguments.length; a++) {
                var tab = this.get(arguments[a]);
                if (!tab || tab.hidden === true) continue;
                hidden++;
                tab.hidden = true;
                tmp.push(tab.id);
            }
            setTimeout(function () { for (var t in tmp) obj.refresh(tmp[t]); }, 15); // needs timeout 
            return hidden;
        },

        enable: function () {
            var obj   = this;
            var enabled = 0;
            var tmp   = [];
            for (var a = 0; a < arguments.length; a++) {
                var tab = this.get(arguments[a]);
                if (!tab || tab.disabled === false) continue;
                enabled++;
                tab.disabled = false;
                tmp.push(tab.id);
            }
            setTimeout(function () { for (var t in tmp) obj.refresh(tmp[t]); }, 15); // needs timeout 
            return enabled;
        },

        disable: function () {
            var obj   = this;
            var disabled = 0;
            var tmp   = [];
            for (var a = 0; a < arguments.length; a++) {
                var tab = this.get(arguments[a]);
                if (!tab || tab.disabled === true) continue;
                disabled++;
                tab.disabled = true;
                tmp.push(tab.id);
            }
            setTimeout(function () { for (var t in tmp) obj.refresh(tmp[t]); }, 15); // needs timeout 
            return disabled;
        },

        refresh: function (id) {
            var time = (new Date()).getTime();
            // if (window.getSelection) window.getSelection().removeAllRanges(); // clear selection
            // event before
            var eventData = this.trigger({ phase: 'before', type: 'refresh', target: (typeof id !== 'undefined' ? id : this.name), object: this.get(id) });
            if (eventData.isCancelled === true) return;
            if (typeof id === 'undefined') {
                // refresh all
                for (var i = 0; i < this.tabs.length; i++) this.refresh(this.tabs[i].id);
            } else {
                // create or refresh only one item
                var tab = this.get(id);
                if (tab === null) return false;
                if (typeof tab.caption !== 'undefined') tab.text = tab.caption;

                var jq_el   = $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(tab.id));
                var tabHTML = (tab.closable ? '<div class="w2ui-tab-close" onclick="w2ui[\''+ this.name +'\'].animateClose(\''+ tab.id +'\', event);"></div>' : '') +
                    '    <div class="w2ui-tab'+ (this.active === tab.id ? ' active' : '') + (tab.closable ? ' closable' : '') +'" '+
                    '        title="'+ (typeof tab.hint !== 'undefined' ? tab.hint : '') +'"'+
                    '        onclick="w2ui[\''+ this.name +'\'].click(\''+ tab.id +'\', event);" role="button">' + tab.text + '</div>';
                if (jq_el.length === 0) {
                    // does not exist - create it
                    var addStyle = '';
                    if (tab.hidden) { addStyle += 'display: none;'; }
                    if (tab.disabled) { addStyle += 'opacity: 0.2; -moz-opacity: 0.2; -webkit-opacity: 0.2; -o-opacity: 0.2; filter:alpha(opacity=20);'; }
                    var html = '<td id="tabs_'+ this.name + '_tab_'+ tab.id +'" style="'+ addStyle +'" valign="middle">'+ tabHTML + '</td>';
                    if (this.get(id, true) !== this.tabs.length-1 && $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(this.tabs[parseInt(this.get(id, true))+1].id)).length > 0) {
                        $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(this.tabs[parseInt(this.get(id, true))+1].id)).before(html);
                    } else {
                        $(this.box).find('#tabs_'+ this.name +'_right').before(html);
                    }
                } else {
                    // refresh
                    jq_el.html(tabHTML);
                    if (tab.hidden) { jq_el.css('display', 'none'); }
                    else { jq_el.css('display', ''); }
                    if (tab.disabled) { jq_el.css({ 'opacity': '0.2', '-moz-opacity': '0.2', '-webkit-opacity': '0.2', '-o-opacity': '0.2', 'filter': 'alpha(opacity=20)' }); }
                    else { jq_el.css({ 'opacity': '1', '-moz-opacity': '1', '-webkit-opacity': '1', '-o-opacity': '1', 'filter': 'alpha(opacity=100)' }); }
                }
            }
            // right html
            $('#tabs_'+ this.name +'_right').html(this.right);
            // event after
            this.trigger($.extend(eventData, { phase: 'after' }));
            return (new Date()).getTime() - time;
        },

        render: function (box) {
            var time = (new Date()).getTime();
            // event before
            var eventData = this.trigger({ phase: 'before', type: 'render', target: this.name, box: box });
            if (eventData.isCancelled === true) return;
            // default action
            // if (window.getSelection) window.getSelection().removeAllRanges(); // clear selection
            if (typeof box !== 'undefined' && box !== null) {
                if ($(this.box).find('> table #tabs_'+ this.name + '_right').length > 0) {
                    $(this.box)
                        .removeAttr('name')
                        .removeClass('w2ui-reset w2ui-tabs')
                        .html('');
                }
                this.box = box;
            }
            if (!this.box) return false;
            // render all buttons
            var html =    '<table cellspacing="0" cellpadding="1" width="100%">'+
                        '    <tr><td width="100%" id="tabs_'+ this.name +'_right" align="right">'+ this.right +'</td></tr>'+
                        '</table>';
            $(this.box)
                .attr('name', this.name)
                .addClass('w2ui-reset w2ui-tabs')
                .html(html);
            if ($(this.box).length > 0) $(this.box)[0].style.cssText += this.style;
            // event after
            this.trigger($.extend(eventData, { phase: 'after' }));
            this.refresh();
            return (new Date()).getTime() - time;
        },

        resize: function () {
            var time = (new Date()).getTime();
            // event before
            var eventData = this.trigger({ phase: 'before', type: 'resize', target: this.name });
            if (eventData.isCancelled === true) return;

            // intentionaly blank

            // event after
            this.trigger($.extend(eventData, { phase: 'after' }));
            return (new Date()).getTime() - time;
        },

        destroy: function () {
            // event before
            var eventData = this.trigger({ phase: 'before', type: 'destroy', target: this.name });
            if (eventData.isCancelled === true) return;
            // clean up
            if ($(this.box).find('> table #tabs_'+ this.name + '_right').length > 0) {
                $(this.box)
                    .removeAttr('name')
                    .removeClass('w2ui-reset w2ui-tabs')
                    .html('');
            }
            delete w2ui[this.name];
            // event after
            this.trigger($.extend(eventData, { phase: 'after' }));
        },

        // ===================================================
        // -- Internal Event Handlers

        click: function (id, event) {
            var tab = this.get(id);
            if (tab === null || tab.disabled) return false;
            // event before
            var eventData = this.trigger({ phase: 'before', type: 'click', target: id, tab: tab, object: tab, originalEvent: event });
            if (eventData.isCancelled === true) return;
            // default action
            $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(this.active) +' .w2ui-tab').removeClass('active');
            this.active = tab.id;
            // route processing
            if (tab.route) {
                var route = String('/'+ tab.route).replace(/\/{2,}/g, '/');
                var info  = w2utils.parseRoute(route);
                if (info.keys.length > 0) {
                    for (var k = 0; k < info.keys.length; k++) {
                        if (this.routeData[info.keys[k].name] == null) continue;
                        route = route.replace((new RegExp(':'+ info.keys[k].name, 'g')), this.routeData[info.keys[k].name]);
                    }
                }
                setTimeout(function () { window.location.hash = route; }, 1);
            }
            // event after
            this.trigger($.extend(eventData, { phase: 'after' }));
            this.refresh(id);
        },

        animateClose: function(id, event) {
            var tab = this.get(id);
            if (tab === null || tab.disabled) return false;
            // event before
            var eventData = this.trigger({ phase: 'before', type: 'close', target: id, object: this.get(id), originalEvent: event });
            if (eventData.isCancelled === true) return;
            // default action
            var obj = this;
            $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(tab.id)).css({
                '-webkit-transition': '.2s',
                '-moz-transition': '2s',
                '-ms-transition': '.2s',
                '-o-transition': '.2s',
                opacity: '0' });
            setTimeout(function () {
                var width = $(obj.box).find('#tabs_'+ obj.name +'_tab_'+ w2utils.escapeId(tab.id)).width();
                $(obj.box).find('#tabs_'+ obj.name +'_tab_'+ w2utils.escapeId(tab.id))
                    .html('<div style="width: '+ width +'px; -webkit-transition: .2s; -moz-transition: .2s; -ms-transition: .2s; -o-transition: .2s"></div>');
                setTimeout(function () {
                    $(obj.box).find('#tabs_'+ obj.name +'_tab_'+ w2utils.escapeId(tab.id)).find(':first-child').css({ 'width': '0px' });
                }, 50);
            }, 200);
            setTimeout(function () {
                obj.remove(id);
            }, 450);
            // event before
            this.trigger($.extend(eventData, { phase: 'after' }));
            this.refresh();
        },

        animateInsert: function(id, tab) {
            if (this.get(id) === null) return;
            if (!$.isPlainObject(tab)) return;
            // check for unique
            if (!w2utils.checkUniqueId(tab.id, this.tabs, 'tabs', this.name)) return;
            // insert simple div
            var jq_el   = $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(tab.id));
            if (jq_el.length !== 0) return; // already exists
            // measure width
            if (typeof tab.caption !== 'undefined') tab.text = tab.caption;
            var tmp = '<div id="_tmp_tabs" class="w2ui-reset w2ui-tabs" style="position: absolute; top: -1000px;">'+
                '<table cellspacing="0" cellpadding="1" width="100%"><tr>'+
                '<td id="_tmp_simple_tab" style="" valign="middle">'+
                    (tab.closable ? '<div class="w2ui-tab-close"></div>' : '') +
                '    <div class="w2ui-tab '+ (this.active === tab.id ? 'active' : '') +'">'+ tab.text +'</div>'+
                '</td></tr></table>'+
                '</div>';
            $('body').append(tmp);
            // create dummy element
            var tabHTML = '<div style="width: 1px; -webkit-transition: 0.2s; -moz-transition: 0.2s; -ms-transition: 0.2s; -o-transition: 0.2s;">&nbsp;</div>';
            var addStyle = '';
            if (tab.hidden) { addStyle += 'display: none;'; }
            if (tab.disabled) { addStyle += 'opacity: 0.2; -moz-opacity: 0.2; -webkit-opacity: 0.2; -o-opacity: 0.2; filter:alpha(opacity=20);'; }
            var html = '<td id="tabs_'+ this.name +'_tab_'+ tab.id +'" style="'+ addStyle +'" valign="middle">'+ tabHTML +'</td>';
            if (this.get(id, true) !== this.tabs.length && $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(this.tabs[parseInt(this.get(id, true))].id)).length > 0) {
                $(this.box).find('#tabs_'+ this.name +'_tab_'+ w2utils.escapeId(this.tabs[parseInt(this.get(id, true))].id)).before(html);
            } else {
                $(this.box).find('#tabs_'+ this.name +'_right').before(html);
            }
            // -- move
            var obj = this;
            setTimeout(function () {
                var width = $('#_tmp_simple_tab').width();
                $('#_tmp_tabs').remove();
                $('#tabs_'+ obj.name +'_tab_'+ w2utils.escapeId(tab.id) +' > div').css('width', width+'px');
            }, 1);
            setTimeout(function () {
                // insert for real
                obj.insert(id, tab);
            }, 200);
        }
    };

    $.extend(w2tabs.prototype, w2utils.event);
    w2obj.tabs = w2tabs;
})();

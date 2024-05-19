/*global $, window*/
$.fn.editableTableWidget = function (options) {
    'use strict';
    return $(this).each(function () {
        var buildDefaultOptions = function () {
                var opts = $.extend({}, $.fn.editableTableWidget.defaultOptions);
                opts.editor = opts.editor.clone();
                return opts;
            },
            activeOptions = $.extend(buildDefaultOptions(), options),
            ARROW_LEFT = 37, ARROW_UP = 38, ARROW_RIGHT = 39, ARROW_DOWN = 40, ENTER = 13, ESC = 27, TAB = 9,
            element = $(this),
            editor = activeOptions.editor.css('position', 'absolute').hide().appendTo(element.parent()),
            active,
            showEditor = function (select) {
                active = element.find('td:focus');
                if (active.length && active.attr('name') !== 'dontedit') {
                    editor.val(active.text())
                        .removeClass('error')
                        .show()
                        .offset(active.offset())
                        .css(active.css(activeOptions.cloneProperties))
                        .width(active.width())
                        .height(active.height())
                        .focus();
                    if (select) {
                        editor.select();
                    }
                }
            },
            setActiveText = function () {
                var text = editor.val(),
                    evt = $.Event('change'),
                    originalContent;
                if (active.text() === text || editor.hasClass('error')) {
                    return true;
                }
                originalContent = active.html();
                console.log("Original Content:", originalContent);
                console.log("Text:", text);

                active.text(text);
                if (evt.result === false) {
                    active.html(originalContent);
                } else if (window.location.pathname.includes('/inventory/list') || window.location.pathname.includes('/publisher/list') || window.location.pathname.includes('/product/list')) {
                    var currentPagePath = window.location.pathname;
                    console.log("Current Page Path:", currentPagePath);
                    var pathSegments = currentPagePath.split('/');
                    console.log("Path Segments:", pathSegments);

                    var rocketIndex = pathSegments.indexOf("GJD71_rocket_final");

                    var parentTableName = rocketIndex !== -1 && pathSegments.length > rocketIndex + 2 ? pathSegments[rocketIndex + 2] : pathSegments[2];


                    console.log("ParentTable Name:", parentTableName.toUpperCase());

                    var updateUrl = currentPagePath + '/tableupdate';
                    console.log("Update URL:", updateUrl);
                    var columnName = active.data('column-name');
                    console.log("Column Name:", columnName);
                    var tableName = active.data('table-name');
                    console.log("Table Name:", tableName);
                    var parentColumnName = active.data('parent-column');
                    console.log("parent-column:", parentColumnName);


                    var updateUrl;
                    if (currentPagePath.includes('/inventory/list') || window.location.pathname.includes('/publisher/list') || window.location.pathname.includes('/product/list')) {
                        updateUrl = currentPagePath + '/tableupdate';

                        $.ajax({

                            url: updateUrl,
                            method: 'POST',
                            data: {
                                id: active.closest('tr').find('td:first').text(), // 첫 번째 셀의 텍스트(ID)
                                columnName: columnName,
                                value: text,
                                tableName: tableName,
                                parentTableName: parentTableName,
                                parentColumnName: parentColumnName
                            },
                            success: function (response) {
                                alert(response);
                                active.text(text).trigger(evt, text);

                            },
                            error: function (jqXHR, textStatus, errorThrown, error, response, body) {

                                /*alert(jqXHR.responseText);*/
                                /*  alert((JSON.stringify(error)));*/
                                alert(jqXHR.responseText);
                                /*alert(xhr.responseText);*/
                                /* alert(JSON.stringify(response));*/
                                active.html(originalContent);
                            }
                        });

                    } else {
                        // updateUrl = currentPagePath + '/differentUpdate';
                    }

                }
            },
            movement = function (element, keycode) {
                if (keycode === ARROW_RIGHT) {
                    return element.next('td');
                } else if (keycode === ARROW_LEFT) {
                    return element.prev('td');
                } else if (keycode === ARROW_UP) {
                    return element.parent().prev().children().eq(element.index());
                } else if (keycode === ARROW_DOWN) {
                    return element.parent().next().children().eq(element.index());
                }
                return [];
            };
        editor.blur(function () {
            setActiveText();
            editor.hide();
        }).keydown(function (e) {
            if (e.which === ENTER) {
                setActiveText();
                editor.hide();
                active.focus();
                e.preventDefault();
                e.stopPropagation();
            } else if (e.which === ESC) {
                editor.val(active.text());
                e.preventDefault();
                e.stopPropagation();
                editor.hide();
                active.focus();
            } else if (e.which === TAB) {
                active.focus();
            } else if (this.selectionEnd - this.selectionStart === this.value.length) {
                var possibleMove = movement(active, e.which);
                if (possibleMove.length > 0) {
                    possibleMove.focus();
                    e.preventDefault();
                    e.stopPropagation();
                }
            }
        })
            .on('input paste', function () {
                var evt = $.Event('validate');
                active.trigger(evt, editor.val());
                if (evt.result === false) {
                    editor.addClass('error');
                } else {
                    editor.removeClass('error');
                }
            });
        element.on('click keypress dblclick', showEditor)
            .css('cursor', 'pointer')
            .keydown(function (e) {
                var prevent = true,
                    possibleMove = movement($(e.target), e.which);
                if (possibleMove.length > 0) {
                    possibleMove.focus();
                } else if (e.which === ENTER) {
                    showEditor(false);
                } else if (e.which === 17 || e.which === 91 || e.which === 93) {
                    showEditor(true);
                    prevent = false;
                } else {
                    prevent = false;
                }
                if (prevent) {
                    e.stopPropagation();
                    e.preventDefault();
                }
            });

        element.find('td').prop('tabindex', 1);

        $(window).on('resize', function () {
            if (editor.is(':visible')) {
                editor.offset(active.offset())
                    .width(active.width())
                    .height(active.height());
            }
        });
    });

};
$.fn.editableTableWidget.defaultOptions = {
    cloneProperties: ['padding', 'padding-top', 'padding-bottom', 'padding-left', 'padding-right',
        'text-align', 'font', 'font-size', 'font-family', 'font-weight',
        'border', 'border-top', 'border-bottom', 'border-left', 'border-right'],
    editor: $('<input>')
};


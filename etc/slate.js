'use strict';
/*global slate:true, Grid:true */

slate.configAll({
  defaultToCurrentScreen: true,
  nudgePercentOf: "screenSize",
  resizePercentOf: "screenSize",
  secondsBetweenRepeat: 0.1,
  checkDefaultsOnLoad: true,
  focusCheckWidthMax: 3000,

  windowHintsIgnoreHiddenWindows: false,
  windowHintsShowIcons: true,
  windowHintsSpread: true,
  windowHintsRoundedCornerSize: 10,
  windowHintsSpreadSearchWidth: 200,
  windowHintsSpreadSearchHeight: 200
});

// load our grid
slate.source('~/.slate.grid.js');

// load our layouts
slate.source('~/.slate.layouts.js');

// create a grid for nudging and such
var grid = new Grid(12, {
  bottomAdjust: 22,     // adjust bottom positioning for the title bar
  titleBarAdjust: 22    // when stacking windows drop them so the title bar shows
});

slate.bind('esc:cmd', slate.operationFromString('hint'));
// slate.bind('`:cmd', slate.operationFromString('grid'));

var nudgeWindow = function(opts) {
  return function(window) {
    opts.screen = window.screen().id();
    var op = slate.operation('nudge', grid.move(opts));
    window.doOperation(op);
  };
};

var resizeWindow = function(opts) {
  return function(window) {
    opts.screen = window.screen().id();
    var op = slate.operation('resize', grid.size(opts));
    window.doOperation(op);
  };
};

// moving around on the grid
slate.bind('right:ctrl;alt', nudgeWindow({x: '+1'}));
slate.bind('left:ctrl;alt', nudgeWindow({x: '-1'}));
slate.bind('up:ctrl;alt', nudgeWindow({y: '-1'}));
slate.bind('down:ctrl;alt', nudgeWindow({y: '+1'}));

// resizing windows to the grid
slate.bind('right:ctrl;alt;cmd', resizeWindow({width: '+1'}));
slate.bind('left:ctrl;alt;cmd', resizeWindow({width: '-1'}));
slate.bind('up:ctrl;alt;cmd', resizeWindow({height: '-1'}));
slate.bind('down:ctrl;alt;cmd', resizeWindow({height: '+1'}));

// focusing around
slate.bind('right:alt;cmd', slate.operation('focus', {direction: 'right'}));
slate.bind('left:alt;cmd', slate.operation('focus', {direction: 'left'}));
slate.bind('up:alt;cmd', slate.operation('focus', {direction: 'up'}));
slate.bind('down:alt;cmd', slate.operation('focus', {direction: 'down'}));

var defaultSnapshotName = 'default-snapshot';
slate.bind('1:shift;ctrl;alt;cmd', slate.operation("snapshot", {
  "name" : defaultSnapshotName,
  "save" : true,
  "stack" : false
}));

slate.bind('1:ctrl;alt;cmd', slate.operation("activate-snapshot", {
  "name" : defaultSnapshotName,
  "delete" : false
}));
